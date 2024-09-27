import 'package:flutter/material.dart';

class ColorSchemeLight {
  static ColorSchemeLight? _instance;

  static ColorSchemeLight? get instance {
    _instance ??= ColorSchemeLight._init();
    return _instance;
  }

  ColorSchemeLight._init();

  ColorScheme get theme {
    return ThemeData.light().colorScheme.copyWith(
      primary: const Color(0xff04444c),
      secondary: const Color(0xff7bbc44),
      onSurface: Colors.white,
      error: Colors.red,
      onPrimaryContainer: Color(0xff2E2E2E)
    );
  }
}
