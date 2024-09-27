import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pdv_windows/core/base/model/base_view_model.dart';
import 'package:pdv_windows/core/constants/app/app_constants.dart';
import 'package:pdv_windows/core/export/base_export.dart';
import 'package:pdv_windows/core/init/cache/locale_manager.dart';
import 'package:pdv_windows/core/init/network/dio_network_manager.dart';
import 'package:pdv_windows/core/init/snackbar/snackbar_services.dart';
import 'package:pdv_windows/view/orders/model/orders_model.dart';
import 'package:pdv_windows/view/orders/service/IOrdersService.dart';
import 'package:pdv_windows/view/orders/service/orders_service.dart';
import 'package:pdv_windows/view/orders/view/widgets/dialog_details_widget.dart';

part 'orders_view_model.g.dart';

class OrdersViewModel = _OrdersViewModelBase with _$OrdersViewModel;

abstract class _OrdersViewModelBase extends BaseViewModel with Store{

  late IOrdersService ordersService;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<OrdersModel> ordersList = ObservableList.of([]);

  TextEditingController controller = TextEditingController();

  @observable
  OrdersModel? detailsOrder;

  void dispose() {}

  @override
  void init() {
    ordersService = OrdersService(
        DioNetworkManager(
            baseUrl: ApplicationConstants.BASE_URL,
            headers: ApplicationConstants.HEADERS
        ));
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  setDetailsOrder(OrdersModel order){
    detailsOrder = order;
  }

  @action
  openDetails(OrdersModel order){
    detailsOrder = order;
    DialogDetailsWidget.showTwoTablesDialog(viewModelContext);
  }

  @action
  searchOrders() async{
    try{
      List<OrdersModel> listOffline = await LocaleManager.ordersBox.getList((json) => OrdersModel.fromJson(json));
      if (controller.text.isEmpty) {
        ordersList.clear();
        ordersList.addAll(listOffline);
      } else {
        ordersList.clear();
        ordersList.addAll(listOffline.where((order) => order.cliente!.nome!.toLowerCase().contains(controller.text.toLowerCase())));
        if(ordersList.length==0) return SnackBarService.errorSnackBar("Foram encontrados ${ordersList.length} pedidos.");
        return SnackBarService.successSnackBar("Foram encontrados ${ordersList.length} pedidos.");
      }
    }catch(e){}
    finally{}
  }

  @action
  fetchOrdersAPI() async{
    changeLoading();

    try {
      final response = await ordersService.fetchOrders();
      if (response.isNotNullOrEmpty) {
        await LocaleManager.ordersBox.saveList(OrdersModel(), response ?? []);
        return SnackBarService.successSnackBar("Pedidos sincronizados com sucesso !");
      }
    } catch (_) {
      return SnackBarService.errorSnackBar("Não foi possível obter os pedidos !");
    }
    finally{
      changeLoading();
    }
    return null;
  }

}
