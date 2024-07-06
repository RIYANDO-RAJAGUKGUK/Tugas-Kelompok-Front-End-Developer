import 'package:flutter/material.dart';
import 'package:flutter_application_1/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/login.dart'; // Import your login page

class Settings {
  final String title;
  final String subTitle;

  Settings({required this.title, required this.subTitle});
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  String _selectedNotificationSetting = 'All';
  String _selectedPrivacySetting = 'Public';
  String _language = 'English';

  final List<Settings> privacyEn = [
    Settings(
      title: "Public",
      subTitle: "Everyone can see your posts",
    ),
    Settings(
      title: "Followers Only",
      subTitle: "Only your followers can see your posts",
    ),
    Settings(
      title: "Private",
      subTitle: "Only certain people can see your posts",
    ),
  ];

  final List<Settings> privacyId = [
    Settings(
      title: "Publik",
      subTitle: "Semua orang dapat melihat kiriman Anda",
    ),
    Settings(
      title: "Hanya Pengikut",
      subTitle: "Hanya pengikut Anda yang dapat melihat kiriman Anda",
    ),
    Settings(
      title: "Pribadi",
      subTitle: "Hanya orang-orang tertentu yang dapat melihat kiriman Anda",
    ),
  ];

  final List<Settings> notificationsEn = [
    Settings(
      title: "All",
      subTitle: "Receive notifications for all activities, including new followers, likes, and comments",
    ),
    Settings(
      title: "Important",
      subTitle: "Get notified only for important interactions, such as direct messages and mentions",
    ),
    Settings(
      title: "None",
      subTitle: "You won't be disturbed by any notifications from the app",
    ),
  ];

  final List<Settings> notificationsId = [
    Settings(
      title: "Semua",
      subTitle: "Menerima notifikasi untuk semua aktivitas, termasuk pengikut baru, suka, dan komentar",
    ),
    Settings(
      title: "Penting",
      subTitle: "Hanya diberi tahu untuk interaksi penting, seperti pesan langsung dan sebutan",
    ),
    Settings(
      title: "Tidak Ada",
      subTitle: "Anda tidak akan terganggu oleh notifikasi apa pun dari aplikasi ini",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _selectedNotificationSetting = prefs.getString('notificationSetting') ?? 'All';
      _selectedPrivacySetting = prefs.getString('privacySetting') ?? 'Public';
      _language = prefs.getString('language') ?? 'English';
    });
  }

  void _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notificationsEnabled', _notificationsEnabled);
    prefs.setString('notificationSetting', _selectedNotificationSetting);
    prefs.setString('privacySetting', _selectedPrivacySetting);
    prefs.setString('language', _language);
  }

  void _changeLanguage(String? newLanguage) {
    if (newLanguage != null) {
      setState(() {
        _language = newLanguage;
        _saveSettings();
      });
    }
  }

  void _changeNotificationSetting(String? newSetting) {
    if (newSetting != null) {
      setState(() {
        _selectedNotificationSetting = newSetting;
        _saveSettings();
      });
    }
  }

  void _changePrivacySetting(String? newSetting) {
    if (newSetting != null) {
      setState(() {
        _selectedPrivacySetting = newSetting;
        _saveSettings();
      });
    }
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); 
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        List<Settings> currentPrivacySettings = _language == 'English' ? privacyEn : privacyId;
        List<Settings> currentNotificationSettings = _language == 'English' ? notificationsEn : notificationsId;

        String enableNotificationsText = _language == 'English' ? 'Enable Notifications' : 'Aktifkan Notifikasi';
        String languageText = _language == 'English' ? 'Language' : 'Bahasa';
        String notificationsText = _language == 'English' ? 'Notifications' : 'Notifikasi';
        String privacyText = _language == 'English' ? 'Privacy' : 'Privasi';

        return Scaffold(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                SwitchListTile(
                  title: Text(enableNotificationsText),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                      _saveSettings();
                    });
                  },
                ),
                ListTile(
                  title: Text(languageText),
                  subtitle: Text(_language),
                  trailing: DropdownButton<String>(
                    value: _language,
                    onChanged: _changeLanguage,
                    items: const [
                      DropdownMenuItem(
                        value: 'English',
                        child: Text('English'),
                      ),
                      DropdownMenuItem(
                        value: 'Bahasa Indonesia',
                        child: Text('Bahasa Indonesia'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  notificationsText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: currentNotificationSettings.map((setting) {
                    return RadioListTile<String>(
                      title: Text(setting.title),
                      subtitle: Text(setting.subTitle),
                      value: setting.title,
                      groupValue: _selectedNotificationSetting,
                      onChanged: _changeNotificationSetting,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Text(
                  privacyText,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  children: currentPrivacySettings.map((setting) {
                    return RadioListTile<String>(
                      title: Text(setting.title),
                      subtitle: Text(setting.subTitle),
                      value: setting.title,
                      groupValue: _selectedPrivacySetting,
                      onChanged: _changePrivacySetting,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _logout,
                  child: Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
