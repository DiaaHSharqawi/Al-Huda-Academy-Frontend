import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomAddGroupPlanCard extends StatelessWidget {
  const CustomAddGroupPlanCard({
    super.key,
    required this.title,
    required this.onAddGroupPlanTap,
  });

  final String title;
  final VoidCallback? onAddGroupPlanTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onAddGroupPlanTap!();
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomGoogleTextWidget(
                  text: title,
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
                const SizedBox(width: 16.0),
                const Icon(Icons.add, color: AppColors.primaryColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
