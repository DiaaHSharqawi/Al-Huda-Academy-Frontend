import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/group_member_follow_up_records_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/member_follow_up_records_widgets/custom_group_member_plan_content.dart';

class GroupMemberFollowUpRecordsScreen
    extends GetView<GroupMemberFollowUpRecordsController> {
  const GroupMemberFollowUpRecordsScreen({super.key});

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
                          _buildHeaderSection(),
                          const SizedBox(
                            height: 32.0,
                          ),
                          _buildDateScroller(),
                          const SizedBox(
                            height: 32.0,
                          ),
                          _buildGroupMemberFollowUpRecords(),
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

  Widget _buildGroupMemberFollowUpRecords() {
    return Obx(
      () {
        final groupMemberFollowUpRecord =
            controller.groupMemberFollowUpRecords.value;
        if (groupMemberFollowUpRecord == null) {
          return const CustomGoogleTextWidget(
            text: "لا يوجد سجلات متابعة لهذا العضو",
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          );
        } else {
          return Column(
            children: [
              _buildToggleButtonsAttendanceStatus(),
              const SizedBox(
                height: 32.0,
              ),
              _buildReviewSection(),
              const SizedBox(
                height: 32.0,
              ),
              _buildGradeOfReview(),
              const SizedBox(
                height: 32.0,
              ),
              _buildMemorizeSection(),
              const SizedBox(
                height: 32.0,
              ),
              buildGradeOfMemorize(),
            ],
          );
        }
      },
    );
  }

  Widget _buildGradeOfReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "درجة المراجعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextFormField(
          controller: controller.gradeOfReviewController,
          keyboardType: TextInputType.number,
          textFormHintText: "أدخل درجة المراجعة",
          onChanged: (value) {
            controller.gradeOfReviewController.text = value;
          },
          textFormFieldValidator: Validations.validateGrade,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Widget buildGradeOfMemorize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "درجة الحفظ",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextFormField(
          controller: controller.gradeOfMemorizeController,
          keyboardType: TextInputType.number,
          textFormHintText: "أدخل درجة الحفظ",
          textFormFieldValidator: Validations.validateGrade,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            controller.gradeOfMemorizeController.text = value;
          },
        ),
      ],
    );
  }

  Widget _buildToggleButtonsAttendanceStatus() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "حالة الحضور",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
          textAlign: TextAlign.start,
        ),
        const SizedBox(
          height: 16.0,
        ),
        ToggleButtons(
          isSelected: List.generate(
              controller.attendanceStatusList.length,
              (index) =>
                  controller.attendanceStatusList[index] ==
                  controller.selectedAttendanceStatusId.value),
          onPressed: (int index) {
            controller.selectedAttendanceStatusId.value =
                controller.attendanceStatusList[index];
          },
          borderRadius: BorderRadius.circular(10.0),
          selectedBorderColor: AppColors.primaryColor,
          selectedColor: AppColors.white,
          fillColor: AppColors.primaryColor.withOpacity(0.2),
          color: AppColors.blackColor,
          borderColor: AppColors.primaryColor,
          children: controller.attendanceStatusList.map((status) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomGoogleTextWidget(
                text: status.nameAr!,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return GFAccordion(
      title: "بيانات المراجعة",
      textStyle: const TextStyle(
        color: AppColors.blackColor,
        fontSize: 18.0,
        fontFamily: AppFonts.arabicFont,
        fontWeight: FontWeight.bold,
      ),
      titleBorderRadius: BorderRadius.circular(10.0),
      titlePadding: const EdgeInsets.all(16.0),
      contentPadding: const EdgeInsets.all(16.0),
      expandedTitleBackgroundColor: AppColors.primaryColor.withOpacity(0.3),
      collapsedTitleBackgroundColor: AppColors.primaryColor.withOpacity(0.3),
      contentChild: Column(
        children: [
          CustomGroupMemberPlanContent(
            title: "بيانات المراجعة",
            content: controller.groupMemberFollowUpRecords.value?.groupPlan!
                    .contentToReviews
                    .map((content) => content.toJson())
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }

  Widget _buildMemorizeSection() {
    return GFAccordion(
      title: "بيانات الحفظ",
      textStyle: const TextStyle(
        color: AppColors.blackColor,
        fontSize: 18.0,
        fontFamily: AppFonts.arabicFont,
        fontWeight: FontWeight.bold,
      ),
      titleBorderRadius: BorderRadius.circular(10.0),
      titlePadding: const EdgeInsets.all(16.0),
      contentPadding: const EdgeInsets.all(16.0),
      expandedTitleBackgroundColor: AppColors.primaryColor.withOpacity(0.3),
      collapsedTitleBackgroundColor: AppColors.primaryColor.withOpacity(0.3),
      contentChild: Column(
        children: [
          CustomGroupMemberPlanContent(
            title: "بيانات المراجعة",
            content: controller.groupMemberFollowUpRecords.value?.groupPlan!
                    .contentToMemorizes
                    .map((content) => content.toJson())
                    .toList() ??
                [],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      margin: const EdgeInsets.only(top: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.creeper,
                width: 50.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 16.0,
              ),
              const CustomGoogleTextWidget(
                text: "سجل متابعة المشترك",
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
              const SizedBox(
                width: 16.0,
              ),
              Image.asset(
                AppImages.creeper,
                width: 50.0,
                height: 50.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateScroller() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: _buildDateSliderWithIcons(),
    );
  }

  Widget _buildDateSliderWithIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primaryColor,
            size: 32.0,
          ),
          onPressed: () {},
        ),
        Obx(
          () {
            final selectedDate = controller.selectedDate.value;

            final formattedDate =
                '${selectedDate!.day} / ${selectedDate.month} / ${selectedDate.year}';
            return CustomGoogleTextWidget(
              text: formattedDate,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: AppColors.primaryColor,
            size: 32.0,
          ),
          onPressed: () {},
        ),
      ],
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
