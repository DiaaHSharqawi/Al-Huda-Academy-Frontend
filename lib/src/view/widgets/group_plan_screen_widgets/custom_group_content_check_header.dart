import 'package:flutter/material.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomGroupContentCheckHeader extends StatelessWidget {
  const CustomGroupContentCheckHeader({
    super.key,
    required this.textHeader,
    required this.isContentSelected,
    required this.onChanged,
  });

  final String textHeader;
  final bool isContentSelected;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(16.0),
          child: CustomGoogleTextWidget(
            text: textHeader,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        GFToggle(
          enabledThumbColor: AppColors.primaryColor,
          enabledTrackColor: AppColors.primaryColor.withOpacity(0.5),
          onChanged: onChanged,
          value: isContentSelected,
          type: GFToggleType.ios,
        )
      ],
    );
  }
}
