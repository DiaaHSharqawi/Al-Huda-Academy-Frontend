import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:pinput/pinput.dart';

class OTPVerificationField extends StatelessWidget {
  final Color borderColor;
  final Color focusedBorderColor;
  final Color submittedBackgroundColor;
  final TextStyle textStyle;
  final double fieldWidth;
  final double fieldHeight;
  final int length;
  final Function(String)? onComplete;
  final TextEditingController controller;

  const OTPVerificationField({
    this.borderColor = Colors.blue,
    this.focusedBorderColor = AppColors.primaryColor,
    this.submittedBackgroundColor = const Color(0xFFEAEFF3),
    this.textStyle = const TextStyle(
      fontSize: 22,
      color: Color(0xFF1E3C57),
      fontWeight: FontWeight.w700,
    ),
    this.fieldWidth = 56,
    this.fieldHeight = 56,
    this.length = 4,
    super.key,
    this.onComplete,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: fieldWidth,
      height: fieldHeight,
      textStyle: textStyle,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: borderColor.withOpacity(0.4)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      color: Colors.white,
      border: Border.all(color: focusedBorderColor),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: focusedBorderColor.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      color: submittedBackgroundColor,
      border: Border.all(color: borderColor.withOpacity(0.2)),
    );

    final AppService appService = Get.find<AppService>();
    final isArabic = appService.isRtl.value;

    final TextDirection textDirection =
        isArabic ? TextDirection.ltr : TextDirection.rtl;
    return Directionality(
      textDirection: textDirection,
      child: Pinput(
        length: length,
        controller: controller,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        keyboardType: TextInputType.text,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        cursor: Container(
          width: 2,
          color: borderColor,
        ),
        onCompleted: onComplete,
      ),
    );
  }
}
