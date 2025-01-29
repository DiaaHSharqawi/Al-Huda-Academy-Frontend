import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:intl/intl.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/group_member_follow_up_records_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_error_hint_message.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_member_follow_up_records/create_group_members_follow_up_records_response_model.dart';
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
                            height: 48.0,
                          ),
                          _buildGroupMemberFollowUpRecordsStatus(),
                          const SizedBox(
                            height: 48.0,
                          ),
                          _buildGroupMemberFollowUpRecords(context),
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

  Widget _buildGroupMemberFollowUpRecords(BuildContext context) {
    return Obx(
      () {
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
            const SizedBox(
              height: 32.0,
            ),
            _buildCreateGroupMembersFollowUpRecordsButton(context),
            const SizedBox(
              height: 32.0,
            ),
            _buildEditGroupMembersFollowUpRecordsButton(context),
          ],
        );
      },
    );
  }

  Widget _buildEditGroupMembersFollowUpRecordsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () {
          return controller.groupMemberFollowUpRecords.value != null &&
                  controller.isEdited.value
              ? CustomButton(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  buttonText: 'تعديل البيانات',
                  buttonTextColor: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
                    controller.isEditingGradeOfReview.value = true;
                  },
                  loadingWidget: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : null,
                  isEnabled: !controller.isLoading.value,
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCreateGroupMembersFollowUpRecordsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () {
          return controller.groupMemberFollowUpRecords.value == null
              ? CustomButton(
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.primaryColor,
                  buttonText: 'حفظ البيانات',
                  buttonTextColor: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
                    _handelCreateGroupMembersFollowUpRecords(context);
                  },
                  loadingWidget: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : null,
                  isEnabled: !controller.isLoading.value,
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _handelCreateGroupMembersFollowUpRecords(
      BuildContext context) async {
    try {
      CreateGroupMembersFollowUpRecordsResponseModel
          createGroupMemberFollowUpRecordsResponse =
          await controller.createGroupMemberFollowUpRecords();

      if (!context.mounted) return;

      if (createGroupMemberFollowUpRecordsResponse.statusCode == 200) {
        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: "تم ادخال سجل المتابعة بنجاح",
          description: createGroupMemberFollowUpRecordsResponse.message!,
          btnOkOnPress: () {},
        );
        controller.navigateToGroupMemberScreen();
      } else {
        CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "خطأ",
          description: createGroupMemberFollowUpRecordsResponse.message!,
          btnOkOnPress: () {},
        );
      }
    } catch (e) {
      // Handle error
      debugPrint('Error creating group member follow-up records: $e');
      if (!context.mounted) return;

      CustomAwesomeDialog.showAwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        title: "خطأ",
        description: e.toString(),
        btnOkOnPress: () {},
      );
    }
  }

  Widget _buildGradeOfReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomGoogleTextWidget(
              text: "درجة المراجعة",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
            controller.groupMemberFollowUpRecords.value == null
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                    onPressed: () {
                      controller.isEditingGradeOfReview.value = true;
                    },
                  ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        Obx(
          () => CustomTextFormField(
            controller: controller.gradeOfReviewController,
            keyboardType: TextInputType.number,
            textFormHintText: "أدخل درجة المراجعة",
            onChanged: (value) {
              controller.gradeOfReviewController.text = value;
            },
            textFormFieldValidator: Validations.validateGradeOfReview,
            autovalidateMode: controller.isSubmitting.value
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            isEnabled: controller.isEditingGradeOfReview.value,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Widget buildGradeOfMemorize() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomGoogleTextWidget(
              text: "درجة الحفظ",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
            controller.groupMemberFollowUpRecords.value == null
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primaryColor),
                    onPressed: () {
                      controller.isEditingGradeOfMemorize.value = true;
                    },
                  ),
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextFormField(
          controller: controller.gradeOfMemorizeController,
          keyboardType: TextInputType.number,
          textFormHintText: "أدخل درجة الحفظ",
          textFormFieldValidator: Validations.validateGradeOfMemorize,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            controller.gradeOfMemorizeController.text = value;
          },
          isEnabled: controller.isEditingGradeOfMemorize.value,
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Widget _buildToggleButtonsAttendanceStatus() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
          const SizedBox(
            height: 16.0,
          ),
          Obx(() {
            return controller.isSubmitting.value == true &&
                    controller.selectedAttendanceStatusId.value == null
                ? const CustomErrorHintMessage(
                    icon: Icons.error_outline_sharp,
                    text: "يجب اختيار حالة الحضور",
                    fontSize: 14,
                  )
                : const SizedBox.shrink();
          })
        ],
      ),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: controller.previousNavigationDate.value == null
                      ? Colors.grey
                      : Colors.blue,
                  size: 32.0,
                ),
                onPressed: controller.previousNavigationDate.value == null
                    ? null
                    : () {
                        controller.selectedDate.value =
                            controller.previousNavigationDate.value;
                        debugPrint(
                            "Previous Date: ${controller.selectedDate.value}");

                        controller.queryParams['dayDate'] =
                            controller.selectedDate.value;

                        controller.fetchGroupMemberFollowUpRecords();
                      },
              ),
            ),
            Obx(
              () {
                final selectedDate = controller.selectedDate.value;

                return CustomGoogleTextWidget(
                  text: DateFormat.yMMMMEEEEd('ar').format(selectedDate!),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                );
              },
            ),
            Obx(
              () => IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: controller.nextNavigationDate.value == null
                      ? Colors.grey
                      : Colors.blue,
                  size: 32.0,
                ),
                onPressed: controller.nextNavigationDate.value == null
                    ? null
                    : () {
                        controller.selectedDate.value =
                            controller.nextNavigationDate.value;
                        debugPrint(
                            "nextNavigationDate : ${controller.selectedDate.value}");

                        controller.queryParams['dayDate'] =
                            controller.selectedDate.value;

                        controller.fetchGroupMemberFollowUpRecords();
                      },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGroupMemberFollowUpRecordsStatus() {
    if (controller.groupMemberFollowUpRecords.value == null) {
      return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red[600],
            ),
            const SizedBox(width: 8.0),
            CustomGoogleTextWidget(
              text: "لم يتم ادخال سجل المتابعة لهذا اليوم",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.red[600],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: Colors.green[800],
            ),
            const SizedBox(width: 8.0),
            CustomGoogleTextWidget(
              text: "تم ادخال سجل المتابعة لهذا اليوم",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
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
