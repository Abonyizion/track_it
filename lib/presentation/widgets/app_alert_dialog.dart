import 'package:flutter/material.dart';
import 'package:track_it/core/constants/app_colors.dart';

class AppAlertDialog extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;

  const AppAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmText = "OK",
    this.cancelText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppColors.scaffoldBgDark // Dark mode color
          : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelText,
            style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.white  // dark mode border
                    : AppColors.textDark,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: Text(confirmText,
          style: TextStyle(
            color: AppColors.red
          ),),
        ),
      ],
    );
  }
}
