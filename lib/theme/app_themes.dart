import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  ThemeMode get themeMode {
    return _themeMode;
  }

  void switchDarkMode(bool switchValue) {
    _themeMode = switchValue ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static ThemeData appThemeLight() {
    return ThemeData(
      primarySwatch: Colors.blue,
      backgroundColor: Colors.blue,
      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.blueGrey, opacity: 0.8),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 18,
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static ThemeData appThemeDark() {
    return ThemeData(
      primarySwatch: Colors.purple,
      backgroundColor: Colors.brown,
      colorScheme: const ColorScheme.dark(),
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.grey.shade900,
      iconTheme: const IconThemeData(color: Colors.amber, opacity: 0.8),
      textTheme: const TextTheme(
        headline6: TextStyle(
          fontSize: 18,
          color: Colors.amberAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
