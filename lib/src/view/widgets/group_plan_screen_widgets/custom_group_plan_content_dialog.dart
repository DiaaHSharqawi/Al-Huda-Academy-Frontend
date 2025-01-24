import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_content/group_content_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_content_drop_down.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_content_drop_down_ayahs.dart';

class CustomGroupPlanContentDialog extends StatelessWidget {
  const CustomGroupPlanContentDialog({
    super.key,
    required this.selectedSurahId,
    required this.selectedStartAyahId,
    required this.selectedEndAyahId,
    required this.groupContentList,
    required this.selectedReviewContnet,
    this.isEdit,
    this.editContent,
    required this.title,
  });

  final RxInt selectedSurahId;
  final RxInt selectedStartAyahId;
  final RxInt selectedEndAyahId;

  final List<GroupContent> groupContentList;

  final RxList<dynamic> selectedReviewContnet;

  final bool? isEdit;

  final RxMap<dynamic, dynamic>? editContent;

  final String title;

  @override
  Widget build(BuildContext context) {
    if (isEdit == true) {
      debugPrint("selectedSurahId: $selectedSurahId");
      debugPrint("selectedStartAyahId: $selectedStartAyahId");
      debugPrint("selectedEndAyahId: $selectedEndAyahId");

      debugPrint("editContent: ${editContent?['surahId'].runtimeType}");
      debugPrint("editContent: ${editContent?['startAyah']}");
      debugPrint("editContent: ${editContent?['endAyah']}");

      debugPrint("editContent: ${editContent?.runtimeType}");

      //selectedSurahId.value = editContent!['surahId'];
      /// selectedStartAyahId.value = editContent!['startAyah'];
      //selectedEndAyahId.value = editContent!['endAyah'];
    }

    return AlertDialog(
      title: CustomGoogleTextWidget(
        text: title,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => CustomContentDropDown(
                hintText: "اختر السورة",
                groupContentList: groupContentList,
                selectedContentId: selectedSurahId.value,
                onChanged: (value) {
                  selectedStartAyahId.value = 1;
                  selectedEndAyahId.value = 1;

                  selectedSurahId.value = int.parse(value!.id.toString());
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
            Obx(
              () => CustomContentDropDownAyahs(
                hintText: "من آية",
                selectedSurah: selectedSurahId.value,
                groupContentList: groupContentList,
                selectedAyahId: selectedStartAyahId.value,
                onChanged: (value) {
                  selectedStartAyahId.value = (value!);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Obx(
              () => selectedStartAyahId.value == selectedEndAyahId.value
                  ? const CustomGoogleTextWidget(
                      text: "لا يمكن أن تكون الآية من وإلى نفس الآية",
                      fontSize: 12.0,
                      color: Colors.red,
                    )
                  : const SizedBox.shrink(),
            ),
            Obx(
              () => CustomContentDropDownAyahs(
                hintText: "إلى آية",
                selectedSurah: selectedSurahId.value,
                groupContentList: groupContentList,
                selectedAyahId: selectedEndAyahId.value,
                onChanged: (value) {
                  selectedEndAyahId.value = (value!);
                },
              ),
            ),
            Obx(
              () => selectedStartAyahId.value > selectedEndAyahId.value
                  ? const CustomGoogleTextWidget(
                      text: "لا يمكن أن تكون الآية من أكبر من الآية إلى",
                      fontSize: 12.0,
                      color: Colors.red,
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const CustomGoogleTextWidget(
            text: 'إلغاء',
            fontSize: 16.0,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            if (selectedStartAyahId.value >= selectedEndAyahId.value) {
              return;
            }

            if (editContent != null) {
              editContent?.update('surahId', (_) => selectedSurahId.value);

              editContent?.update(
                  'startAyah', (_) => selectedStartAyahId.value);

              editContent?.update('endAyah', (_) => selectedEndAyahId.value);

              debugPrint("editContent: ${editContent?['surahId']}");
              debugPrint("editContent: ${editContent?['startAyah']}");
              debugPrint("editContent: ${editContent?['endAyah']}");

              debugPrint("editContent: ${editContent?.runtimeType}");

              selectedReviewContnet.refresh();

              selectedSurahId.value = 1;
              selectedStartAyahId.value = 1;
              selectedEndAyahId.value = 1;

              Get.back();
            } else {
              selectedReviewContnet.add(RxMap<dynamic, dynamic>({
                'surahId': selectedSurahId.value,
                'startAyah': selectedStartAyahId.value,
                'endAyah': selectedEndAyahId.value,
                'surahName': groupContentList
                    .firstWhereOrNull(
                        (element) => element.id == selectedSurahId.value)
                    ?.name,
              }));

              selectedReviewContnet.refresh();

              selectedSurahId.value = 1;
              selectedStartAyahId.value = 1;
              selectedEndAyahId.value = 1;

              Get.back();
            }
          },
          child: const CustomGoogleTextWidget(
            text: 'تأكيد',
            fontSize: 16.0,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
