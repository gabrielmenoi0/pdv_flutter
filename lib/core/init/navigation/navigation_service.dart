import 'package:flutter/cupertino.dart';
import 'package:pdv_windows/core/init/navigation/INavigationService.dart';

class NavigationService implements INavigationService {
  NavigationService._init();
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  final removeAllOldRoutes = (Route<dynamic> route) => false;

  @override
  Future<dynamic> navigateToPage({String? path, Object? data}) async {
    return await navigatorKey.currentState!.pushNamed(path!, arguments: data);
  }

  @override
  Future<dynamic> navigateReplacementToPage({String? path, Object? data}) async {
    return await navigatorKey.currentState!.pushReplacementNamed(path!, arguments: data);
  }

  @override
  Future<void> navigateToPageClear({String? path, Object? data}) async {
    await navigatorKey.currentState!.pushNamedAndRemoveUntil(path!, removeAllOldRoutes, arguments: data);
  }
}