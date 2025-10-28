import 'package:flutter/material.dart';

class DialogUtils {
  static showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static showMessageDialog({
    required BuildContext context,
    required String message,
    required String positiveActionTitle,
    required void Function() positiveActionPress,
    String? negativeActionTitle,
    void Function()? negativeActionPress,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: positiveActionPress,
            child: Text(
              positiveActionTitle,
            ),
          ),
          if (negativeActionPress != null) ...[
            TextButton(
              onPressed: negativeActionPress,
              child: Text(
                negativeActionTitle!,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
