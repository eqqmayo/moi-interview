import 'package:flutter/material.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';

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
        height: 56,
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
              backgroundColor: onPressed == null
                  ? ColorStyles.gray4
                  : ColorStyles.primary(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              )),
          child: Text(
            title,
            style: TextStyle(
              color: onPressed == null ? ColorStyles.gray2 : Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
