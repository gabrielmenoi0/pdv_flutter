import 'dart:convert';

import 'package:pdv_windows/core/init/network/exception.dart';
import 'package:pdv_windows/view/_product/enum/network_route_enum.dart';
import 'package:pdv_windows/view/orders/model/orders_model.dart';
import 'package:pdv_windows/view/orders/service/IOrdersService.dart';

class OrdersService extends IOrdersService {
  OrdersService(super.apiService);

  @override
  Future<List<OrdersModel>?> fetchOrders() async {
    try {
      final response = await apiService.get(NetworkRoutes.orders.rawValue);
      return (json.decode(
          json.encode(response.data)) as List)
          .map((e) => OrdersModel.fromJson(e))
          .toList();
    } on ApiException catch (e) {
      rethrow;
    }
  }


}
