import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plan_details_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/delete_group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/edit_group_plan_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_add_group_content_plan_card.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_date_picker_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_group_plan_content_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_plan_screen_widgets/custom_selected_group_content.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorGroupPlanDetailsScreen
    extends GetView<SupervisorGroupPlanDetailsController> {
  const SupervisorGroupPlanDetailsScreen({super.key});

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
                          _builGroupPlanDetailsSection(context),
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

  Widget _builGroupPlanDetailsSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _builGroupPlanDetailsHeader(),
        const SizedBox(
          height: 32.0,
        ),
        _buildDayDateDetailsPicker(),
        const SizedBox(
          height: 32.0,
        ),
        _buildGroupContentToReviewSection(),
        const SizedBox(
          height: 64.0,
        ),
        const Divider(
          color: AppColors.primaryColor,
          thickness: 1.0,
        ),
        const SizedBox(
          height: 64.0,
        ),
        _buildGroupContentToMemorizeSection(),
        const SizedBox(
          height: 32.0,
        ),
        _buildNoteSection(),
        const SizedBox(
          height: 32.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(
              () {
                return controller.isContentChanged.value
                    ? Expanded(
                        flex: 1,
                        child: _buildEditGroupPlanButton(context),
                      )
                    : const SizedBox.shrink();
              },
            ),
            Expanded(
              flex: 1,
              child: _buildDeleteGroupPlanButton(context),
            ),
          ],
        ),
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
            text: "ملاحظات",
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

  Widget _buildEditGroupPlanButton(BuildContext context) {
    return Obx(
      () {
        return CustomButton(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          buttonText: "حفظ التعديلات",
          buttonTextColor: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          onPressed: () async {
            debugPrint("edit Group Plan Button Pressed");

            _buildConfirmSaveEditGroupPlanDialog(context);
          },
          loadingWidget: controller.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : null,
          isEnabled: !controller.isLoading.value,
        );
      },
    );
  }

  Future<void> _buildConfirmSaveEditGroupPlanDialog(BuildContext context) {
    return CustomAwesomeDialog.showAwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'تأكيد الحفظ',
      description: 'هل أنت متأكد من حفظ التعديلات',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _handelEditGroupPlan(context);
      },
    );
  }

  Future<void> _handelEditGroupPlan(BuildContext context) async {
    try {
      EditGroupPlanDetailsResponseModel editGroupPlanDetailsResponseModel =
          await controller.editGroupPlan();
      debugPrint(
          "editGroupPlanDetailsResponseModel : $editGroupPlanDetailsResponseModel");

      if (editGroupPlanDetailsResponseModel.statusCode == 200) {
        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: "تم تعديل الخطة الأسبوعية بنجاح",
          description:
              "تم تعديل الخطة الأسبوعية بنجاح يوم ${DateFormat.yMMMMEEEEd('ar').format(controller.selectedDate.value!)}",
          btnOkOnPress: () {},
        );

        controller.navigateToGroupPlanScreen();
      } else {
        debugPrint(
            "Error editGroupPlanDetailsResponseModel : ${editGroupPlanDetailsResponseModel.message}");

        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "خطأ",
          description: editGroupPlanDetailsResponseModel.message!,
          btnOkOnPress: () {},
        );
      }
    } catch (e) {
      debugPrint("Error _handelEditGroupPlan : $e");
    }
  }

  Future<void> _handelDeleteGroupPlan(BuildContext context) async {
    try {
      DeleteGroupPlanDetailsResponseModel deleteGroupPlanDetailsResponseModel =
          await controller.deleteGroupPlan();
      debugPrint(
          "deleteGroupPlanDetailsResponseModel : $deleteGroupPlanDetailsResponseModel");

      if (deleteGroupPlanDetailsResponseModel.statusCode == 200) {
        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: "تم حذف الخطة الأسبوعية بنجاح",
          description: "تم حذف الخطة الأسبوعية بنجاح",
          btnOkOnPress: () {},
        );

        controller.navigateToGroupPlanScreen();
      } else {
        debugPrint(
            "Error deleteGroupPlanDetailsResponseModel : ${deleteGroupPlanDetailsResponseModel.message}");

        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "خطأ",
          description: deleteGroupPlanDetailsResponseModel.message!,
          btnOkOnPress: () {},
        );
      }
    } catch (e) {
      debugPrint("Error _handelDeleteGroupPlan : $e");
    }
  }

  Widget _buildDeleteGroupPlanButton(BuildContext context) {
    return Obx(
      () {
        return CustomButton(
          foregroundColor: Colors.white,
          backgroundColor: Colors.redAccent.shade700,
          buttonText: "حذف",
          buttonTextColor: Colors.white,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          onPressed: () async {
            debugPrint("edit Group Plan Button Pressed");

            debugPrint(
                "remove Review Content: ${controller.selectedReviewContnet}");

            _buildConfirmDeleteGroupPlanDialog(context);
          },
          loadingWidget: controller.isLoading.value
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : null,
          isEnabled: !controller.isLoading.value,
        );
      },
    );
  }

  Future<void> _buildConfirmDeleteGroupPlanDialog(BuildContext context) {
    return CustomAwesomeDialog.showAwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      title: 'تأكيد الحذف',
      description: 'هل أنت متأكد من حذف الخطة',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        _handelDeleteGroupPlan(context);
      },
    );
  }
// ----- Start of memorize Section -----

  Widget _buildGroupContentToMemorizeSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.patternImage,
              width: 60.0,
              height: 60.0,
            ),
            const CustomGoogleTextWidget(
              text: "مواضع الحفظ",
              fontSize: 16.0,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            CustomAddGroupContentPlanCard(
              onAddGroupPlanTap: () {
                _showAddMemorizeDialog();
              },
            ),
          ],
        ),
        CustomSelectedGroupContent(
          selectedContent: controller.selectedMemorizeContnet,
          showEditMemorizeDialog: _showEditMemorizeDialog,
        ),
        Obx(() {
          return (controller.selectedMemorizeContnet.isEmpty &&
                      controller.selectedReviewContnet.isEmpty) &&
                  controller.isSubmitting.value
              ? const SizedBox(
                  width: double.infinity,
                  child: CustomGoogleTextWidget(
                    text: "من فضلك اختر موضع الحفظ",
                    fontSize: 16.0,
                    color: Colors.red,
                    textAlign: TextAlign.center,
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }

  void _showAddMemorizeDialog() {
    controller.resetSelectedMemorizedContent();

    Get.dialog(
      CustomGroupPlanContentDialog(
        title: "إضافة حفظ",
        selectedSurahId: controller.selectedMemorizeSurah,
        selectedStartAyahId: controller.selectedMemorizeFromAyah,
        selectedEndAyahId: controller.selectedMemorizeToAyah,
        groupContentList: controller.groupContentList,
        selectedReviewContnet: controller.selectedMemorizeContnet,
      ),
    );
  }

  void _showEditMemorizeDialog(RxMap<dynamic, dynamic> content) {
    debugPrint("Content: $content");

    debugPrint("Edit Memorize Dialog");

    debugPrint("content['surahId']: ${content['surahId']}");
    debugPrint("content['startAyah']: ${content['startAyah']}");
    debugPrint("content['endAyah']: ${content['endAyah']}");

    controller.selectedMemorizeToAyah.value = content['endAyah'];
    controller.selectedMemorizeFromAyah.value = content['startAyah'];
    controller.selectedMemorizeSurah.value = content['surahId'];

    Get.dialog(
      CustomGroupPlanContentDialog(
        title: "تعديل حفظ",
        selectedSurahId: controller.selectedMemorizeSurah,
        selectedStartAyahId: controller.selectedMemorizeFromAyah,
        selectedEndAyahId: controller.selectedMemorizeToAyah,
        groupContentList: controller.groupContentList,
        selectedReviewContnet: controller.selectedMemorizeContnet,
        isEdit: true,
        editContent: content,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.patternImage,
              width: 60.0,
              height: 60.0,
            ),
            const CustomGoogleTextWidget(
              text: "مواضع المراجعة",
              fontSize: 16.0,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              width: 32.0,
            ),
            CustomAddGroupContentPlanCard(
              padding: 8,
              onAddGroupPlanTap: () {
                _showAddReviewDialog();
              },
            ),
          ],
        ),
        CustomSelectedGroupContent(
          selectedContent: controller.selectedReviewContnet,
          showEditMemorizeDialog: _showEditReviewDialog,
        ),
      ],
    );
  }

  void _showAddReviewDialog() {
    debugPrint("Show Add Review Dialog");

    controller.resetSelectedReviewContent();

    Get.dialog(
      CustomGroupPlanContentDialog(
        title: "إضافة مراجعة",
        selectedSurahId: controller.selectedReviewSurah,
        selectedStartAyahId: controller.selectedReviewFromAyah,
        selectedEndAyahId: controller.selectedReviewToAyah,
        groupContentList: controller.groupContentList,
        selectedReviewContnet: controller.selectedReviewContnet,
      ),
    );
  }

  Future<void> _showEditReviewDialog(RxMap<dynamic, dynamic> content) async {
    debugPrint("Content: $content");

    debugPrint("Edit Review Dialog");

    debugPrint("content['surahId']: ${content['surahId']}");
    debugPrint("content['startAyah']: ${content['startAyah']}");
    debugPrint("content['endAyah']: ${content['endAyah']}");

    controller.selectedReviewToAyah.value = content['endAyah'];
    controller.selectedReviewFromAyah.value = content['startAyah'];
    controller.selectedReviewSurah.value = content['surahId'];

    debugPrint("selectedReviewSurah: ${controller.selectedReviewSurah}");
    debugPrint("selectedReviewFromAyah: ${controller.selectedReviewFromAyah}");
    debugPrint("selectedReviewToAyah: ${controller.selectedReviewToAyah}");

    await Get.dialog(
      CustomGroupPlanContentDialog(
        selectedEndAyahId: controller.selectedReviewToAyah,
        selectedStartAyahId: controller.selectedReviewFromAyah,
        selectedSurahId: controller.selectedReviewSurah,
        title: "تعديل مراجعة",
        groupContentList: controller.groupContentList,
        selectedReviewContnet: controller.selectedReviewContnet,
        isEdit: true,
        editContent: content,
      ),
    );

    debugPrint("content after dialog: $content");
  }

// ----- End of review Section -----
  Widget _builGroupPlanDetailsHeader() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text:
            "تفاصيل خطة الحلقة ، يوم ${DateFormat.yMMMMEEEEd('ar').format(controller.groupPlanDetails.value!.dayDate!)}",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDayDateDetailsPicker() {
    return GestureDetector(
      onTap: () async {
        await _showDatePickerDialog(Get.context!);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            flex: 1,
            child: CustomGoogleTextWidget(
              text: "اليوم:",
              fontSize: 16.0,
              color: AppColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Obx(
                    () => CustomGoogleTextWidget(
                      text: controller.selectedDate.value != null
                          ? DateFormat.yMMMMEEEEd('ar')
                              .format(controller.selectedDate.value!)
                          : 'لم يتم تحديد يوم',
                      fontSize: 16.0,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return controller.selectedDate.value == null &&
                    controller.isSubmitting.value
                ? const SizedBox(
                    width: double.infinity,
                    child: CustomGoogleTextWidget(
                      text: "من فضلك اختر اليوم",
                      fontSize: 16.0,
                      color: Colors.red,
                      textAlign: TextAlign.center,
                    ),
                  )
                : const SizedBox.shrink();
          }),
        ],
      ),
    );
  }

  Future<void> _showDatePickerDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDatePickerDialog(
          selectedDate: controller.selectedDate,
          markedDays: controller.supervisorGroupDaysList,
        );
      },
    );
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
