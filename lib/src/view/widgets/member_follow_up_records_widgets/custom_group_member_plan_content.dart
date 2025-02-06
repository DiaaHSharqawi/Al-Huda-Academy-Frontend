import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomGroupMemberPlanContent extends StatelessWidget {
  const CustomGroupMemberPlanContent({
    super.key,
    required this.content,
    required this.title,
  });

  final String title;
  final List<Map<String, dynamic>> content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        SizedBox(
          width: double.infinity,
          child: CustomGoogleTextWidget(
            text: content.isEmpty ? "لم يتم اضافة اي خطة لليوم" : title,
            fontSize: 16.0,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
        ...content.map((content) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.book,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 8.0),
                            CustomGoogleTextWidget(
                              text: '${content['Surah']['name']}',
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.format_textdirection_l_to_r_rounded,
                              color: AppColors.primaryColor,
                            ),
                            const SizedBox(width: 8.0),
                            CustomGoogleTextWidget(
                              text:
                                  'من آية ${content['startAyah']} إلى آية ${content['endAyah']}',
                              fontSize: 14.0,
                              color: AppColors.blackColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Add your image here
                    Image.asset(
                      AppImages.speech,
                      width: 80.0,
                      height: 80.0,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
