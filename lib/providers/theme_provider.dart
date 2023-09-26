import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // var _themeMode = ThemeMode.system;

  bool _isDark = false;

  bool get isDark => _isDark;

  // ThemeMode get themeMode => _themeMode;

  void setTheme() {
    // _themeMode = themeMode;
    _isDark = !_isDark;
    notifyListeners();
  }
}
