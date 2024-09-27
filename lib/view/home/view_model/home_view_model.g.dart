// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$isOrderAtom =
      Atom(name: '_HomeViewModelBase.isOrder', context: context);

  @override
  bool get isOrder {
    _$isOrderAtom.reportRead();
    return super.isOrder;
  }

  @override
  set isOrder(bool value) {
    _$isOrderAtom.reportWrite(value, super.isOrder, () {
      super.isOrder = value;
    });
  }

  late final _$isReportsAtom =
      Atom(name: '_HomeViewModelBase.isReports', context: context);

  @override
  bool get isReports {
    _$isReportsAtom.reportRead();
    return super.isReports;
  }

  @override
  set isReports(bool value) {
    _$isReportsAtom.reportWrite(value, super.isReports, () {
      super.isReports = value;
    });
  }

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

  @override
  dynamic openOrders() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.openOrders');
    try {
      return super.openOrders();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic openReports() {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.openReports');
    try {
      return super.openReports();
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isOrder: ${isOrder},
isReports: ${isReports}
    ''';
  }
}
