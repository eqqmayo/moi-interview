import 'package:flutter/material.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/utils/color_styles.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: Center(child: DefaultButton(title: '시작하기')),
    );
  }
}
