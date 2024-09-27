import 'package:architecture_theme/theme/light/color_scheme_light.dart';
import 'package:architecture_theme/theme/light/text_theme_light.dart';
import 'package:flutter/material.dart';

class ButtonThemeLight {
  static ButtonThemeLight? _instance;

  static ButtonThemeLight? get instance {
    _instance ??= ButtonThemeLight._init();
    return _instance;
  }

  ButtonThemeLight._init();

  ElevatedButtonThemeData get elevated {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(kMinInteractiveDimension),
            elevation: 8,
            textStyle: TextThemeLight.instance?.theme.titleMedium,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }

  FilledButtonThemeData get filled {
    return FilledButtonThemeData(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(kMinInteractiveDimension),
            elevation: 0,
            textStyle: TextThemeLight.instance?.theme.titleMedium,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }

  OutlinedButtonThemeData get outlined {
    return OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(kMinInteractiveDimension),
            elevation: 0,
            textStyle: TextThemeLight.instance?.theme.titleMedium,
            foregroundColor: ColorSchemeLight.instance?.theme.primary,
            shape: RoundedRectangleBorder(
                side:
                BorderSide(color: ColorSchemeLight.instance!.theme.primary),
                borderRadius: BorderRadius.circular(10))));
  }

  TextButtonThemeData get text {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
          textStyle: TextThemeLight.instance?.theme.labelLarge
              ?.copyWith(fontWeight: FontWeight.w700)),
    );
  }

  ListTileThemeData get listTile {
    return ListTileThemeData(
        iconColor: ColorSchemeLight.instance?.theme.primary,
        titleTextStyle: TextThemeLight.instance?.theme.titleMedium,
        subtitleTextStyle: TextThemeLight.instance?.theme.bodySmall
            ?.copyWith(color: Colors.grey));
  }
}
