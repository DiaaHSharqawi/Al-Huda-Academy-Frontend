import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomAddGroupContentPlanCard extends StatelessWidget {
  const CustomAddGroupContentPlanCard({
    super.key,
    this.title,
    this.padding = 16,
    required this.onAddGroupPlanTap,
  });

  final String? title;
  final VoidCallback? onAddGroupPlanTap;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onAddGroupPlanTap!();
          },
          child: Container(
            padding: EdgeInsets.all(padding!),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (title != null) ...[
                  CustomGoogleTextWidget(
                    text: title!,
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(width: 16.0),
                ],
                const Icon(Icons.add, color: AppColors.primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
