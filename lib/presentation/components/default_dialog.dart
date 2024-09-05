import 'package:flutter/material.dart';
import 'package:moi_interview/utils/color_styles.dart';
import 'package:moi_interview/utils/size_config.dart';
import 'package:moi_interview/utils/text_styles.dart';

class DefaultDialog extends StatefulWidget {
  final String title;
  final String placeholder;
  final TextEditingController controller;
  final VoidCallback? onConfirmTapped;
  final VoidCallback? onCancelTapped;

  const DefaultDialog({
    super.key,
    required this.controller,
    required this.title,
    required this.placeholder,
    this.onConfirmTapped,
    this.onCancelTapped,
  });

  @override
  State<DefaultDialog> createState() => _DefaultDialogState();
}

class _DefaultDialogState extends State<DefaultDialog> {
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateButtonState);
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = widget.controller.text.isNotEmpty;
    });
  }

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
                widget.title,
                style: TextStyles.subHeading,
              ),
              SizedBox(height: getHeight(8.0)),
              TextField(
                cursorColor: ColorStyles.black,
                cursorWidth: 1.0,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle: TextStyles.colorCaption(ColorStyles.gray4),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorStyles.gray3, width: 1.0),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorStyles.primary, width: 1.0),
                  ),
                  contentPadding: const EdgeInsets.only(left: 8.0),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: widget.onCancelTapped,
                    child: const Text('취소', style: TextStyles.body2),
                  ),
                  TextButton(
                    onPressed: _isButtonEnabled ? widget.onConfirmTapped : null,
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
