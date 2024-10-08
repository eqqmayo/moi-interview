import 'package:flutter/material.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';

abstract class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorStyles.primary(context),
          brightness: Brightness.light,
        ),
        appBarTheme: AppBarTheme(
          color: ColorStyles.white(context),
          iconTheme: IconThemeData(color: ColorStyles.white(context)),
        ),
      );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorStyles.primary(context),
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          color: ColorStyles.black(context),
          iconTheme: IconThemeData(color: ColorStyles.white(context)),
        ),
      );
}
