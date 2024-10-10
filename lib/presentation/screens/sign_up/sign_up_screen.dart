import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_text_field.dart';
import 'package:moi_interview/presentation/screens/sign_up/sign_up_view_model.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:moi_interview/ui/styles/text_styles.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameTextController = TextEditingController();
  final _wordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameTextController.addListener(_onTextChanged);
    _wordTextController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    final viewModel = context.read<SignUpViewModel>();
    viewModel.updateButtonState(
        _nameTextController.text, _wordTextController.text);
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
    final viewModel = context.watch<SignUpViewModel>();

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        backgroundColor: ColorStyles.white(context),
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
                        const SizedBox(height: 100),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '이름',
                                  style: TextStyles.colorHeading(context)),
                              TextSpan(
                                  text: '과 ',
                                  style: TextStyles.heading(context)),
                              TextSpan(
                                  text: '한마디',
                                  style: TextStyles.colorHeading(context)),
                              TextSpan(
                                  text: '를\n',
                                  style: TextStyles.heading(context)),
                              TextSpan(
                                  text: '입력해주세요',
                                  style: TextStyles.heading(context)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 48),
                        DefaultTextField(
                          title: '이름',
                          placeholder: ' 이름 또는 닉네임을 입력해주세요',
                          controller: _nameTextController,
                        ),
                        const SizedBox(height: 24),
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
                onPressed: viewModel.state.isButtonEnabled
                    ? () {
                        viewModel.createUser(
                          _nameTextController.text,
                          _wordTextController.text,
                        );
                        context.go('/home');
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
