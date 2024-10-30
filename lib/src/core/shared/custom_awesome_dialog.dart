import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class CustomAwesomeDialog {
  static Future<void> showAwesomeDialog(BuildContext context,
      DialogType dialogType, String title, String description) async {
    final AppService appService = Get.find<AppService>();
    final String fontFamily =
        appService.isRtl.value ? AppFonts.arabicFont : AppFonts.englishFont;

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
