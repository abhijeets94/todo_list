import 'package:flutter/cupertino.dart';

class SizeConstant {
  static MediaQueryData? _mediaQueryData;
  static double? screenHeight;
  static double? screenWidth;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData!.size.height;
    screenWidth = _mediaQueryData!.size.width;
  }
}
