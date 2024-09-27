import 'package:pdv_windows/core/init/network/dio_network_manager.dart';
import 'package:flutter/material.dart';
import 'package:pdv_windows/core/init/cache/locale_manager.dart';
import 'package:pdv_windows/core/init/navigation/navigation_service.dart';

abstract class BaseServiceModel {
  late DioNetworkManager apiService;

  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance;

  BaseServiceModel(this.apiService);
}
