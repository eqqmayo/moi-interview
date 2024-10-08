import 'package:flutter/material.dart';

abstract class ColorStyles {
  static Color black(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF000000)
          : const Color(0xFFE3E3E3);

  static Color white(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF282828);

  static Color primary(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF001D85)
          : const Color(0xFF3750AC);

  static const Color gray1 = Color(0xFFA9A9A9);
  static const Color gray2 = Color(0xFF797979);
  static const Color gray3 = Color(0xFFE5E5EC);
  static const Color gray4 = Color(0xFFD9D9D9);

  static Color gray5(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFEEEEEE)
          : const Color(0xFF222222);
}
