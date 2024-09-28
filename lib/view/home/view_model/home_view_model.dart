import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pdv_windows/core/base/model/base_view_model.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store{


  @observable
  bool isOrder = false;

  @observable
  bool isReports = false;

  void dispose() {}

  @override
  void init() {
    changeView(order: true);
  }

  changeView({required bool order}){
    switch(order){
      case true:
        isOrder = true;
        isReports = false;
        break;
      case false:
        isOrder = false;
        isReports = true;
    }
  }

  @action
  openOrders(){
    changeView(order: true);
  }

  @action
  openReports(){
    changeView(order: false);
  }


  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

}
