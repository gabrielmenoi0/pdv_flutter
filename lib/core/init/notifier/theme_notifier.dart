import 'package:architecture_theme/theme/app_theme_light.dart';
import 'package:flutter/material.dart';
import 'package:pdv_windows/core/constants/enums/app_theme_enum.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeData _currentTheme = AppThemeLight.instance.theme;

  AppThemes _currentThemeEnum = AppThemes.LIGHT;

  AppThemes get currentThemeEnum => _currentThemeEnum;

  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme = ThemeData.light();
    } else {
      _currentTheme = ThemeData.dark();
    }
    notifyListeners();
  }

  void changeTheme() {
    if (_currentThemeEnum == AppThemes.LIGHT) {
      _currentTheme = ThemeData.dark();
      _currentThemeEnum = AppThemes.DARK;
    } else {
      _currentTheme = AppThemeLight.instance.theme;
      _currentThemeEnum = AppThemes.LIGHT;
    }
    notifyListeners();
  }
}
