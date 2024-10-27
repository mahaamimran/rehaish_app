import 'package:flutter/material.dart';
import 'package:rehaish_app/config/text_styles.dart';
import 'package:rehaish_app/config/color_constants.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelButtonText;
  final String confirmButtonText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.cancelButtonText,
    required this.confirmButtonText,
    required this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyles.appTitle),
      content: Text(content, style: TextStyles.caption(context).copyWith(color: Colors.black)),
      actions: [
        TextButton(
          onPressed: onCancel ?? () => Navigator.of(context).pop(),
          child: Text(cancelButtonText, style: const TextStyle(color: ColorConstants.primaryColor)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: Text(confirmButtonText, style: const TextStyle(color: ColorConstants.primaryColor)),
        ),
      ],
    );
  }
}
