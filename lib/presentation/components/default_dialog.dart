import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';
import 'package:moi_interview/utils/text_styles.dart';

class DefaultDialog extends StatelessWidget {
  final String title;
  final String placeHolder;
  final TextEditingController? controller;

  const DefaultDialog({
    super.key,
    this.controller,
    required this.title,
    required this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorStyles.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: getWidth(200),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.subHeading,
              ),
              SizedBox(height: getHeight(8.0)),
              TextField(
                cursorColor: ColorStyles.black,
                cursorWidth: 1.0,
                controller: controller,
                decoration: InputDecoration(
                  hintText: placeHolder,
                  hintStyle: TextStyles.colorCaption(ColorStyles.gray4),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorStyles.gray3, width: 1.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorStyles.black, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 8.0),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('취소', style: TextStyles.body2),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('확인', style: TextStyles.colorBody2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
