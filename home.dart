import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart.dart';
import 'package:flutter_application_1/models/groceries_data.dart';
import 'package:flutter_application_1/pembayaran.dart';
import 'package:flutter_application_1/profile_provider.dart';
import 'package:flutter_application_1/riwayat_pemesana.dart';
import 'package:flutter_application_1/setting.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/theme.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = [
    Tampilan(),
    CartPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Home', 
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Cart', 
              child: Icon(Icons.shopping_cart),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Tooltip(
              message: 'Profile', 
              child: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class Tampilan extends StatefulWidget {
  const Tampilan({super.key});

  @override
  State<Tampilan> createState() => _TampilanState();
}

class _TampilanState extends State<Tampilan> {
  final TextEditingController _searchController = TextEditingController();
  List<Groceries> _filteredGroceries = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _filteredGroceries = listGridGroceries;
    _searchController.addListener(_filterGroceries);
  }

  void _reloadData() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _filteredGroceries = listGridGroceries;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterGroceries);
    _searchController.dispose();
    super.dispose();
  }

  void _filterGroceries() async {
    final query = _searchController.text.toLowerCase();

    setState(() {
      _filteredGroceries = listGridGroceries.where((groceries) {
        return groceries.name.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _reloadData();
      },
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Stack(
            children: [
              buildBackground(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Gap(68),
                    buildHeader(),
                    const Gap(30),
                    buildSearch(),
                    const Gap(24),
                    buildBannerPromo(),
                  ],
                ),
              ),
            ],
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : buildGridGroceries(),
        ],
      ),
    );
  }

  Widget buildBackground() {
    return Container(
      height: 280,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.grey,
            Colors.lightGreen,
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome to',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            const Text(
              'Groceries Shop',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 168, 168, 168),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black38,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(15),
                      isDense: true,
                      border: InputBorder.none,
                      hintText: 'Search Groceries...',
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        color: Color.fromARGB(255, 116, 114, 114),
                      ),
                      prefixIcon: Tooltip(
                        message: 'Search', 
                        child: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 116, 114, 114),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBannerPromo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[400],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'assets/banner.png',
          width: double.infinity,
          fit: BoxFit.cover,
          height: 200,
        ),
      ),
    );
  }

  Widget buildGridGroceries() {
    return GridView.builder(
      itemCount: _filteredGroceries.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 238,
        crossAxisSpacing: 15,
        mainAxisSpacing: 24,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        Groceries groceries = _filteredGroceries[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'detail', arguments: groceries);
          },
          child: Container(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
            decoration: BoxDecoration(
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        groceries.image,
                        height: 128,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              const Color(0xff111111).withOpacity(0.3),
                              const Color(0xff313131).withOpacity(0.3),
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomLeft: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/bintang.png',
                              height: 12,
                              width: 12,
                            ),
                            const Gap(4),
                            Text(
                              '${groceries.rate}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 8,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  groceries.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Color(0xff242424),
                  ),
                ),
                const Gap(4),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      NumberFormat.currency(
                        decimalDigits: 2,
                        locale: 'en_US',
                        symbol: '\$ ',
                      ).format(groceries.price),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Color(0xff050505),
                      ),
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xffC67C4E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey[850] : Colors.teal.shade50,
        title: const Text(
          'Keranjang',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) {
                    final item = cart.items.keys.elementAt(index);
                    final quantity = cart.items[item]!;
                    return ListTile(
                      leading: Image.asset(
                        item.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Text(NumberFormat.currency(
                        decimalDigits: 2,
                        locale: 'en_US',
                        symbol: '\$ ',
                      ).format(item.price)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              cart.removeItem(item);
                            },
                            tooltip: 'Menghapus',
                          ),
                          Text(quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              cart.addItem(item);
                            },
                            tooltip: 'Menambah',
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              cart.removeProduct(item);
                            },
                            tooltip: 'Buang',
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Harga:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        decimalDigits: 2,
                        locale: 'en_US',
                        symbol: '\$ ',
                      ).format(cart.totalPrice),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PaymentSummaryPage(cart: cart)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 170, 219, 241),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController(); 
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    _nameController.text = profileProvider.name;
    _emailController.text = profileProvider.email;
    _phoneController.text = profileProvider.phone;
    _dobController.text = profileProvider.dob; 
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _dobController.dispose(); 
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama pengguna tidak boleh kosong';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    final phoneRegex = RegExp(r'^\d+$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Nomor telepon tidak valid';
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = '${picked.day}/${picked.month}/${picked.year}'; 
      });
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.updateDob(picked);
    }
  }

  void _editProfileField(TextEditingController controller, String title, String? Function(String?) validator, Function(String) updateFunction) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit $title'),
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Masukkan $title',
              ),
              validator: validator,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updateFunction(controller.text);
                  setState(() {});
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bantuan'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Untuk mengubah informasi profil, tekan ikon edit di sebelah kanan setiap bagian.',
                ),
                SizedBox(height: 10),
                Text(
                  'Anda dapat mengaktifkan atau menonaktifkan Mode Gelap pada bagian bawah halaman.',
                ),
                SizedBox(height: 10),
                Text(
                  'Untuk lebih lanjut mengatur aplikasi, tekan tombol Pengaturan di bagian bawah halaman.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var profileProvider = Provider.of<ProfileProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.teal.shade100,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.grey[850] : Colors.teal.shade50,
        title: const Text(
          'Akun',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              switch (result) {
                case 'Pengaturan':
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsPage()));
                  break;
                case 'Riwayat Pemesanan':
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Riwayat_Pemesanan()));
                  break;
                case 'Bantuan':
                  _showHelpDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Pengaturan',
                child: Text('Pengaturan'),
              ),
              const PopupMenuItem<String>(
                value: 'Riwayat Pemesanan',
                child: Text('Riwayat Pemesanan'),
              ),
              const PopupMenuItem<String>(
                value: 'Bantuan',
                child: Text('Bantuan'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  profileProvider.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profileProvider.email,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  profileProvider.phone,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Nama Lengkap'),
                  subtitle: Text(profileProvider.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editProfileField(
                        _nameController,
                        'Nama Lengkap',
                        _validateName,
                        profileProvider.updateName,
                      );
                    },
                    tooltip: 'Edit Name',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(profileProvider.email),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editProfileField(
                        _emailController,
                        'Email',
                        _validateEmail,
                        profileProvider.updateEmail,
                      );
                    },
                    tooltip: 'Edit Email',
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Nomor Telepon'),
                  subtitle: Text(profileProvider.phone),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _editProfileField(
                        _phoneController,
                        'Nomor Telepon',
                        _validatePhone,
                        profileProvider.updatePhone,
                      );
                    },
                    tooltip: 'Edit No.Telepon',
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Tanggal Lahir'),
                  subtitle: Text(profileProvider.dob), 
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      _selectDate(context);
                    },
                    tooltip: 'Edit Tanggal Lahir',
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                SwitchListTile(
                  title: const Text('Mode Gelap'),
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}