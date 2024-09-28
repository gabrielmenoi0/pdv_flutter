// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrdersViewModel on _OrdersViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_OrdersViewModelBase.isLoading', context: context);

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

  late final _$ordersListAtom =
      Atom(name: '_OrdersViewModelBase.ordersList', context: context);

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

  late final _$detailsOrderAtom =
      Atom(name: '_OrdersViewModelBase.detailsOrder', context: context);

  @override
  OrdersModel? get detailsOrder {
    _$detailsOrderAtom.reportRead();
    return super.detailsOrder;
  }

  @override
  set detailsOrder(OrdersModel? value) {
    _$detailsOrderAtom.reportWrite(value, super.detailsOrder, () {
      super.detailsOrder = value;
    });
  }

  late final _$searchOrdersAsyncAction =
      AsyncAction('_OrdersViewModelBase.searchOrders', context: context);

  @override
  Future searchOrders() {
    return _$searchOrdersAsyncAction.run(() => super.searchOrders());
  }

  late final _$fetchOrdersAPIAsyncAction =
      AsyncAction('_OrdersViewModelBase.fetchOrdersAPI', context: context);

  @override
  Future fetchOrdersAPI() {
    return _$fetchOrdersAPIAsyncAction.run(() => super.fetchOrdersAPI());
  }

  late final _$_OrdersViewModelBaseActionController =
      ActionController(name: '_OrdersViewModelBase', context: context);

  @override
  void changeLoading() {
    final _$actionInfo = _$_OrdersViewModelBaseActionController.startAction(
        name: '_OrdersViewModelBase.changeLoading');
    try {
      return super.changeLoading();
    } finally {
      _$_OrdersViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDetailsOrder(OrdersModel order) {
    final _$actionInfo = _$_OrdersViewModelBaseActionController.startAction(
        name: '_OrdersViewModelBase.setDetailsOrder');
    try {
      return super.setDetailsOrder(order);
    } finally {
      _$_OrdersViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openDetails(OrdersModel order) {
    final _$actionInfo = _$_OrdersViewModelBaseActionController.startAction(
        name: '_OrdersViewModelBase.openDetails');
    try {
      return super.openDetails(order);
    } finally {
      _$_OrdersViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
ordersList: ${ordersList},
detailsOrder: ${detailsOrder}
    ''';
  }
}
