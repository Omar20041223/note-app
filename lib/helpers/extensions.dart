import 'package:flutter/material.dart';
import 'app_styles.dart';

extension SnackbarContext on BuildContext {
  void showSnackBar({required String text}) {
    final snackBar = SnackBar(
      content: Text(text,style: AppStyles.font14lightTextW400,),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Close',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(this).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}

extension DialogContext on BuildContext {
  void showCustomDialog({
    required String title,
    required String content,
    Widget? confirmButton,
    Widget? cancelButton,
  }) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title,style: AppStyles.font14lightTextW400,),
          content: Text(content,style: AppStyles.font14lightTextW400,),
          actions: [
            if (confirmButton != null) confirmButton,
            if (cancelButton != null) cancelButton,
          ],
        );
      },
    );
  }
}
