import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moi_interview/domain/model/user.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_text_field.dart';
import 'package:moi_interview/presentation/screens/setting/setting_view_model.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:moi_interview/ui/styles/text_styles.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final TextEditingController _nameTextController;
  late final TextEditingController _wordTextController;
  late final SettingViewModel _viewModel;

  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _viewModel = context.read<SettingViewModel>();

    _nameTextController =
        TextEditingController(text: _viewModel.state.user!.name);
    _wordTextController =
        TextEditingController(text: _viewModel.state.user!.word);

    _nameTextController.addListener(_onTextChanged);
    _wordTextController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    _viewModel.updateButtonState(
      name: _nameTextController.text,
      word: _wordTextController.text,
      imagePath: _imagePath,
    );
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _wordTextController.dispose();
    _nameTextController.removeListener(_onTextChanged);
    _wordTextController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _imagePath = image.path;
      _viewModel.updateButtonState(imagePath: image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingViewModel>();

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        backgroundColor: ColorStyles.white(context),
        appBar: AppBar(
          backgroundColor: ColorStyles.white(context),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 22,
            onPressed: () {
              context.pop(true);
            },
          ),
          title: Text('설정', style: TextStyles.heading2(context)),
          centerTitle: true,
        ),
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
                        const SizedBox(height: 40),
                        DefaultTextField(
                          title: '이름',
                          controller: _nameTextController,
                        ),
                        const SizedBox(height: 20),
                        DefaultTextField(
                          title: '한마디',
                          controller: _wordTextController,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '함께할 면접관(선택)',
                          style: TextStyles.caption(context),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Center(
                            child: Builder(
                              builder: (context) {
                                if (_imagePath != null) {
                                  return Image.file(
                                    File(_imagePath!),
                                    width: 400,
                                    height: 400,
                                  );
                                } else if (viewModel
                                        .state.user!.interviewerImgPath !=
                                    null) {
                                  return Image.file(
                                    File(viewModel
                                        .state.user!.interviewerImgPath!),
                                    width: 400,
                                    height: 400,
                                  );
                                } else {
                                  return Image.asset(
                                    'assets/images/interviewer.jpg',
                                    width: 400,
                                    height: 400,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              DefaultButton(
                title: '저장하기',
                onPressed: viewModel.state.isButtonEnabled
                    ? () {
                        final user = User(
                          name: _nameTextController.text,
                          word: _wordTextController.text,
                          interviewerImgPath: _imagePath,
                        );
                        viewModel.saveUser(user);
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
