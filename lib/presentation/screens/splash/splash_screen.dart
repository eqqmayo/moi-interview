import 'package:flutter/material.dart';
import 'package:moi_interview/router.dart';
import 'package:moi_interview/utils/color_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      router.go('/sign_up');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorStyles.primary,
      body: Center(
        child: Text(
          '모의\n면접',
          style: TextStyle(
            color: ColorStyles.white,
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
