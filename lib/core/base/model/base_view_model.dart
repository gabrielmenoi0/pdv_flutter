import 'package:flutter/material.dart';
import 'package:pdv_windows/core/init/cache/locale_manager.dart';
import 'package:pdv_windows/core/init/navigation/navigation_service.dart';

abstract class BaseViewModel {
  LocaleManager localeManager = LocaleManager.instance;

  NavigationService navigation = NavigationService.instance;

  late BuildContext viewModelContext;

  void setContext(BuildContext context);
  void init();
  void dispose();

}
