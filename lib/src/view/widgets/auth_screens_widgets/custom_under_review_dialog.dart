import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';

class CustomSupervisorAccountUnderReviewDialog extends StatelessWidget {
  const CustomSupervisorAccountUnderReviewDialog(
      {super.key, required this.controller});

  final SupervisorController controller;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.dialogShown.value) {
        controller.dialogShown.value = true;
        CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          title: 'تحت المراجعة',
          description: 'حسابك قيد المراجعة من قبل الادارة',
          btnOkOnPress: controller.navigateToLoginScreen,
          dismissOnTouchOutside: false,
          btnOkText: 'تسجيل الخروج',
        );
      }
    });

    return Container(); // Empty screen while dialog is active
  }
}
