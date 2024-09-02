import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;

  const DefaultButton({
    super.key,
    this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: getHeight(56),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor:
                  onPressed == null ? ColorStyles.gray4 : ColorStyles.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              )),
          child: Text(
            title,
            style: TextStyle(
              color: onPressed == null ? ColorStyles.gray2 : ColorStyles.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
