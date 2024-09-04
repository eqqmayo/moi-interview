import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/router.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';

Future<void> main() async {
  await Hive.initFlutter();
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
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(
            ColorStyles.primary.value,
            <int, Color>{
              50: ColorStyles.primary.withOpacity(0.1),
              100: ColorStyles.primary.withOpacity(0.2),
              200: ColorStyles.primary.withOpacity(0.3),
              300: ColorStyles.primary.withOpacity(0.4),
              400: ColorStyles.primary.withOpacity(0.5),
              500: ColorStyles.primary,
              600: ColorStyles.primary.withOpacity(0.7),
              700: ColorStyles.primary.withOpacity(0.8),
              800: ColorStyles.primary.withOpacity(0.9),
              900: ColorStyles.primary.withOpacity(1),
            },
          ),
        ),
      ),
    );
  }
}
