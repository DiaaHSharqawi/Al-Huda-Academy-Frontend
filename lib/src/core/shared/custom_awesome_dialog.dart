import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CustomAwesomeDialog {
  static Future<void> showAwesomeDialog(BuildContext context,
      DialogType dialogType, String title, String description) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      title: title,
      desc: description,
      btnOkOnPress: () {},
    ).show();
  }
}
