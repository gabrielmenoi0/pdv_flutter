import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'light/light_theme_interface.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight? _instance;

  static AppThemeLight get instance {
    return _instance ??= AppThemeLight._init();
  }

  AppThemeLight._init();

  @override
  ThemeData get theme => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: color!.theme.surface,
      colorScheme: color!.theme,
      textTheme: text!.theme,
      appBarTheme: appBar!.appBarTheme,
      tabBarTheme: appBar!.tabBarTheme,
      elevatedButtonTheme: button!.elevated,
      filledButtonTheme: button!.filled,
      outlinedButtonTheme: button!.outlined,
      textButtonTheme: button!.text,
      listTileTheme: button!.listTile);
}
