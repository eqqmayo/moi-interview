import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:moi_interview/ui/styles/text_styles.dart';

class QuestionModal extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onCancelTapped;
  final VoidCallback? onConfirmTapped;
  final void Function(int) onSelectedItemChanged;

  const QuestionModal({
    super.key,
    required this.controller,
    this.onCancelTapped,
    this.onConfirmTapped,
    required this.onSelectedItemChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorStyles.white(context),
      padding: const EdgeInsets.fromLTRB(25, 25, 25, 10),
      child: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '질문',
              style: TextStyles.subHeading(context),
            ),
            const SizedBox(height: 4),
            TextFormField(
              controller: controller,

              cursorColor: ColorStyles.black(context),
              cursorWidth: 1.0,
              decoration: InputDecoration(
                hintText: '질문을 입력하세요',
                hintStyle: TextStyles.colorCaption(context, ColorStyles.gray4),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.gray3, width: 1.0),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorStyles.primary(context), width: 1.0),
                ),
                contentPadding: const EdgeInsets.only(left: 8.0),
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return '질문을 입력해주세요';
              //   }
              //   return null;
              // },
              onSaved: (value) {},
            ),
            const SizedBox(height: 20),
            Text('답변 시간', style: TextStyles.subHeading(context)),
            const SizedBox(height: 8),
            SizedBox(
              height: 80,
              child: CupertinoPicker(
                itemExtent: 32,
                onSelectedItemChanged: (value) => onSelectedItemChanged(value),
                scrollController: FixedExtentScrollController(initialItem: 2),
                children: List.generate(5, (int index) {
                  return Center(
                    child: Text(
                      '${index + 1} 분',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: onCancelTapped,
                  child: Text('취소',
                      style: TextStyles.body2(context).copyWith(fontSize: 17)),
                ),
                TextButton(
                  onPressed: onConfirmTapped,
                  child: Text('저장',
                      style: TextStyles.colorBody2(context)
                          .copyWith(fontSize: 17)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
