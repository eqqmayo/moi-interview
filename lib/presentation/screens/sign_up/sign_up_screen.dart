import 'package:flutter/material.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_text_field.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';
import 'package:moi_interview/utils/text_styles.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameTextController = TextEditingController();
  final _wordTextController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void initState() {
    _nameTextController.addListener(_onTextChanged);
    _wordTextController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _nameTextController.text.isNotEmpty &&
          _wordTextController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameTextController.removeListener(_onTextChanged);
    _wordTextController.removeListener(_onTextChanged);
    _nameTextController.dispose();
    _wordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getHeight(100)),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: '이름', style: TextStyles.colorHeading),
                            const TextSpan(
                                text: '과 ', style: TextStyles.heading),
                            TextSpan(
                                text: '한마디', style: TextStyles.colorHeading),
                            const TextSpan(
                                text: '를\n', style: TextStyles.heading),
                            const TextSpan(
                                text: '입력해주세요', style: TextStyles.heading),
                          ],
                        ),
                      ),
                      SizedBox(height: getHeight(48)),
                      DefaultTextField(
                        title: '이름',
                        palceHolder: ' 이름 또는 닉네임을 입력해주세요',
                        controller: _nameTextController,
                      ),
                      SizedBox(height: getHeight(24)),
                      DefaultTextField(
                        title: '한마디',
                        palceHolder: ' 나를 응원하는 한마디를 작성해보세요',
                        controller: _wordTextController,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DefaultButton(
              title: '시작하기',
              onPressed: _isButtonEnabled ? () {} : null,
            )
          ],
        ),
      ),
    );
  }
}
