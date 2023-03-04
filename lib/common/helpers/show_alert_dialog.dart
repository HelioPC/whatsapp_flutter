import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_flutter/common/extension/custom_theme_extension.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          style: TextStyle(
            color: context.theme.greyColor,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              btnText ?? 'Ok',
              style: TextStyle(
                color: context.theme.circleImageColor,
              ),
            ),
          )
        ],
      );
    },
  );
}
