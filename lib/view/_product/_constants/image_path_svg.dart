import 'package:pdv_windows/core/extension/string_extension.dart';

class ImagePathsSVG {
  ImagePathsSVG._init();

  static ImagePathsSVG? _instance;

  static ImagePathsSVG get instance {
    return _instance ??= ImagePathsSVG._init();
  }

  ///APP
  final logo = 'logo'.toSVG;
}
