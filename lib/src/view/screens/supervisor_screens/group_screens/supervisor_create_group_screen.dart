import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/create_group_supervisor_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_radio_list_tile.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/group_validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_gender_group_enum.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorCreateGroupScreen
    extends GetView<SupervisorCreateGroupController> {
  const SupervisorCreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(
                      child: CustomLoadingWidget(
                        imagePath: 'assets/images/loaderLottie.json',
                        width: 600,
                        height: 600,
                      ),
                    )
                  : Column(
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
                        _buildGroupGender(),
                        const SizedBox(
                          height: 32.0,
                        ),
                        _buildGroupLevel(),
                        const SizedBox(
                          height: 32.0,
                        ),
                        _buildGroupObjective(),
                        const SizedBox(
                          height: 32.0,
                        ),
                        _buildContinueButton(context),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupObjective() {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "الهدف من المجموعة",
        fontSize: 16.0,
      ),
      children: [
        ...controller.groupGoals.map((goal) {
          return Obx(
            () => CustomRadioListTile<GroupObjectiveEnum>(
              title: CustomGoogleTextWidget(
                text: goal.groupGoalAr!,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: AppColors.blackColor,
              ),
              value: GroupObjectiveEnum.values.firstWhere(
                  (objective) => objective.name == goal.groupGoalEng),
              groupValue: controller.selectedGroupObjective.value,
              selected: controller.selectedGroupObjective.value.toString() ==
                  goal.groupGoalEng,
              onChanged: (value) {
                if (value != null) {
                  debugPrint("Selected $value");
                  controller.selectedGroupObjective.value = value;
                  controller.selectedGroupObjectiveId.value = controller
                      .groupGoals
                      .firstWhere((goal) => goal.groupGoalEng == value.name)
                      .id!
                      .toString();
                }
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
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
              buttonText: "استمر",
              buttonTextColor: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              onPressed: () async {
                //controller.navigateToCreateMemorizationGroupContentScreen();
                final getGroupByGroupName =
                    await controller.getGroupByGroupName();

                debugPrint("Response: ");
                debugPrint(getGroupByGroupName.toString());
                if (!context.mounted) return;

                debugPrint(
                    "Response ---->: ${getGroupByGroupName['statusCode']}");

                if (getGroupByGroupName['statusCode'] == 404) {
                  controller.navigateToCreateMemorizationGroupContentScreen();
                } else {
                  await CustomAwesomeDialog.showAwesomeDialog(
                    context,
                    DialogType.error,
                    'خطأ',
                    "اسم المجموعة موجود بالفعل، الرجاء اختيار اسم آخر",
                  );
                }
              }),
        ));
  }

  Widget _buildGroupLevel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "اختر مستوى المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.participantLevels.length < 3) {
                  return const Center(
                    child: Text('Not enough data to display slider'),
                  );
                }
                double minLevel =
                    controller.participantLevels.first.id!.toDouble();
                double maxLevel =
                    controller.participantLevels[2].id!.toDouble();

                debugPrint(
                    "Min level: $minLevel , Max level: $maxLevel ,controller.participantLevel.length ${controller.participantLevels.length}");
                return Column(
                  children: [
                    RangeSlider(
                      activeColor: AppColors.primaryColor,
                      inactiveColor: Colors.grey,
                      values: RangeValues(
                        controller.selectedParticipantLevels.value.start
                            .clamp(minLevel, maxLevel),
                        controller.selectedParticipantLevels.value.end
                            .clamp(minLevel, maxLevel),
                      ),
                      min: minLevel,
                      max: maxLevel,
                      divisions: 2,
                      labels: RangeLabels(
                        controller.selectedParticipantLevels.value.start
                            .clamp(minLevel, maxLevel)
                            .toString(),
                        controller.selectedParticipantLevels.value.end
                            .clamp(minLevel, maxLevel)
                            .toString(),
                      ),
                      onChanged: (RangeValues values) {
                        debugPrint("Selected values: $values");
                        controller.selectedParticipantLevels.value = values;
                        controller.setSelectedLevelId();
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          controller.participantLevels.take(3).map((level) {
                        return CustomGoogleTextWidget(
                          text: level.participantLevelAr!,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: AppColors.blackColor,
                        );
                      }).toList(),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "اختر جنس المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Row(
          children: [
            ...controller.genders.map(
              (gender) {
                return Expanded(
                  child: Obx(
                    () => CustomRadioListTile<SupervisorGenderGroupEnum>(
                      title: CustomGoogleTextWidget(
                        text: gender.nameAr!,
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: AppColors.blackColor,
                      ),
                      value: SupervisorGenderGroupEnum.values.firstWhere(
                          (genderSearch) => genderSearch.name == gender.nameEn),
                      groupValue: controller.selectedGender.value,
                      selected: controller.selectedGender.value.toString() ==
                          gender.nameEn,
                      onChanged: (value) {
                        if (value != null) {
                          debugPrint("Selected $value");
                          controller.selectedGender.value = value;
                          controller.selectedGenderId.value = controller.genders
                              .firstWhere((genderSearch) =>
                                  genderSearch.nameEn == gender.nameEn)
                              .id
                              .toString();

                          debugPrint(
                              "Selected gender id: ${controller.selectedGenderId.value}");
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDayPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "اختر ايام المجموعة",
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        const SizedBox(
          height: 16.0,
        ),
        Obx(() => Wrap(
              spacing: 8.0,
              children: controller.days.map((day) {
                return ChoiceChip(
                  backgroundColor: Colors.black12.withOpacity(0.1),
                  selectedColor: AppColors.primaryColor.withOpacity(0.5),
                  label: CustomGoogleTextWidget(
                    text: day.nameAr!,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  selected: controller.selectedDays.contains(day.id.toString()),
                  onSelected: (selected) {
                    if (selected) {
                      debugPrint(day.id.toString());
                      controller.selectedDays.add(day.id.toString());
                    } else {
                      controller.selectedDays.remove(day.id.toString());
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
                      sunrise: const TimeOfDay(hour: 6, minute: 0),
                      sunset: const TimeOfDay(hour: 18, minute: 0),
                      duskSpanInMinutes: 120, // optional
                      onChange: (value) {
                        controller.selectedEndTime.value =
                            TimeOfDay(hour: value.hour, minute: value.minute);
                        debugPrint("Time: $value");
                      },
                      value: Time(
                        hour: (controller.selectedStartTime.value.hour),
                        minute: controller.selectedStartTime.value.minute,
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
