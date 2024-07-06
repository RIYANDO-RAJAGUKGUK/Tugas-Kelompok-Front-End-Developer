import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData.light();

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData.brightness == Brightness.dark;

  void toggleTheme() {
    _themeData = _themeData.brightness == Brightness.dark
        ? ThemeData.light()
        : ThemeData.dark();
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.teal,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal,
);
