import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';

abstract class TextStyles {
  static const TextStyle heading = TextStyle(
    color: ColorStyles.black,
    fontSize: 26,
  );

  static TextStyle colorHeading = heading.copyWith(color: ColorStyles.primary);

  static const TextStyle body = TextStyle(
    color: ColorStyles.black,
    fontSize: 20,
  );

  static const TextStyle caption = TextStyle(
    color: ColorStyles.black,
    fontSize: 15,
  );

  static TextStyle colorCaption = caption.copyWith(color: ColorStyles.gray1);
}
