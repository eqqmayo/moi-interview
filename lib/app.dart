import 'package:flutter/material.dart';
import 'package:moi_interview/router.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Pretendard',
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorStyles.primary,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
    );
  }
}
