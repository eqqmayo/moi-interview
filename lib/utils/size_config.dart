import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late Orientation orientation;
  static const double designWidth = 375.0;
  static const double designHeight = 812.0;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    width = MediaQuery.sizeOf(context).width;
    height = MediaQuery.sizeOf(context).height;
    orientation = _mediaQueryData.orientation;
  }
}

double getHeight(double inputHeight) {
  double screenHeightPortrait =
      (inputHeight / SizeConfig.designHeight) * SizeConfig.height;
  double screenHeightLandscape =
      (inputHeight / SizeConfig.designWidth) * SizeConfig.width;

  return SizeConfig.orientation == Orientation.portrait
      ? screenHeightPortrait
      : screenHeightLandscape;
}

double getWidth(double inputWidth) {
  double screenWidthPortrait =
      (inputWidth / SizeConfig.designWidth) * SizeConfig.width;
  double screenWidthLandscape =
      (inputWidth / SizeConfig.designWidth) * SizeConfig.height;
  return SizeConfig.orientation == Orientation.portrait
      ? screenWidthPortrait
      : screenWidthLandscape;
}
