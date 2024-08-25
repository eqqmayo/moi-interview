import 'package:flutter/material.dart';
import 'package:moi_interview/router.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        fontFamily: 'Pretendard',
        primaryColor: ColorStyles.primary,
      ),
    );
  }
}
