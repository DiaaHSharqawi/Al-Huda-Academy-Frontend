import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class CustomAwesomeDialog {
  static Future<void> showAwesomeDialog({
    required BuildContext context,
    required DialogType dialogType,
    required String title,
    required String description,
    VoidCallback? btnOkOnPress,
    VoidCallback? btnCancelOnPress,
    bool dismissOnTouchOutside = true,
    String? btnOkText,
  }) async {
    final AppService appService = Get.find<AppService>();
    final String fontFamily =
        appService.isRtl.value ? AppFonts.arabicFont : AppFonts.englishFont;

    return AwesomeDialog(
      dismissOnTouchOutside: dismissOnTouchOutside,
      btnOkText: btnOkText ?? ButtonLanguageConstants.ok.tr,
      btnCancelText: ButtonLanguageConstants.cancel.tr,
      context: context,
      dialogType: dialogType,
      title: title,
      desc: description,
      buttonsTextStyle: GoogleFonts.getFont(
        color: Colors.white,
        fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleTextStyle: GoogleFonts.getFont(
        fontFamily,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: GoogleFonts.getFont(
        fontFamily,
        fontSize: 16,
      ),
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress,
    ).show();
  }
}
