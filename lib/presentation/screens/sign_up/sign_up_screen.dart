import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_text_field.dart';
import 'package:moi_interview/utils/color_styles.dart';
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
    super.initState();
    _nameTextController.addListener(_onTextChanged);
    _wordTextController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isButtonEnabled = _nameTextController.text.trim().isNotEmpty &&
          _wordTextController.text.trim().isNotEmpty;
    });
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
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
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
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
                        SizedBox(height: 100),
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
                        SizedBox(height: 48),
                        DefaultTextField(
                          title: '이름',
                          placeholder: ' 이름 또는 닉네임을 입력해주세요',
                          controller: _nameTextController,
                        ),
                        SizedBox(height: 24),
                        DefaultTextField(
                          title: '한마디',
                          placeholder: ' 나를 응원하는 한마디를 작성해보세요',
                          controller: _wordTextController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DefaultButton(
                title: '시작하기',
                onPressed: _isButtonEnabled
                    ? () async {
                        try {
                          final box = Hive.box('user');
                          box.put('name', _nameTextController.text);
                          box.put('word', _wordTextController.text);

                          if (!mounted) return;

                          context.go('/home');
                        } catch (e) {
                          print('failed to save data: $e');
                        }
                      }
                    : null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
