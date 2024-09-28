import 'package:hive/hive.dart';
import 'package:kartal/kartal.dart';
import 'package:path_provider/path_provider.dart';

mixin DeviceAndCache {
  Future<void> deviceInit() async {
      DeviceUtility.instance.initPackageInfo();
      var path = await getApplicationDocumentsDirectory();
      Hive.init(path.path);
  }
}
