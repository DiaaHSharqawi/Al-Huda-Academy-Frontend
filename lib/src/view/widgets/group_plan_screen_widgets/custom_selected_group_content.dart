import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class CustomSelectedGroupContent extends StatelessWidget {
  const CustomSelectedGroupContent({
    super.key,
    required this.selectedContent,
    required this.showEditMemorizeDialog,
  });

  final RxList selectedContent;
  final void Function(RxMap<dynamic, dynamic> content) showEditMemorizeDialog;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(
            height: 32.0,
          ),
          SizedBox(
            width: double.infinity,
            child: CustomGoogleTextWidget(
              text: selectedContent.isEmpty
                  ? "لم يتم التحديد بعد"
                  : 'المحتوى المختار',
              fontSize: 16.0,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ),
          ...selectedContent.map((content) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomGoogleTextWidget(
                        text:
                            '${content['startSurahName'] ?? ''}${content['startSurahName'] != content['endSurahName'] ? ' - ${content['endSurahName'] ?? ''}' : ''}',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                      const SizedBox(height: 8.0),
                      CustomGoogleTextWidget(
                        text:
                            'من آية ${content['startAyah']} إلى آية ${content['endAyah']}',
                        fontSize: 14.0,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          showEditMemorizeDialog(content);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          debugPrint('delete');
                          debugPrint("content $content");

                          int index = selectedContent.indexWhere(
                              (element) => mapEquals(element, content));

                          debugPrint("index of content $index");

                          if (index != -1) {
                            selectedContent.removeAt(index);
                          }
                          selectedContent.refresh();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
