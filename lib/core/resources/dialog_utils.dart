import 'package:evently_c16/core/resources/ColorsManager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsManager.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
