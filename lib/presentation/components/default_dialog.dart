import 'package:flutter/material.dart';
import 'package:moi_interview/ui/styles/color_styles.dart';
import 'package:moi_interview/ui/styles/text_styles.dart';

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
      backgroundColor: ColorStyles.white(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyles.subHeading(context),
              ),
              SizedBox(height: 8),
              TextField(
                cursorColor: ColorStyles.black(context),
                cursorWidth: 1.0,
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle:
                      TextStyles.colorCaption(context, ColorStyles.gray4),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorStyles.gray3, width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorStyles.primary(context), width: 1.0),
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
                    child: Text('취소', style: TextStyles.body2(context)),
                  ),
                  TextButton(
                    onPressed: _isButtonEnabled ? widget.onConfirmTapped : null,
                    child: Text('확인', style: TextStyles.colorBody2(context)),
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
