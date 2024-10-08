import 'package:flutter/material.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';

abstract class TextStyles {
  static TextStyle heading(BuildContext context) => TextStyle(
        color: ColorStyles.black(context),
        fontSize: 26,
      );

  static TextStyle colorHeading(BuildContext context) =>
      heading(context).copyWith(color: ColorStyles.primary(context));

  static TextStyle heading2(BuildContext context) => TextStyle(
        color: ColorStyles.black(context),
        fontSize: 22,
        fontWeight: FontWeight.w500,
      );

  static TextStyle subHeading(BuildContext context) => TextStyle(
        color: ColorStyles.black(context),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  static TextStyle body(BuildContext context) => TextStyle(
        color: ColorStyles.black(context),
        fontSize: 20,
      );

  static TextStyle colorBody(BuildContext context) =>
      body(context).copyWith(color: ColorStyles.primary(context));

  static TextStyle body2(BuildContext context) => TextStyle(
        color: ColorStyles.black(context),
        fontSize: 16,
      );

  static TextStyle colorBody2(BuildContext context) =>
      body2(context).copyWith(color: ColorStyles.primary(context));

  static TextStyle caption(BuildContext context) => TextStyle(
        color: ColorStyles.black(context),
        fontSize: 15,
      );

  static TextStyle colorCaption(BuildContext context, Color color) {
    return caption(context).copyWith(color: color);
  }
}
