import 'package:e_mall/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppTheme {
  light,
  dark,
  system,
}

class ThemeProvider with ChangeNotifier {
  AppTheme _appTheme = AppTheme.system;

  AppTheme get appTheme => _appTheme;

  ThemeProvider() {
    _loadTheme();
  }

  void setTheme(AppTheme theme) async {
    _appTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('appTheme', theme.toString().split('.').last);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('appTheme') ?? 'system';
    _appTheme = AppTheme.values
        .firstWhere((e) => e.toString().split('.').last == themeString);
    notifyListeners();
  }
  bool isSystemDarkMode(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark;
  }
  ThemeData get themeData {
    switch (_appTheme) {
      case AppTheme.light:
        return lightTheme;
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.system:
      default:
        return lightTheme;
    }
  }
}