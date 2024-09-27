import 'package:pdv_windows/core/constants/navigation/navigation_constants.dart';
import 'package:pdv_windows/product/exception/not_found_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:pdv_windows/view/home/view/home_view.dart';
import 'package:pdv_windows/view/orders/view/orders_view.dart';
import 'package:pdv_windows/view/reports/view/reports_view.dart';
import 'package:pdv_windows/view/splash/view/splash_view.dart';
import 'package:showcaseview/showcaseview.dart';

class NavigationRoute {
  NavigationRoute._init();

  static final NavigationRoute _instance = NavigationRoute._init();

  static NavigationRoute get instance => _instance;

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(
          SplashView(),
          args.name!,
        );
      case NavigationConstants.HOME:
        return normalNavigate(
          HomeView(),
          args.name!,
        );
      case NavigationConstants.ORDERS:
        return normalNavigate(
          OrdersView(),
          args.name!,
        );
      case NavigationConstants.REPORTS:
        return normalNavigate(
          ReportsView(),
          args.name!,
        );
      // case NavigationConstants.STATUS:
      //   if (args.arguments is StatusModel) {
      //     return normalNavigate(
      //         StatusView(status: args.arguments as StatusModel),
      //         args.name ?? "");
      //   }
      //   throw NavigateException<String>(args.arguments);

      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundNavigationWidget(),
        );
    }
  }

  MaterialPageRoute normalNavigate(Widget widget, String pageName) {
    return MaterialPageRoute(
      builder: (context) => ShowCaseWidget(
          builder: (context) => Builder(
              builder: (context) => GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: widget))),
      settings: RouteSettings(name: pageName),
    );
  }
}
