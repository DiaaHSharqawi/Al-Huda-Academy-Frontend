import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_create_group_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_add_group_plan_card.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_content_drop_down.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_content_drop_down_ayahs.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_group_content_check_header.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_selected_group_content.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:table_calendar/table_calendar.dart';

class SupervisorCreateGroupPlanScreen
    extends GetView<SupervisorCreateGroupPlanController> {
  const SupervisorCreateGroupPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return const CustomLoadingWidget(
                      width: 600.0,
                      height: 600.0,
                      imagePath: AppImages.loadingImage,
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCreateGroupPlanSection(),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        bottomNavigationBar: SupervisorCustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildCreateGroupPlanSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCreateGroupPlanHeader(),
        const SizedBox(
          height: 32.0,
        ),
        _buildDayDatePicker(),
        const SizedBox(
          height: 32.0,
        ),
        _buildGroupContentToReviewSection(),
        const SizedBox(
          height: 16.0,
        ),
        _buildGroupContentToMemorizeSection(),
        _buildNoteSection(),
        const SizedBox(
          height: 32.0,
        ),
        _buildCreateGroupPlanButton(),
      ],
    );
  }

  Widget _buildNoteSection() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomGoogleTextWidget(
            text: "هل لديك اي ملاحظة (اختياري)",
            fontSize: 16.0,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16.0),
          CustomTextFormField(
            controller: controller.noteController,
            maxLines: 5,
            textFormHintText: "اكتب ملاحظتك هنا",
            textFormFieldValidator: (String? value) {
              return null;
            },
            autovalidateMode: controller.noteController.text.isNotEmpty
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
          ),
        ],
      ),
    );
  }

  Widget _buildCreateGroupPlanButton() {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () {
          return CustomButton(
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: "إضافة خطة",
            buttonTextColor: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            onPressed: () async {},
            loadingWidget: controller.isLoading.value
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : null,
            isEnabled: !controller.isLoading.value,
          );
        },
      ),
    );
  }
// ----- Start of memorize Section -----

  Widget _buildGroupContentToMemorizeSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _buildGroupContentToMemorizeHeader(),

        CustomGroupContentCheckHeader(
          textHeader: "موضع الحفظ",
          isContentSelected: controller.isContentToMemorizeSelected.value,
          onChanged: (val) {
            controller.isContentToMemorizeSelected.value = val!;
            !controller.isContentToMemorizeSelected.value
                ? controller.resetSelectedMemorizedContent()
                : null;
          },
        ),
        const SizedBox(
          height: 32.0,
        ),
        Obx(() {
          return controller.isContentToMemorizeSelected.value
              ? _buildMemorizeSection()
              : const SizedBox(
                  height: 8.0,
                );
        }),
      ],
    );
  }

  Widget _buildMemorizeSection() {
    return Column(
      children: [
        CustomAddGroupPlanCard(
          title: "إضافة حفظ",
          onAddGroupPlanTap: () {
            _showAddMemorizeDialog();
          },
        ),
        //   _buildSelectedContentToMemorize(),

        CustomSelectedGroupContent(
          selectedContent: controller.selectedMemorizeContnet,
          showEditMemorizeDialog: _showEditMemorizeDialog,
        ),
      ],
    );
  }

  void _showAddMemorizeDialog() {
    controller.selectedMemorizeFromSurah.value = 1;
    controller.selectedMemorizeToSurah.value = 1;

    controller.selectedMemorizeFromAyah.value = 1;
    controller.selectedMemorizeToAyah.value = 1;

    Get.dialog(
      AlertDialog(
        title: const CustomGoogleTextWidget(
          text: "اضافة حفظ",
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
                  hintText: "من سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedMemorizeFromSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedMemorizeFromAyah.value = 1;

                    controller.selectedMemorizeFromSurah.value = int.parse(
                      value!.id.toString(),
                    );

                    debugPrint(
                        "Selected selectedMemorizeFromSurah: ${controller.selectedMemorizeFromSurah}");
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => CustomContentDropDown(
                  hintText: "إلى سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedMemorizeToSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedMemorizeToAyah.value = 1;

                    controller.selectedMemorizeToSurah.value = value!.id!;
                  },
                ),
              ),

              //--------------------------------
              const SizedBox(height: 16.0),
              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "من آية",
                  selectedSurah: controller.selectedMemorizeFromSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedMemorizeFromAyah.value,
                  onChanged: (value) {
                    controller.selectedMemorizeFromAyah.value = (value!);
                    debugPrint(
                        "Selected selectedMemorizeFromAyah: ${controller.selectedMemorizeFromAyah}");
                  },
                ),
              ),
              //-----------------------------------
              const SizedBox(height: 16.0),
              //     _buildDropdownMemorizeToAyah(),

              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "إلى آية",
                  selectedSurah: controller.selectedMemorizeToSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedMemorizeToAyah.value,
                  onChanged: (value) {
                    controller.selectedMemorizeToAyah.value = (value!);
                    debugPrint(
                        "Selected selectedMemorizeToAyah: ${controller.selectedMemorizeToAyah}");
                  },
                ),
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
              // Handle the addition of review
              Get.back();

              controller.selectedMemorizeContnet.add(RxMap<dynamic, dynamic>({
                'startSurah': controller.selectedMemorizeFromSurah.value,
                'endSurah': controller.selectedMemorizeToSurah.value,
                'startAyah': controller.selectedMemorizeFromAyah.value,
                'endAyah': controller.selectedMemorizeToAyah.value,
                'startSurahName': controller.groupContentList
                    .firstWhereOrNull((element) =>
                        element.id ==
                        controller.selectedMemorizeFromSurah.value)
                    ?.name,
                'endSurahName': controller.groupContentList
                    .firstWhereOrNull((element) =>
                        element.id == controller.selectedMemorizeToSurah.value)
                    ?.name,
              }));

              controller.selectedMemorizeContnet.refresh();

              debugPrint(
                  "Selected Content: ${controller.selectedMemorizeContnet}");
            },
            child: const CustomGoogleTextWidget(
              text: 'تأكيد',
              fontSize: 16.0,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditMemorizeDialog(RxMap<dynamic, dynamic> content) {
    debugPrint("Content: $content");

    controller.selectedMemorizeFromSurah.value = content['startSurah'];
    controller.selectedMemorizeToSurah.value = content['endSurah'];
    controller.selectedMemorizeFromAyah.value = content['startAyah'];
    controller.selectedMemorizeToAyah.value = content['endAyah'];

    Get.dialog(
      AlertDialog(
        title: const CustomGoogleTextWidget(
          text: 'تعديل حفظ',
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
                  hintText: "من سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedMemorizeFromSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedMemorizeFromAyah.value = 1;

                    controller.selectedMemorizeFromSurah.value = int.parse(
                      value!.id.toString(),
                    );

                    debugPrint(
                        "Selected selectedMemorizeFromSurah: ${controller.selectedMemorizeFromSurah}");
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => CustomContentDropDown(
                  hintText: "إلى سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedMemorizeToSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedMemorizeToAyah.value = 1;

                    controller.selectedMemorizeToSurah.value = value!.id!;
                  },
                ),
              ),

              //--------------------------------
              const SizedBox(height: 16.0),
              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "من آية",
                  selectedSurah: controller.selectedMemorizeFromSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedMemorizeFromAyah.value,
                  onChanged: (value) {
                    controller.selectedMemorizeFromAyah.value = (value!);
                    debugPrint(
                        "Selected selectedMemorizeFromAyah: ${controller.selectedMemorizeFromAyah}");
                  },
                ),
              ),
              //-----------------------------------
              const SizedBox(height: 16.0),
              //     _buildDropdownMemorizeToAyah(),

              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "إلى آية",
                  selectedSurah: controller.selectedMemorizeToSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedMemorizeToAyah.value,
                  onChanged: (value) {
                    controller.selectedMemorizeToAyah.value = (value!);
                    debugPrint(
                        "Selected selectedMemorizeToAyah: ${controller.selectedMemorizeToAyah}");
                  },
                ),
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
              // Handle the edit of review
              Get.back();

              content['startSurah'] =
                  controller.selectedMemorizeFromSurah.value;

              content['endSurah'] = controller.selectedMemorizeToSurah.value;

              content['startAyah'] = controller.selectedMemorizeFromAyah.value;

              content['endAyah'] = controller.selectedMemorizeToAyah.value;

              content['startSurahName'] = controller.groupContentList
                  .firstWhereOrNull((element) =>
                      element.id == controller.selectedMemorizeFromSurah.value)
                  ?.name;
              content['endSurahName'] = controller.groupContentList
                  .firstWhereOrNull((element) =>
                      element.id == controller.selectedMemorizeToSurah.value)
                  ?.name;

              controller.selectedMemorizeContnet.refresh();

              debugPrint(
                  "Edited Content: ${controller.selectedMemorizeContnet}");
            },
            child: const CustomGoogleTextWidget(
              text: 'تأكيد',
              fontSize: 16.0,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

// ----- End of memorize Section -----

//***************************************************** */
  // ----- Start of review Section -----

  Widget _buildGroupContentToReviewSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomGroupContentCheckHeader(
          textHeader: "موضع المراجعة",
          isContentSelected: controller.isContentToReviewSelected.value,
          onChanged: (val) {
            controller.isContentToReviewSelected.value = val!;

            !controller.isContentToReviewSelected.value
                ? controller.resetSelectedReviewContent()
                : null;
          },
        ),
        const SizedBox(
          height: 32.0,
        ),
        Obx(() {
          return controller.isContentToReviewSelected.value
              ? _buildReviewSection()
              : const SizedBox(
                  height: 8.0,
                );
        }),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Column(
      children: [
        CustomAddGroupPlanCard(
          title: "إضافة مراجعة",
          onAddGroupPlanTap: () {
            _showAddReviewDialog();
          },
        ),
        CustomSelectedGroupContent(
          selectedContent: controller.selectedReviewContnet,
          showEditMemorizeDialog: _showEditReviewDialog,
        ),
      ],
    );
  }

  void _showAddReviewDialog() {
    controller.selectedReviewFromSurah.value = 1;
    controller.selectedReviewToSurah.value = 1;

    controller.selectedReviewFromAyah.value = 1;
    controller.selectedReviewToAyah.value = 1;

    Get.dialog(
      AlertDialog(
        title: const CustomGoogleTextWidget(
          text: 'إضافة مراجعة',
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
                  hintText: "من سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedReviewFromSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedReviewFromAyah.value = 1;

                    controller.selectedReviewFromSurah.value = int.parse(
                      value!.id.toString(),
                    );

                    debugPrint(
                        "Selected selectedReviewFromSurah: ${controller.selectedReviewFromSurah}");
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              //  _buildDropdownToSurah(),

              Obx(
                () => CustomContentDropDown(
                  hintText: "إلى سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedReviewToSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedReviewToAyah.value = 1;

                    controller.selectedReviewToSurah.value = value!.id!;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              //  _buildDropdownFromAyah(),
              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "من آية",
                  selectedSurah: controller.selectedReviewFromSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedReviewFromAyah.value,
                  onChanged: (value) {
                    controller.selectedReviewFromAyah.value = (value!);
                    debugPrint(
                        "Selected selectedReviewFromAyah: ${controller.selectedReviewFromAyah}");
                  },
                ),
              ),
              const SizedBox(height: 16.0),

              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "إلى آية",
                  selectedSurah: controller.selectedReviewToSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedReviewToAyah.value,
                  onChanged: (value) {
                    controller.selectedReviewToAyah.value = (value!);
                    debugPrint(
                        "Selected selectedReviewToAyah: ${controller.selectedReviewToAyah}");
                  },
                ),
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
              // Handle the addition of review
              Get.back();

              controller.selectedReviewContnet.add(RxMap<dynamic, dynamic>({
                'startSurah': controller.selectedReviewFromSurah.value,
                'endSurah': controller.selectedReviewToSurah.value,
                'startAyah': controller.selectedReviewFromAyah.value,
                'endAyah': controller.selectedReviewToAyah.value,
                'startSurahName': controller.groupContentList
                    .firstWhereOrNull((element) =>
                        element.id == controller.selectedReviewFromSurah.value)
                    ?.name,
                'endSurahName': controller.groupContentList
                    .firstWhereOrNull((element) =>
                        element.id == controller.selectedReviewToSurah.value)
                    ?.name,
              }));

              controller.selectedReviewContnet.refresh();

              debugPrint(
                  "Selected Content: ${controller.selectedReviewContnet}");
            },
            child: const CustomGoogleTextWidget(
              text: 'تأكيد',
              fontSize: 16.0,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showEditReviewDialog(RxMap<dynamic, dynamic> content) {
    debugPrint("Content: $content");

    controller.selectedReviewFromSurah.value = content['startSurah'];
    controller.selectedReviewToSurah.value = content['endSurah'];
    controller.selectedReviewFromAyah.value = content['startAyah'];
    controller.selectedReviewToAyah.value = content['endAyah'];

    Get.dialog(
      AlertDialog(
        title: const CustomGoogleTextWidget(
          text: 'تعديل مراجعة',
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
                  hintText: "من سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedReviewFromSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedReviewFromAyah.value = 1;

                    controller.selectedReviewFromSurah.value = int.parse(
                      value!.id.toString(),
                    );

                    debugPrint(
                        "Selected selectedReviewFromSurah: ${controller.selectedReviewFromSurah}");
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              //  _buildDropdownToSurah(),

              Obx(
                () => CustomContentDropDown(
                  hintText: "إلى سورة",
                  groupContentList: controller.groupContentList,
                  selectedContentId: controller.selectedReviewToSurah.value,
                  onChanged: (value) {
                    debugPrint("New Value : $value");

                    controller.selectedReviewToAyah.value = 1;

                    controller.selectedReviewToSurah.value = value!.id!;
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              //  _buildDropdownFromAyah(),
              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "من آية",
                  selectedSurah: controller.selectedReviewFromSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedReviewFromAyah.value,
                  onChanged: (value) {
                    controller.selectedReviewFromAyah.value = (value!);
                    debugPrint(
                        "Selected selectedReviewFromAyah: ${controller.selectedReviewFromAyah}");
                  },
                ),
              ),
              const SizedBox(height: 16.0),

              Obx(
                () => CustomContentDropDownAyahs(
                  hintText: "إلى آية",
                  selectedSurah: controller.selectedReviewToSurah.value,
                  groupContentList: controller.groupContentList,
                  selectedAyahId: controller.selectedReviewToAyah.value,
                  onChanged: (value) {
                    controller.selectedReviewToAyah.value = (value!);
                    debugPrint(
                        "Selected selectedReviewToAyah: ${controller.selectedReviewToAyah}");
                  },
                ),
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
              // Handle the edit of review
              Get.back();

              content['startSurah'] = controller.selectedReviewFromSurah.value;
              content['endSurah'] = controller.selectedReviewToSurah.value;
              content['startAyah'] = controller.selectedReviewFromAyah.value;
              content['endAyah'] = controller.selectedReviewToAyah.value;
              content['startSurahName'] = controller.groupContentList
                  .firstWhereOrNull((element) =>
                      element.id == controller.selectedReviewFromSurah.value)
                  ?.name;
              content['endSurahName'] = controller.groupContentList
                  .firstWhereOrNull((element) =>
                      element.id == controller.selectedReviewToSurah.value)
                  ?.name;

              controller.selectedReviewContnet.refresh();

              debugPrint("Edited Content: ${controller.selectedReviewContnet}");
            },
            child: const CustomGoogleTextWidget(
              text: 'تأكيد',
              fontSize: 16.0,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

// ----- End of review Section -----
  Widget _buildCreateGroupPlanHeader() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: const CustomGoogleTextWidget(
        text: "اضافة خطة للحلقة",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _buildDayDatePicker() {
    return GestureDetector(
      onTap: () async {
        await _showDatePickerDialog(Get.context!);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomGoogleTextWidget(
            text: "اختر اليوم الذي تريد اضافة خطة له",
            fontSize: 16.0,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => CustomGoogleTextWidget(
                    text: controller.selectedDate.value != null
                        ? controller.selectedDate.value.toString().split(' ')[0]
                        : 'اختر اليوم',
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomGoogleTextWidget(
            text: 'اضافة خطة ، من فضلك اختر اليوم',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
          content: SizedBox(
            width: 300.0,
            height: 450.0,
            child: SingleChildScrollView(
              child: Obx(
                () => TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  selectedDayPredicate: (day) =>
                      isSameDay(controller.selectedDate.value, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    debugPrint("Selected Day: $selectedDay");
                    controller.selectedDate(selectedDay);
                    controller.selectedDate.refresh();
                  },
                  focusedDay: controller.selectedDate.value ?? DateTime.now(),
                  calendarBuilders: CalendarBuilders(
                    selectedBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: CustomGoogleTextWidget(
                        text: date.day.toString(),
                        fontSize: 16.0,
                        color: AppColors.white,
                      ),
                    ),
                    todayBuilder: (context, date, events) => Container(
                      margin: const EdgeInsets.all(4.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: CustomGoogleTextWidget(
                        text: date.day.toString(),
                        fontSize: 16.0,
                        color: AppColors.white,
                      ),
                    ),
                    // Highlight custom days based on indices
                    defaultBuilder: (context, date, events) {
                      // Get the day of the week (1 = Sunday, 2 = Monday, ..., 7 = Saturday)
                      int dayOfWeek = (date.weekday % 7) +
                          1; // Adjust to match your index (1-7)
                      Iterable<int?> listOfWeekDays =
                          controller.supervisorGroupDaysList.map(
                        (e) => e.dayId,
                      );
                      bool isHighlighted = listOfWeekDays.contains(dayOfWeek);

                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              isHighlighted ? Colors.blue : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: CustomGoogleTextWidget(
                          text: date.day.toString(),
                          fontSize: 16.0,
                          color: isHighlighted
                              ? AppColors.white
                              : AppColors.blackColor,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const CustomGoogleTextWidget(
                text: 'إلغاء',
                fontSize: 16.0,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () async {
                //  Navigator.of(context).pop();
                await _handelCreateGroupPlan(context);
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
      },
    );
  }

  Future<void> _handelCreateGroupPlan(BuildContext context) async {
    try {
      CreateGroupPlanResponseModel createGroupPlanResponseModel =
          await controller.createGroupPlan();
      debugPrint("Create Group Plan Response : $createGroupPlanResponseModel");

      if (createGroupPlanResponseModel.statusCode == 200) {
        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: "تم اضافة الخطة الأسبوعية بنجاح",
          description:
              "تم اضافة الخطة الأسبوعية بنجاح بامكانك الان الانتقال اليها واضافة باقي التفاصيل",
          btnOkOnPress: () {
            //  controller.navigateToGroupPlanDetailsScreen();
          },
        );

        // await controller.fetchGroupPlans();
      } else {
        debugPrint(
            "Error Create Group Plan: ${createGroupPlanResponseModel.message}");

        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "خطأ",
          description: createGroupPlanResponseModel.message!,
          btnOkOnPress: () {},
        );
      }
    } catch (e) {
      debugPrint("Error _handelCreateGroupPlan : $e");
    }
  }

  PreferredSize _buildAppBar() {
    return const CustomAppBar(
      showBackArrow: true,
      arrowMargin: 16.0,
      preferredSize: Size.fromHeight(150.0),
      appBarBackgroundImage: "assets/images/ornament1.png",
      appBarChilds: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      child: SizedBox.expand(),
    );
  }
}
