import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/create_group_supervisor_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/group_validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class CreateGroupSupervisorScreen
    extends GetView<CreateGroupSupervisorController> {
  const CreateGroupSupervisorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildHeaderText(),
                const SizedBox(
                  height: 16.0,
                ),
                _buildGroupNameField(),
                const SizedBox(
                  height: 32.0,
                ),
                _buildGroupDescriptionField(),
                const SizedBox(
                  height: 32.0,
                ),
                _buildGroupCapacityField(),
                const SizedBox(
                  height: 32.0,
                ),
                _buildGroupTime(context),
                const SizedBox(
                  height: 32.0,
                ),
                _buildDayPicker(),
                const SizedBox(
                  height: 32.0,
                ),
                _buildCreateGroupButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateGroupButton(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          child: CustomButton(
            loadingWidget: controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : null,
            foregroundColor: Colors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: "انشاء المجموعة",
            buttonTextColor: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            onPressed: () async {
              final createANewMemorizationGroupResponse =
                  await controller.createANewMemorizationGroup();

              debugPrint("Response: ");
              debugPrint(createANewMemorizationGroupResponse.toString());
              if (!context.mounted) return;

              debugPrint(
                  "Response ---->: ${createANewMemorizationGroupResponse['statusCode']}");
              if (createANewMemorizationGroupResponse['statusCode'] == 201) {
                await CustomAwesomeDialog.showAwesomeDialog(
                  context,
                  DialogType.success,
                  "تم ارسال طلب لانشاء المجموعة",
                  "تم ارسال طلب لانشاء المجموعة ، سيتم مراجعة الطلب من قبل الادارة وسيتم اعلامك بالنتيجة",
                );
                controller.navigateToSuperVisorHomeScreen();
              } else {
                CustomAwesomeDialog.showAwesomeDialog(
                  context,
                  DialogType.error,
                  "حدث خطأ ما",
                  createANewMemorizationGroupResponse['message'],
                );
              }
            },
          ),
        ));
  }

  Widget _buildDayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "اختر يوم المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Obx(() => Wrap(
              spacing: 8.0,
              children: controller.daysOfWeekArabic.map((day) {
                return ChoiceChip(
                  label: CustomGoogleTextWidget(
                    text: day,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  selected: controller.selectedDays.contains(day),
                  onSelected: (selected) {
                    if (selected) {
                      controller.selectedDays.add(day);
                    } else {
                      controller.selectedDays.remove(day);
                    }
                  },
                );
              }).toList(),
            )),
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

  Widget _buildHeaderText() {
    return const CustomGoogleTextWidget(
      text: "انشاء مجموعة جديدة",
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  Widget _buildGroupNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        const CustomGoogleTextWidget(
          text: "اسم المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomAuthTextFormField(
          textFormHintText: "مجموعة عمر بن الخطاب",
          controller: controller.groupNameController,
          textFormFieldValidator: GroupValidations.validateGroupName,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
        ),
      ],
    );
  }

  Widget _buildGroupDescriptionField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "وصف المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomTextFormField(
          maxLines: 5,
          textFormHintText: 'أكتب هنا',
          controller: controller.groupDescriptionController,
          textFormFieldValidator: GroupValidations.validateGroupDescription,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          onTap: () {
            debugPrint('onTap');
          },
        ),
      ],
    );
  }

  Widget _buildGroupCapacityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16.0,
        ),
        const CustomGoogleTextWidget(
          text: "عدد الطلاب المسموح بهم",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        CustomAuthTextFormField(
          textFormHintText: '12',
          controller: controller.groupCapacityController,
          textFormFieldValidator: GroupValidations.validateGroupCapacity,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Widget _buildGroupTime(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "وقت المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 24.0,
        ),
        _buildStartTime(context),
        const SizedBox(
          height: 16.0,
        ),
        _buildEndTime(context),
      ],
    );
  }

  Widget _buildStartTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomGoogleTextWidget(
          text: "وقت البدء",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Obx(() => Expanded(
              child: GestureDetector(
                onTap: () async {
                  debugPrint('onTap');
                  debugPrint(controller.selectedStartTime.value
                      .format(context)
                      .toString());
                  final result = await Navigator.of(context).push(
                    showPicker(
                      context: context,
                      sunrise: const TimeOfDay(hour: 6, minute: 0),
                      sunset: const TimeOfDay(hour: 18, minute: 0),
                      duskSpanInMinutes: 120, // optional
                      onChange: (value) {
                        controller.selectedStartTime.value =
                            TimeOfDay(hour: value.hour, minute: value.minute);
                        debugPrint(
                            "Time: ${controller.selectedStartTime.value}");
                      },
                      value: Time(
                        hour: controller.selectedStartTime.value.hour,
                        minute: controller.selectedStartTime.value.minute,
                      ),
                    ),
                  );
                  if (result != null) {
                    controller.selectedStartTime.value = TimeOfDay(
                      hour: (result as Time).hour,
                      minute: result.minute,
                    );
                  }
                },
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: CustomGoogleTextWidget(
                    textDirection: TextDirection.ltr,
                    text: controller.selectedStartTime.value
                        .format(context)
                        .toString(),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildEndTime(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomGoogleTextWidget(
          text: "وقت الانتهاء",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          width: 16.0,
        ),
        Obx(() => Expanded(
              child: GestureDetector(
                onTap: () async {
                  debugPrint('onTap');
                  debugPrint(controller.selectedEndTime.value
                      .format(context)
                      .toString());
                  final result = await Navigator.of(context).push(
                    showPicker(
                      context: context,
                      sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
                      sunset: const TimeOfDay(hour: 18, minute: 0), // optional
                      duskSpanInMinutes: 120, // optional
                      onChange: (value) {
                        controller.selectedEndTime.value =
                            TimeOfDay(hour: value.hour, minute: value.minute);
                        debugPrint("Time: $value");
                      },
                      value: Time(
                        hour: controller.selectedEndTime.value.hour,
                        minute: controller.selectedEndTime.value.minute,
                      ),
                    ),
                  );
                  if (result != null) {
                    controller.selectedEndTime.value = TimeOfDay(
                      hour: (result as Time).hour,
                      minute: result.minute,
                    );
                  }
                },
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: CustomGoogleTextWidget(
                    textDirection: TextDirection.ltr,
                    text: controller.selectedEndTime.value
                        .format(context)
                        .toString(),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
