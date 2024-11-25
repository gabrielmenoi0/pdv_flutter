import 'package:get_it/get_it.dart';
import 'package:pdv_windows/view/orders/view_model/orders_view_model.dart';

import '../view/reports/view_model/reports_view_model.dart';

final getIt = GetIt.instance;

setupGetIt()async{
  getIt.registerLazySingleton<OrdersViewModel>(() => new OrdersViewModel());
  getIt.registerLazySingleton<ReportsViewModel>(() => new ReportsViewModel());
}