import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAwesomeDialog {
  static Future<void> showAwesomeDialog(
      BuildContext context,
      DialogType dialogType,
      String title,
      String description,
      String fontFamily) async {
    return AwesomeDialog(
      context: context,
      dialogType: dialogType,
      title: title,
      desc: description,
      titleTextStyle: GoogleFonts.getFont(
        fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: GoogleFonts.getFont(
        fontFamily,
        fontSize: 16,
      ),
      btnOkOnPress: () {},
    ).show();
  }
}
