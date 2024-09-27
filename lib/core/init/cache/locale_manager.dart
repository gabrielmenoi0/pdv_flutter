import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pdv_windows/core/init/model/local_entity.dart';
import 'package:pdv_windows/view/orders/model/orders_model.dart';

enum AppBox {
  ordersBox,
}

class LocaleManager {
  LocaleManager._init();

  static final LocaleManager _instance = LocaleManager._init();

  static LocaleManager get instance => _instance;

  static final LocalEntityRepository<OrdersModel> ordersBox = LocalEntityRepository<OrdersModel>(AppBox.ordersBox);

}

class LocalEntityRepository<T extends LocalEntity> {
  final AppBox boxName;

  LocalEntityRepository(this.boxName);

  Future<void> _openBox() async {
    if (!Hive.isBoxOpen(boxName.name)) {
      await Hive.openBox(boxName.name);
    }
  }

  Future<void> save(T data) async {
    await _openBox();
    await Hive.box(boxName.name).put(data.key, jsonEncode(data));
  }

  Future<T?> get(T data, T Function(Map<String, dynamic>) fromJson) async {
    await _openBox();
    final jsonString = Hive.box(boxName.name).get(data.key);
    if (jsonString != null) {
      return fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  Future<void> delete(T data) async {
    await _openBox();
    await Hive.box(boxName.name).delete(data.key);
  }

  Future<void> saveList(T data, List<T> dataList) async {
    await _openBox();
    final box = Hive.box(boxName.name);
    await box.put(data.key, jsonEncode(dataList));
  }

  Future<List<T>> getList(T Function(Map<String, dynamic>) fromJson) async {
    try {
      await _openBox();
      final box = Hive.box(boxName.name);
      return (jsonDecode(box.values.first) as List)
          .map((element) => fromJson(element))
          .toList()
          .cast<T>();
    } catch (e) {
      return [];
    }
  }
}
