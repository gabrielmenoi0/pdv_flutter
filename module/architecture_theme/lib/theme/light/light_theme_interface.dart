import 'appbar_theme.dart';
import 'button_theme.dart';
import 'color_scheme_light.dart';
import 'text_theme_light.dart';

abstract class ILightTheme {
  AppBarThemeLight? appBar = AppBarThemeLight.instance;
  TextThemeLight? text = TextThemeLight.instance;
  ColorSchemeLight? color = ColorSchemeLight.instance;
  ButtonThemeLight? button = ButtonThemeLight.instance;
}
