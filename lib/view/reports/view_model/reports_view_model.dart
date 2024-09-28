import 'dart:io';
import 'dart:math';
import 'package:pdv_windows/view/reports/model/chart_data_model.dart';
import 'package:pdv_windows/view/reports/model/customers_charts_model.dart';
import 'package:pdv_windows/view/reports/model/legend_chart_model.dart';
import 'package:pdv_windows/view/reports/model/order_chart_model.dart';
import 'package:pdv_windows/view/reports/model/product_chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdv_windows/core/base/model/base_view_model.dart';
import 'package:pdv_windows/core/init/cache/locale_manager.dart';
import 'package:pdv_windows/core/init/snackbar/snackbar_services.dart';
import 'package:pdv_windows/view/orders/model/orders_model.dart';
import 'package:pdv_windows/view/orders/view_model/orders_view_model.dart';
import 'package:pdv_windows/view/reports/model/age_group_model.dart';
import 'package:pdv_windows/view/reports/model/filter_report_model.dart';
import 'package:pdv_windows/viewmodel/setup_getIt.dart';
import 'package:uuid/uuid.dart';

part 'reports_view_model.g.dart';

class ReportsViewModel = _ReportsViewModelBase with _$ReportsViewModel;

abstract class _ReportsViewModelBase extends BaseViewModel with Store{


  void dispose() {}

  @override
  void init() async{
    filterOption = null;
    await fetchProducts();
    setFilterList();
    setInfoCharts();
  }

  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  var tooltip = TooltipBehavior(enable: true);

  @observable
  ObservableList<OrdersModel> ordersList = ObservableList.of([]);

  @observable
  ObservableList<Item> filterProductList = ObservableList.of([]);

  @observable
  ObservableList<Pagamento> filterPaymentList = ObservableList.of([]);

  @observable
  ObservableList<EnderecoEntrega> filterCityList = ObservableList.of([]);

  @observable
  ObservableList<AgeGroupModel> filterAgeGroupList = ObservableList.of([]);

  @observable
  ObservableList<OrderChartModel> ordersChart = ObservableList.of([]);

  @observable
  ObservableList<ChartDataModel> ordersChartView = ObservableList.of([]);

  @observable
  ObservableList<LegendChartModel> legendStatus = ObservableList.of([]);

  @observable
  ObservableList<LegendChartModel> legendSales = ObservableList.of([]);

  @observable
  ObservableList<CustomerChartModel> salesChartView = ObservableList.of([]);

  @observable
  ObservableList<ChartDataModel> salesChart = ObservableList.of([]);

  @observable
  ObservableList<LegendChartModel> legendProduct = ObservableList.of([]);

  @observable
  ObservableList<ProductChartModel> productChartView = ObservableList.of([]);

  @observable
  ObservableList<ChartDataModel> productChart = ObservableList.of([]);


  @observable
  bool isLoading = false;

  @observable
  FilterReportModel? filterOption;

  var uuid = Uuid();

  List<FilterReportModel> optionFilter = [];

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  @action
  setInfoCharts(){
    setInfoChartOrderStatus();
    setInfoChartTopCustomers();
    setInfoChartTopProducts();
  }

  @action
  setInfoChartOrderStatus() {
    Map<String, int> statusCountMap = {};

    ordersList.forEach((order) {
      String status = order.status ?? "";
      if (statusCountMap.containsKey(status)) {
        statusCountMap[status] = statusCountMap[status]! + 1;
      } else {
        statusCountMap[status] = 1;
      }
    });

    ordersChart.clear();
    ordersChartView.clear();
    legendStatus.clear();

    var sortedStatusCount = statusCountMap.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value));

    sortedStatusCount.forEach((entry) {
      String status = entry.key;
      int qtd = entry.value;

      ordersChart.add(OrderChartModel(qtd: qtd, status: status));
      ordersChartView.add(ChartDataModel(status, qtd.toDouble()));
      legendStatus.add(LegendChartModel(color: getColorForStatus(status), label: status));
    });
  }


  @action
  setInfoChartTopProducts() {
    Map<String, double> productTopSalesMap = {};

    ordersList.forEach((order) {
      order.itens?.forEach((item) {
        String productName = item.nome ?? "";
        double itemTotal = item.valorUnitario ?? 0.0;

        if (productTopSalesMap.containsKey(productName)) {
          productTopSalesMap[productName] = productTopSalesMap[productName]! + itemTotal;
        } else {
          productTopSalesMap[productName] = itemTotal;
        }
      });
    });

    productChart.clear();
    productChartView.clear();
    legendProduct.clear();

    var sortedProductSales = productTopSalesMap.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    sortedProductSales.forEach((entry) {
      String product = entry.key;
      double totalSales = entry.value;
      productChartView.add(ProductChartModel(totalSales: totalSales,productName: product));
      productChart.add(ChartDataModel(product, totalSales));
      legendProduct.add(LegendChartModel(color: getColorForCustomer(product), label: product));
    });
  }



  @action
  setInfoChartTopCustomers() {
    Map<String, double> customerSalesMap = {};

    ordersList.forEach((order) {
      String customer = order.cliente?.nome ?? "";
      double orderTotal = order.valorTotal ?? 0.0;

      if (customerSalesMap.containsKey(customer)) {
        customerSalesMap[customer] = customerSalesMap[customer]! + orderTotal;
      } else {
        customerSalesMap[customer] = orderTotal;
      }
    });

    salesChart.clear();
    salesChartView.clear();
    legendSales.clear();

    var sortedCustomerSales = customerSalesMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    sortedCustomerSales.forEach((entry) {
      String customer = entry.key;
      double totalSales = entry.value;

      salesChartView.add(CustomerChartModel(totalSales: totalSales, customer: customer));
      salesChart.add(ChartDataModel(customer, totalSales));
      legendSales.add(LegendChartModel(color: getColorForCustomer(customer), label: customer));
    });
  }



  @action
  Color getColorForStatus(String status) {
    switch (status) {
      case "CANCELADO":
        return Color(0xff0c97d4);
      case "APROVADO":
        return Color(0xff0476a0);
      default:
        return Colors.white;
    }
  }

  @action
  Color getColorForCustomer(String customer) {
    List<Color> colors = [
      Color(0xFFE8EAE9),
      Color(0xFF067BA6),
      Color(0xFF7CA536),
      Color(0xFF979B95),
      Color(0xFFA6C8BA),
    ];

    final random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }
  @action
  setFilterTable(FilterReportModel filter){
    filterOption = filter;
    switch(filter.option){
      case "1":
        filterProductsMoreSales();
        break;
      case "2":
        filterPaymentMore();
        break;
      case "3":
        filterCityMore();
        break;
      case "4":
        filterAgeGroup();
        break;
      default:
    }
  }

  @action
  filterProductsMoreSales(){
    filterProductList = ObservableList.of([]);
    ordersList.forEach((order) {
      filterProductList.addAll(order.itens ??[]);
      },
    );
    filterProductList.sort((a, b) => b.quantidade!.compareTo(a.quantidade!),);
  }

  @action
  export() async{
    if(filterOption == null) return SnackBarService.errorSnackBar("Selecione um filtro!");
    switch (filterOption?.option!) {
      case "1":
        exportProductsToExcel();
        break;
      case "2":
        exportPaymentsToExcel();
        break;
      case "3":
        exportCitiesToExcel();
        break;
      case "4":
        exportAgeGroupsToExcel();
        break;
      default:
        return;
    }
  }

  @action
  Future<void> saveExcelFile({required List<int> bytes, required String nameFile}) async {
    try{
      Directory? directory = await getDownloadsDirectory();
      String filePath = "${directory?.path}/${nameFile}.xlsx";

      File(filePath)..createSync(recursive: true)..writeAsBytesSync(bytes);

      return SnackBarService.successSnackBar("Dados exportados para a pasta 'Downloads'!");
    }catch(e){
      return SnackBarService.errorSnackBar("Não foi possível exportar os dados!");
    }
  }

  void exportProductsToExcel() async{

      final xcel.Workbook workbook = xcel.Workbook();
      final xcel.Worksheet sheet = workbook.worksheets[0];
      final List<String> columns = ['Produto','Quantidade', 'Quantidade'];

      final xcel.Style headerStyle = workbook.styles.add('headerStyle');
      headerStyle.bold = true;

      for (int i = 0; i < columns.length; i++) {
        final xcel.Range range = sheet.getRangeByIndex(1, i + 1);
        range.setText(columns[i]);
        range.columnWidth;
        range.cellStyle = headerStyle;
      }
      for (int i = 1; i <= columns.length; i++) {
        sheet.setColumnWidthInPixels(i, 200);
      }

      for (var i = 0; i < filterProductList.length; i++) {
        final item = filterProductList[i];
        sheet.getRangeByIndex(i + 2, 1).setText(item.nome ?? "");
        sheet.getRangeByIndex(i + 2, 2).setText(item.quantidade.toString());
        sheet.getRangeByIndex(i + 2, 3).setNumber(item.valorUnitario);
      }

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();
      await saveExcelFile(bytes: bytes, nameFile: "produtos_mais_vendidos");

  }

  void exportPaymentsToExcel() async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    final List<String> columns = ['Parcela', 'Forma', 'Valor'];

    final xcel.Style headerStyle = workbook.styles.add('headerStyle');
    headerStyle.bold = true;

    for (int i = 0; i < columns.length; i++) {
      final xcel.Range range = sheet.getRangeByIndex(1, i + 1);
      range.setText(columns[i]);
      range.columnWidth;
      range.cellStyle = headerStyle;
    }

    for (int i = 1; i <= columns.length; i++) {
      sheet.setColumnWidthInPixels(i, 200);
    }

    for (var i = 0; i < filterPaymentList.length; i++) {
      final payment = filterPaymentList[i];
      sheet.getRangeByIndex(i + 2, 1).setNumber(payment.parcela?.toDouble() ?? 0);
      sheet.getRangeByIndex(i + 2, 2).setText(payment.nome ?? "");
      sheet.getRangeByIndex(i + 2, 3).setNumber(payment.valor ?? 0);
    }

    final List<int> bytes = workbook.saveAsStream();
    await saveExcelFile(bytes: bytes, nameFile: "fomas_pagamentos");

    workbook.dispose();
  }

  void exportCitiesToExcel() async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    final List<String> columns = ['Cidade', 'Quantidade', 'Valor Total'];

    final xcel.Style headerStyle = workbook.styles.add('headerStyle');
    headerStyle.bold = true;

    for (int i = 0; i < columns.length; i++) {
      final xcel.Range range = sheet.getRangeByIndex(1, i + 1);
      range.setText(columns[i]);
      range.columnWidth;
      range.cellStyle = headerStyle;
    }

    for (int i = 1; i <= columns.length; i++) {
      sheet.setColumnWidthInPixels(i, 200);
    }

    for (var i = 0; i < filterCityList.length; i++) {
      final city = filterCityList[i];
      sheet.getRangeByIndex(i + 2, 1).setText(city.cidade ?? "");
      sheet.getRangeByIndex(i + 2, 2).setNumber(city.qtd.toDouble());
      sheet.getRangeByIndex(i + 2, 3).setNumber(city.value);
    }

    final List<int> bytes = workbook.saveAsStream();
    await saveExcelFile(bytes: bytes, nameFile: "cidades_mais_entregas");

    workbook.dispose();
  }


  void exportAgeGroupsToExcel() async {
    final xcel.Workbook workbook = xcel.Workbook();
    final xcel.Worksheet sheet = workbook.worksheets[0];
    final List<String> columns = ['Faixa Etária', 'Quantidade', 'Valor Total'];

    final xcel.Style headerStyle = workbook.styles.add('headerStyle');
    headerStyle.bold = true;

    for (int i = 0; i < columns.length; i++) {
      final xcel.Range range = sheet.getRangeByIndex(1, i + 1);
      range.setText(columns[i]);
      range.columnWidth;
      range.cellStyle = headerStyle;
    }

    for (int i = 1; i <= columns.length; i++) {
      sheet.setColumnWidthInPixels(i, 200);
    }

    for (var i = 0; i < filterAgeGroupList.length; i++) {
      final ageGroup = filterAgeGroupList[i];
      sheet.getRangeByIndex(i + 2, 1).setText(ageGroup.faixaEtaria);
      sheet.getRangeByIndex(i + 2, 2).setNumber(ageGroup.qtd.toDouble());
      sheet.getRangeByIndex(i + 2, 3).setNumber(ageGroup.valorTotal);
    }

    final List<int> bytes = workbook.saveAsStream();
    await saveExcelFile(bytes: bytes, nameFile: "faixas_etarias_mais_compras");

    workbook.dispose();
  }


  @action
  filterPaymentMore(){
    ordersList.forEach((order) {
      filterPaymentList.addAll(order.pagamento ??[]);
      },
    );
    filterPaymentList.sort((a, b) => b.nome!.compareTo(a.nome!),);
  }

  @action
  filterCityMore(){
    Map<String, EnderecoEntrega> cityDeliveryMap = {};

    ordersList.forEach((order) {
      var address = order.enderecoEntrega;
      if (address != null && address.cidade != null) {
        if (cityDeliveryMap.containsKey(address.cidade)) {
          cityDeliveryMap[address.cidade]!.qtd += 1;
          cityDeliveryMap[address.cidade]!.value += order.valorTotal ?? 0;
        } else {
          cityDeliveryMap[address.cidade!] = EnderecoEntrega(
            cidade: address.cidade,
            qtd: 1,
            value: order.valorTotal ?? 0,
          );
        }
      }
    });

    filterCityList = ObservableList.of(cityDeliveryMap.values.toList());
    filterCityList.sort((a, b) => b.qtd.compareTo(a.qtd));
  }

  @action
  filterAgeGroup() {
    List<AgeGroupModel> ageGroupList = [];

    ordersList.forEach((order) {
      var client = order.cliente;
      if (client != null && client.dataNascimento != null) {
        int age = calculateAge(client.dataNascimento!);
        String ageGroup = getAgeGroup(age);

        var existingGroup = ageGroupList.firstWhere((group) => group.faixaEtaria == ageGroup, orElse: () => AgeGroupModel(faixaEtaria: ageGroup),);

        if (existingGroup.qtd == 0) {
          ageGroupList.add(existingGroup);
        }

        existingGroup.qtd += 1;
        existingGroup.valorTotal += order.valorTotal ?? 0;
      }
    });

    ageGroupList.sort((a, b) => b.qtd.compareTo(a.qtd));

    filterAgeGroupList = ObservableList.of(ageGroupList);

  }

  @action
  int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }


  @action
  String getAgeGroup(int age) {
    if (age <= 18) return '0-18';
    else if (age <= 30) return '19-30';
    else if (age <= 45) return '31-45';
    else if (age <= 60) return '46-60';
    else return '61+';
  }

  @action
  setFilterList(){
    optionFilter = [
      FilterReportModel(id: uuid.v4(), option: "1", label: "Listagem de produtos mais vendidos"),
      FilterReportModel(id: uuid.v4(), option: "2", label: "Totalização de Formas de Pagamento por dia"),
      FilterReportModel(id: uuid.v4(), option: "3", label: "Totalização de vendas por Cidade"),
      FilterReportModel(id: uuid.v4(), option: "4", label: "Totalização de vendas por Faixa Etária"),
    ];
  }

  @action
  fetchProducts() async{
    try{
      changeLoading();
      getIt<OrdersViewModel>().init();
      await getIt<OrdersViewModel>().fetchOrdersAPI();
      List<OrdersModel> listOffline = await LocaleManager.ordersBox.getList((json) => OrdersModel.fromJson(json));
      ordersList.clear();
      ordersList = ObservableList.of(listOffline);
    }catch(e){}
    finally{
      changeLoading();
    }
  }

}
