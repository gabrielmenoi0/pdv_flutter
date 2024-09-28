import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/core/init/lang/locale_keys.g.dart';
import 'package:pdv_windows/view/_product/_constants/image_path.dart';
import 'package:pdv_windows/view/home/view_model/home_view_model.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pdv_windows/view/orders/view/orders_view.dart';
import 'package:pdv_windows/view/reports/view/reports_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: buildScaffoldBody,
    );
  }

  Widget buildScaffoldBody(BuildContext context, HomeViewModel viewModel) {
    return MenuBarWidget(
      barButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(context.general.colorScheme.primary),
        animationDuration: Duration(seconds: 1),
        foregroundColor:  WidgetStatePropertyAll(context.general.colorScheme.secondary),
        mouseCursor: WidgetStateProperty.all(MouseCursor.defer),
        textStyle: WidgetStatePropertyAll(context.general.textTheme.bodyMedium),
      ),
      barStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(context.general.colorScheme.primary),
        mouseCursor: WidgetStateProperty.all(MouseCursor.defer),
      ),
      menuButtonStyle: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(context.general.colorScheme.secondary),
        animationDuration: Duration(seconds: 1),
        foregroundColor: WidgetStatePropertyAll(context.general.colorScheme.primary),
        mouseCursor: WidgetStateProperty.all(MouseCursor.defer),
        textStyle: WidgetStatePropertyAll(context.general.textTheme.bodyMedium),
      ),
      barButtons: [
        BarButton(text: Text(LocaleKeys.label_menu.tr()),
            submenu: SubMenu(menuItems: [
          MenuButton(
            text: Text(LocaleKeys.label_orders.tr()),
            onTap: ()=> viewModel.openOrders(),
            shortcutStyle: context.general.textTheme.bodyMedium!,
            icon: Icon(Icons.delivery_dining_rounded),
          ),
          MenuDivider(color: context.general.colorScheme.primary,height: 1),
          MenuButton(
            text: Text(LocaleKeys.label_reports.tr()),
            shortcutStyle: context.general.textTheme.bodyMedium!,
            onTap: ()=> viewModel.openReports(),
            icon: Icon(Icons.bar_chart),
          ),
        ]))
      ],
      child: Observer(
        builder: (context) {

          if(viewModel.isOrder){
            return OrdersView();
          }

          if(viewModel.isReports){
            return ReportsView();
          }

          return Scaffold(
            backgroundColor: context.general.colorScheme.onSurface,
            body: SafeArea(
              child: Image.asset(
                ImagePaths.instance.logo,
                height: 2000,
              ),
            ),
          );
        }
      ),
    );
  }
}
