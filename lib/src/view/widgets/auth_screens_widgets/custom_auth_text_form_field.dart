import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class CustomAuthTextFormField extends StatelessWidget {
  final String? textFormLabelText;
  final String textFormHintText;
  final IconData iconName;
  final Color colorIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? textFormFieldValidator;
  final AutovalidateMode autovalidateMode;
  final VoidCallback? onTap;

  const CustomAuthTextFormField({
    super.key,
    this.textFormLabelText,
    required this.textFormHintText,
    required this.iconName,
    required this.colorIcon,
    this.obscureText = false,
    required this.controller,
    required this.textFormFieldValidator,
    required this.autovalidateMode,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final AppService appService = Get.find<AppService>();

    final isArabic = appService.isRtl.value;
    final String fontFamily =
        isArabic ? AppFonts.arabicFont : AppFonts.englishFont;

    final TextDirection textFormDirection =
        isArabic ? TextDirection.ltr : TextDirection.rtl;
    final TextDirection hintTextDirection = textFormDirection;

    return TextFormField(
      autovalidateMode: autovalidateMode,
      obscureText: obscureText,
      validator: textFormFieldValidator,
      controller: controller,
      textAlign: TextAlign.end,
      decoration: InputDecoration(
        hintTextDirection: hintTextDirection,
        labelText: textFormLabelText,
        labelStyle: GoogleFonts.getFont(fontFamily),
        hintText: textFormHintText,
        hintStyle: GoogleFonts.getFont(
          fontFamily,
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        prefixIcon: InkWell(
          onTap: onTap,
          child: Icon(
            iconName,
            color: colorIcon,
          ),
        ),
      ),
      textDirection: textFormDirection,
    );
  }
}
