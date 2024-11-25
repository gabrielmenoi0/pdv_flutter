// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reports_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReportsViewModel on _ReportsViewModelBase, Store {
  late final _$ordersListAtom =
      Atom(name: '_ReportsViewModelBase.ordersList', context: context);

  @override
  ObservableList<OrdersModel> get ordersList {
    _$ordersListAtom.reportRead();
    return super.ordersList;
  }

  @override
  set ordersList(ObservableList<OrdersModel> value) {
    _$ordersListAtom.reportWrite(value, super.ordersList, () {
      super.ordersList = value;
    });
  }

  late final _$filterProductListAtom =
      Atom(name: '_ReportsViewModelBase.filterProductList', context: context);

  @override
  ObservableList<Item> get filterProductList {
    _$filterProductListAtom.reportRead();
    return super.filterProductList;
  }

  @override
  set filterProductList(ObservableList<Item> value) {
    _$filterProductListAtom.reportWrite(value, super.filterProductList, () {
      super.filterProductList = value;
    });
  }

  late final _$filterPaymentListAtom =
      Atom(name: '_ReportsViewModelBase.filterPaymentList', context: context);

  @override
  ObservableList<Pagamento> get filterPaymentList {
    _$filterPaymentListAtom.reportRead();
    return super.filterPaymentList;
  }

  @override
  set filterPaymentList(ObservableList<Pagamento> value) {
    _$filterPaymentListAtom.reportWrite(value, super.filterPaymentList, () {
      super.filterPaymentList = value;
    });
  }

  late final _$filterCityListAtom =
      Atom(name: '_ReportsViewModelBase.filterCityList', context: context);

  @override
  ObservableList<EnderecoEntrega> get filterCityList {
    _$filterCityListAtom.reportRead();
    return super.filterCityList;
  }

  @override
  set filterCityList(ObservableList<EnderecoEntrega> value) {
    _$filterCityListAtom.reportWrite(value, super.filterCityList, () {
      super.filterCityList = value;
    });
  }

  late final _$filterAgeGroupListAtom =
      Atom(name: '_ReportsViewModelBase.filterAgeGroupList', context: context);

  @override
  ObservableList<AgeGroupModel> get filterAgeGroupList {
    _$filterAgeGroupListAtom.reportRead();
    return super.filterAgeGroupList;
  }

  @override
  set filterAgeGroupList(ObservableList<AgeGroupModel> value) {
    _$filterAgeGroupListAtom.reportWrite(value, super.filterAgeGroupList, () {
      super.filterAgeGroupList = value;
    });
  }

  late final _$ordersChartAtom =
      Atom(name: '_ReportsViewModelBase.ordersChart', context: context);

  @override
  ObservableList<OrderChartModel> get ordersChart {
    _$ordersChartAtom.reportRead();
    return super.ordersChart;
  }

  @override
  set ordersChart(ObservableList<OrderChartModel> value) {
    _$ordersChartAtom.reportWrite(value, super.ordersChart, () {
      super.ordersChart = value;
    });
  }

  late final _$ordersChartViewAtom =
      Atom(name: '_ReportsViewModelBase.ordersChartView', context: context);

  @override
  ObservableList<ChartDataModel> get ordersChartView {
    _$ordersChartViewAtom.reportRead();
    return super.ordersChartView;
  }

  @override
  set ordersChartView(ObservableList<ChartDataModel> value) {
    _$ordersChartViewAtom.reportWrite(value, super.ordersChartView, () {
      super.ordersChartView = value;
    });
  }

  late final _$legendStatusAtom =
      Atom(name: '_ReportsViewModelBase.legendStatus', context: context);

  @override
  ObservableList<LegendChartModel> get legendStatus {
    _$legendStatusAtom.reportRead();
    return super.legendStatus;
  }

  @override
  set legendStatus(ObservableList<LegendChartModel> value) {
    _$legendStatusAtom.reportWrite(value, super.legendStatus, () {
      super.legendStatus = value;
    });
  }

  late final _$legendSalesAtom =
      Atom(name: '_ReportsViewModelBase.legendSales', context: context);

  @override
  ObservableList<LegendChartModel> get legendSales {
    _$legendSalesAtom.reportRead();
    return super.legendSales;
  }

  @override
  set legendSales(ObservableList<LegendChartModel> value) {
    _$legendSalesAtom.reportWrite(value, super.legendSales, () {
      super.legendSales = value;
    });
  }

  late final _$salesChartViewAtom =
      Atom(name: '_ReportsViewModelBase.salesChartView', context: context);

  @override
  ObservableList<CustomerChartModel> get salesChartView {
    _$salesChartViewAtom.reportRead();
    return super.salesChartView;
  }

  @override
  set salesChartView(ObservableList<CustomerChartModel> value) {
    _$salesChartViewAtom.reportWrite(value, super.salesChartView, () {
      super.salesChartView = value;
    });
  }

  late final _$salesChartAtom =
      Atom(name: '_ReportsViewModelBase.salesChart', context: context);

  @override
  ObservableList<ChartDataModel> get salesChart {
    _$salesChartAtom.reportRead();
    return super.salesChart;
  }

  @override
  set salesChart(ObservableList<ChartDataModel> value) {
    _$salesChartAtom.reportWrite(value, super.salesChart, () {
      super.salesChart = value;
    });
  }

  late final _$legendProductAtom =
      Atom(name: '_ReportsViewModelBase.legendProduct', context: context);

  @override
  ObservableList<LegendChartModel> get legendProduct {
    _$legendProductAtom.reportRead();
    return super.legendProduct;
  }

  @override
  set legendProduct(ObservableList<LegendChartModel> value) {
    _$legendProductAtom.reportWrite(value, super.legendProduct, () {
      super.legendProduct = value;
    });
  }

  late final _$productChartViewAtom =
      Atom(name: '_ReportsViewModelBase.productChartView', context: context);

  @override
  ObservableList<ProductChartModel> get productChartView {
    _$productChartViewAtom.reportRead();
    return super.productChartView;
  }

  @override
  set productChartView(ObservableList<ProductChartModel> value) {
    _$productChartViewAtom.reportWrite(value, super.productChartView, () {
      super.productChartView = value;
    });
  }

  late final _$productChartAtom =
      Atom(name: '_ReportsViewModelBase.productChart', context: context);

  @override
  ObservableList<ChartDataModel> get productChart {
    _$productChartAtom.reportRead();
    return super.productChart;
  }

  @override
  set productChart(ObservableList<ChartDataModel> value) {
    _$productChartAtom.reportWrite(value, super.productChart, () {
      super.productChart = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ReportsViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$filterOptionAtom =
      Atom(name: '_ReportsViewModelBase.filterOption', context: context);

  @override
  FilterReportModel? get filterOption {
    _$filterOptionAtom.reportRead();
    return super.filterOption;
  }

  @override
  set filterOption(FilterReportModel? value) {
    _$filterOptionAtom.reportWrite(value, super.filterOption, () {
      super.filterOption = value;
    });
  }

  late final _$exportAsyncAction =
      AsyncAction('_ReportsViewModelBase.export', context: context);

  @override
  Future export() {
    return _$exportAsyncAction.run(() => super.export());
  }

  late final _$saveExcelFileAsyncAction =
      AsyncAction('_ReportsViewModelBase.saveExcelFile', context: context);

  @override
  Future<void> saveExcelFile(
      {required List<int> bytes, required String nameFile}) {
    return _$saveExcelFileAsyncAction
        .run(() => super.saveExcelFile(bytes: bytes, nameFile: nameFile));
  }

  late final _$fetchProductsAsyncAction =
      AsyncAction('_ReportsViewModelBase.fetchProducts', context: context);

  @override
  Future fetchProducts() {
    return _$fetchProductsAsyncAction.run(() => super.fetchProducts());
  }

  late final _$_ReportsViewModelBaseActionController =
      ActionController(name: '_ReportsViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setInfoCharts() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.setInfoCharts');
    try {
      return super.setInfoCharts();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setInfoChartOrderStatus() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.setInfoChartOrderStatus');
    try {
      return super.setInfoChartOrderStatus();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setInfoChartTopProducts() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.setInfoChartTopProducts');
    try {
      return super.setInfoChartTopProducts();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setInfoChartTopCustomers() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.setInfoChartTopCustomers');
    try {
      return super.setInfoChartTopCustomers();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Color getColorForStatus(String status) {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.getColorForStatus');
    try {
      return super.getColorForStatus(status);
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Color getColorForCustomer(String customer) {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.getColorForCustomer');
    try {
      return super.getColorForCustomer(customer);
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterTable(FilterReportModel filter) {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.setFilterTable');
    try {
      return super.setFilterTable(filter);
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterProductsMoreSales() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.filterProductsMoreSales');
    try {
      return super.filterProductsMoreSales();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterPaymentMore() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.filterPaymentMore');
    try {
      return super.filterPaymentMore();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterCityMore() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.filterCityMore');
    try {
      return super.filterCityMore();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic filterAgeGroup() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.filterAgeGroup');
    try {
      return super.filterAgeGroup();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int calculateAge(DateTime birthDate) {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.calculateAge');
    try {
      return super.calculateAge(birthDate);
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getAgeGroup(int age) {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.getAgeGroup');
    try {
      return super.getAgeGroup(age);
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFilterList() {
    final _$actionInfo = _$_ReportsViewModelBaseActionController.startAction(
        name: '_ReportsViewModelBase.setFilterList');
    try {
      return super.setFilterList();
    } finally {
      _$_ReportsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ordersList: ${ordersList},
filterProductList: ${filterProductList},
filterPaymentList: ${filterPaymentList},
filterCityList: ${filterCityList},
filterAgeGroupList: ${filterAgeGroupList},
ordersChart: ${ordersChart},
ordersChartView: ${ordersChartView},
legendStatus: ${legendStatus},
legendSales: ${legendSales},
salesChartView: ${salesChartView},
salesChart: ${salesChart},
legendProduct: ${legendProduct},
productChartView: ${productChartView},
productChart: ${productChart},
isLoading: ${isLoading},
filterOption: ${filterOption}
    ''';
  }
}
