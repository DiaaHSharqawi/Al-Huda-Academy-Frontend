import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';

class CustomNotificationsDialog extends StatelessWidget {
  const CustomNotificationsDialog({super.key, required this.dialogShown});

  final RxBool dialogShown;

  @override
  Widget build(BuildContext context) {
    // Call this to show the dialog
    if (!dialogShown.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        dialogShown.value = true;
        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          title: 'تحت المراجعة',
          description: 'حسابك قيد المراجعة من قبل الادارة',
          btnOkOnPress: () {
            Navigator.of(context).pushReplacementNamed('/login');
          },
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          btnOkText: 'تسجيل الخروج',
        );
      });
    }

    return Container(); // Still return a widget
  }
}
