import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/text_styles.dart';

class DefaultTextField extends StatelessWidget {
  final String title;
  final String? placeholder;
  final TextEditingController? controller;

  const DefaultTextField({
    super.key,
    required this.title,
    this.placeholder,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.caption,
        ),
        TextField(
          controller: controller,
          cursorColor: ColorStyles.black,
          cursorWidth: 1.0,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: TextStyles.colorCaption(ColorStyles.gray4),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyles.gray3, width: 1.0),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorStyles.primary, width: 1.0),
            ),
            contentPadding: const EdgeInsets.only(left: 8.0),
          ),
        ),
      ],
    );
  }
}
