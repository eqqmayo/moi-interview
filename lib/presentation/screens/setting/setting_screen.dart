import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moi_interview/presentation/components/default_button.dart';
import 'package:moi_interview/presentation/components/default_text_field.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _nameTextController =
      TextEditingController(text: Hive.box('user').get('name'));
  final TextEditingController _wordTextController =
      TextEditingController(text: Hive.box('user').get('word'));

  String? _imagePath = Hive.box('user').get('imagePath');

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
              _wordTextController.text.trim().isNotEmpty &&
              (_nameTextController.text != Hive.box('user').get('name') ||
                  _wordTextController.text != Hive.box('user').get('word')) ||
          _imagePath != Hive.box('user').get('imagePath');
    });
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
      setState(() {
        _imagePath = image.path;
        _isButtonEnabled = (_imagePath != Hive.box('user').get('imagePath'));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Scaffold(
        backgroundColor: ColorStyles.white,
        appBar: AppBar(
          backgroundColor: ColorStyles.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 22,
            onPressed: () {
              context.pop();
            },
          ),
          title: const Text('설정', style: TextStyles.heading2),
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
                        SizedBox(height: 40),
                        DefaultTextField(
                          title: '이름',
                          controller: _nameTextController,
                        ),
                        SizedBox(height: 20),
                        DefaultTextField(
                          title: '한마디',
                          controller: _wordTextController,
                        ),
                        SizedBox(height: 20),
                        const Text(
                          '함께할 면접관(선택)',
                          style: TextStyles.caption,
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: _pickImage,
                          child: Center(
                            child: _imagePath == null
                                ? Image.asset(
                                    'assets/images/interviewer.jpg',
                                    width: 400,
                                    height: 400,
                                  )
                                : Image.file(
                                    File(_imagePath!),
                                    width: 400,
                                    height: 400,
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
                onPressed: _isButtonEnabled
                    ? () async {
                        try {
                          final box = Hive.box('user');
                          box.put('name', _nameTextController.text);
                          box.put('word', _wordTextController.text);
                          box.put('imagePath', _imagePath);

                          setState(() {
                            _isButtonEnabled = false;
                          });
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
