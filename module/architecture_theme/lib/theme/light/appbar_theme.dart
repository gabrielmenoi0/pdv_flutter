import 'package:architecture_theme/theme/light/color_scheme_light.dart';
import 'package:architecture_theme/theme/light/text_theme_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBarThemeLight {
  static AppBarThemeLight? _instance;

  static AppBarThemeLight? get instance {
    _instance ??= AppBarThemeLight._init();
    return _instance;
  }

  AppBarThemeLight._init();

  AppBarTheme get appBarTheme {
    return ThemeData.light().appBarTheme.copyWith(
        backgroundColor: ColorSchemeLight.instance?.theme.surface,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
            fontFamily: 'Biko',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: ColorSchemeLight.instance?.theme.primary),
        iconTheme:
        IconThemeData(color: ColorSchemeLight.instance?.theme.primary));
  }

  TabBarTheme get tabBarTheme {
    return ThemeData.light().tabBarTheme.copyWith(
        labelStyle: TextThemeLight.instance?.theme.labelLarge,
        unselectedLabelStyle: TextThemeLight.instance?.theme.labelMedium);
  }
}
