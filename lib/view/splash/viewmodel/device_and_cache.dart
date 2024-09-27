import 'package:kartal/kartal.dart';

mixin DeviceAndCache {
  Future<void> deviceInit() async {
    await Future.wait([
      DeviceUtility.instance.initPackageInfo(),
    ]);
  }
}
