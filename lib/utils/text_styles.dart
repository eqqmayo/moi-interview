import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';

abstract class TextStyles {
  static const TextStyle heading = TextStyle(
    color: ColorStyles.black,
    fontSize: 26,
  );

  static TextStyle colorHeading = heading.copyWith(color: ColorStyles.primary);

  static const TextStyle subHeading = TextStyle(
    color: ColorStyles.black,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(
    color: ColorStyles.black,
    fontSize: 20,
  );

  static TextStyle colorBody = body.copyWith(color: ColorStyles.primary);

  static const TextStyle body2 = TextStyle(
    color: ColorStyles.black,
    fontSize: 16,
  );

  static TextStyle colorBody2 = body2.copyWith(color: ColorStyles.primary);

  static const TextStyle caption = TextStyle(
    color: ColorStyles.black,
    fontSize: 15,
  );

  static TextStyle colorCaption(Color color) {
    return caption.copyWith(color: color);
  }
}
