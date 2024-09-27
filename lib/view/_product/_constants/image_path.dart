import 'package:pdv_windows/core/extension/string_extension.dart';

class ImagePaths {
  ImagePaths._init();

  static ImagePaths? _instance;

  static ImagePaths get instance {
    return _instance ??= ImagePaths._init();
  }

  ///APP
  String get logo => 'sti3-logo'.toImage;

}
