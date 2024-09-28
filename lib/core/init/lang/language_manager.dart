import 'package:flutter/material.dart';

class LanguageManager {
  LanguageManager._init();

  static LanguageManager? _instance;

  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  var defaultLocale = Locale('pt', 'BR');
  final ptLocale = const Locale('pt', 'BR');

  List<Locale> get supportedLocales => [ptLocale];

}
