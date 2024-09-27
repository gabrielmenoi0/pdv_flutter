import 'package:pdv_windows/core/base/model/base_service_model.dart';
import 'package:pdv_windows/view/orders/model/orders_model.dart';

abstract class IOrdersService extends BaseServiceModel {
  IOrdersService(super.apiService);
  Future<List<OrdersModel>?> fetchOrders();
}
