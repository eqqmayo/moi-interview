import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moi_interview/config/router.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Hive.box('user').isEmpty ? router.go('/sign_up') : router.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primary(context),
      body: const Center(
        child: Text(
          '모의\n면접',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            height: 1.0,
          ),
        ),
      ),
    );
  }
}
