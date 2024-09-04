import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class QuestionModal extends StatefulWidget {
  const QuestionModal({super.key});

  @override
  _QuestionModalState createState() => _QuestionModalState();
}

class _QuestionModalState extends State<QuestionModal> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  String _question = '';
  int _answerTime = 2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '질문',
              style: TextStyles.subHeading,
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: _controller,
              cursorColor: ColorStyles.black,
              cursorWidth: 1.0,
              decoration: InputDecoration(
                hintText: '질문을 입력하세요',
                hintStyle: TextStyles.colorCaption(ColorStyles.gray4),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.gray3, width: 1.0),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: ColorStyles.primary, width: 1.0),
                ),
                contentPadding: const EdgeInsets.only(left: 8.0),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '질문을 입력해주세요';
                }
                return null;
              },
              onSaved: (value) {
                _question = value!;
              },
            ),
            const SizedBox(height: 20),
            const Text('답변 시간', style: TextStyles.subHeading),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (int index) {
                  setState(() {
                    _answerTime = index + 1;
                  });
                },
                scrollController: FixedExtentScrollController(initialItem: 2),
                children: List<Widget>.generate(5, (int index) {
                  return Center(
                    child: Text(
                      '${index + 1} 분',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('취소',
                      style: TextStyles.body2.copyWith(fontSize: 17)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.pop(context,
                          {'question': _question, 'answerTime': _answerTime});
                    }
                  },
                  child: Text('저장',
                      style: TextStyles.colorBody2.copyWith(fontSize: 17)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
