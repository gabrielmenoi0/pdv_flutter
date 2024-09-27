import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:menu_bar/menu_bar.dart';
import 'package:pdv_windows/core/base/view/base_widget.dart';
import 'package:pdv_windows/view/_product/_constants/image_path.dart';
import 'package:pdv_windows/view/orders/view_model/orders_view_model.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<OrdersViewModel>(
      viewModel: getIt<OrdersViewModel>(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: buildScaffoldBody,
    );
  }

  Widget buildScaffoldBody(BuildContext context, OrdersViewModel viewModel) {
    return Scaffold(
      backgroundColor: context.colorScheme.onSurface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Center(
                  child: Text("REPORTS")
              ),
            )
          ],
        ),
      ),
    );
  }
}
