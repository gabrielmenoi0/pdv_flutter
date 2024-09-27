import 'package:flutter/material.dart';
import 'package:pdv_windows/core/export/base_export.dart';
import 'package:mobx/mobx.dart';
import 'package:pdv_windows/core/base/model/base_view_model.dart';
import 'package:pdv_windows/core/constants/navigation/navigation_constants.dart';
import 'package:pdv_windows/view/splash/viewmodel/device_and_cache.dart';

part 'splash_view_model.g.dart';

class SplashViewModel = _SplashViewModelBase with _$SplashViewModel;

abstract class _SplashViewModelBase extends BaseViewModel with Store, DeviceAndCache {

  @observable
  bool isFirstInit = true;

  void dispose() {}

  @override
  void init() {
    startAnimationOnView();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controlAppState();
    });
  }
  @override
  void setContext(BuildContext context) {
    viewModelContext = context;
  }

  Future<void> controlAppState() async {
    await deviceInit();
  }

  Future<void> startAnimationOnView() async {
    await Future.delayed(viewModelContext.durationSlow);
    _changeFirstInit();
    _navigateToHome();

  }

  @action
  void _changeFirstInit() {
    isFirstInit = !isFirstInit;
  }

  @action
  _navigateToHome() {
    navigation.navigateToPageClear(path: NavigationConstants.HOME);
  }
}
