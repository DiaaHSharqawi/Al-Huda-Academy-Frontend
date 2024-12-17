import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_search_memorization_group_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_radio_list_tile.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/selected_part_of_quran_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_langugue_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ParticipantSearchMemorizationGroupScreen
    extends GetView<ParticipantSearchMemorizationGroupController> {
  const ParticipantSearchMemorizationGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderSection(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _buildSearchField(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              iconName: Icons.search,
              textFormHintText: "ابحث عن أستاذ أو حلقة",
              controller: controller.searchController,
              textFormFieldValidator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرجاء إدخال كلمة البحث";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _buildFilterDialog(context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDialog(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const CustomGoogleTextWidget(
        text: "فلترة البحث",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildGenderFilter(),
            const SizedBox(
              height: 16.0,
            ),
            _buildGroupObjectiveFilter(),
            const SizedBox(
              height: 16.0,
            ),
            _buildSupervisorLangugeFilter(),
            const SizedBox(
              height: 16.0,
            ),
            _buildGroupContentFilter(context),
            const SizedBox(
              height: 16.0,
            ),
            _buildStudentsLevel(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: "إلغاء",
            color: Colors.red,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {
            // Clear filter logic
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: "إزالة التصفية",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        TextButton(
          onPressed: () {
            // Apply filter logic
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: "تطبيق",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      elevation: 24.0,
    );
  }

  Widget _buildStudentsLevel() {
    return Obx(
      () => ExpansionTile(
        title: const CustomGoogleTextWidget(
          text: "مستوى الطلاب",
          fontSize: 16.0,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RangeSlider(
                  activeColor: AppColors.primaryColor,
                  values: RangeValues(
                    controller.selectedStudentLevelRange.value.start
                        .toDouble()
                        .clamp(0, 2),
                    controller.selectedStudentLevelRange.value.end
                        .toDouble()
                        .clamp(0, 2),
                  ),
                  min: 0,
                  max: 2,
                  divisions: 2,
                  labels: RangeLabels(
                    controller.selectedStudentLevelRange.value.start == 0
                        ? 'مبتدى'
                        : controller.selectedStudentLevelRange.value.start == 1
                            ? 'متوسط'
                            : 'متقدم',
                    controller.selectedStudentLevelRange.value.end == 0
                        ? 'مبتدى'
                        : controller.selectedStudentLevelRange.value.end == 1
                            ? 'متوسط'
                            : 'متقدم',
                  ),
                  onChanged: (RangeValues values) {
                    controller.selectedStudentLevelRange.value = RangeValues(
                      values.start.clamp(0, 2),
                      values.end.clamp(0, 2),
                    );
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomGoogleTextWidget(
                      text: 'مبتدى',
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackColor,
                    ),
                    CustomGoogleTextWidget(
                      text: 'متوسط',
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackColor,
                    ),
                    CustomGoogleTextWidget(
                      text: 'متقدم',
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupContentFilter(BuildContext context) {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "المحتوى",
        fontSize: 16.0,
      ),
      children: [
        Obx(
          () => CustomRadioListTile<GroupContentFilter>(
            title: const CustomGoogleTextWidget(
              text: 'كامل القران',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupContentFilter.allOfQuran,
            groupValue: controller.selectedGroupContent.value,
            selected: controller.selectedGroupContent.value ==
                GroupContentFilter.allOfQuran,
            onChanged: (value) {
              if (value != null) {
                controller.selectedGroupContent.value = value;
              }
            },
          ),
        ),

        Obx(
          () => CustomRadioListTile<GroupContentFilter>(
            title: const CustomGoogleTextWidget(
              text: 'جزء من القران',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupContentFilter.partOfQuran,
            groupValue: controller.selectedGroupContent.value,
            selected: controller.selectedGroupContent.value ==
                GroupContentFilter.partOfQuran,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected role: $value");
                controller.selectedGroupContent.value = value;
              }
            },
          ),
        ),

        Obx(
          () => controller.selectedGroupContent.value ==
                  GroupContentFilter.partOfQuran
              ? _buildPartOfQuranChoice()
              : const SizedBox(),
        ),
        Obx(
          () => CustomRadioListTile<GroupContentFilter>(
            title: const CustomGoogleTextWidget(
              text: 'الكل',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupContentFilter.all,
            groupValue: controller.selectedGroupContent.value,
            selected:
                controller.selectedGroupContent.value == GroupContentFilter.all,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected role: $value");
                controller.selectedGroupContent.value = value;
              }
            },
          ),
        ),
        const SizedBox(height: 16.0),

        const SizedBox(height: 16.0),
        // _buildMultiJuzzaSelection(),
      ],
    );
  }

  Widget _buildPartOfQuranChoice() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildMultiSurahSelection(),
          const SizedBox(height: 16.0),
          _buildMultiJuzzaSelection(),
        ],
      ),
    );
  }

  Widget _buildMultiSurahSelection() {
    return Column(
      children: [
        Obx(
          () => CustomRadioListTile<SelectedPartOfQuranFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'سورة',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: SelectedPartOfQuranFiltter.surahs,
            groupValue: controller.selectedPartOfQuranType.value,
            selected: controller.selectedPartOfQuranType.value ==
                SelectedPartOfQuranFiltter.surahs,
            onChanged: (value) {
              if (value != null) {
                debugPrint(" $value");
                controller.selectedPartOfQuranType.value = value;
              }
            },
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        MultiSelectDialogField(
          items: [
            MultiSelectItem<String>(
              '1',
              'الفاتحة',
            ),
            MultiSelectItem<String>(
              '2',
              'البقرة',
            ),
          ],
          title: const CustomGoogleTextWidget(
            text: "اختر السور",
            fontSize: 16.0,
          ),
          selectedColor: AppColors.primaryColor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          buttonIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
          ),
          buttonText: const Text(
            "اختر السور",
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
            ),
          ),
          onConfirm: (values) {
            controller.selectedSurahs.value = values;
          },
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.primaryColor,
            textStyle: const TextStyle(color: Colors.white),
            onTap: (value) {
              controller.selectedSurahs.remove(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMultiJuzzaSelection() {
    return Column(
      children: [
        Obx(
          () => CustomRadioListTile<SelectedPartOfQuranFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'جزء',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: SelectedPartOfQuranFiltter.juzs,
            groupValue: controller.selectedPartOfQuranType.value,
            selected: controller.selectedPartOfQuranType.value ==
                SelectedPartOfQuranFiltter.juzs,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected $value");
                controller.selectedPartOfQuranType.value = value;
              }
            },
            fillColor: AppColors.primaryColor,
          ),
        ),
        MultiSelectDialogField(
          items: const [],
          title: const CustomGoogleTextWidget(
            text: "اختر الأجزاء",
            fontSize: 16.0,
          ),
          selectedColor: AppColors.primaryColor,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppColors.primaryColor,
              width: 2,
            ),
          ),
          buttonIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
          ),
          buttonText: const Text(
            "اختر الأجزاء",
            style: TextStyle(
              fontSize: 16.0,
              color: AppColors.blackColor,
            ),
          ),
          onConfirm: (values) {
            controller.selectedJuzzas.value = values;
          },
          chipDisplay: MultiSelectChipDisplay(
            chipColor: AppColors.primaryColor,
            textStyle: const TextStyle(color: Colors.white),
            onTap: (value) {
              controller.selectedJuzzas.remove(value);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSupervisorLangugeFilter() {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "المدرس يتحدث اللغة",
        fontSize: 16.0,
      ),
      children: [
        Obx(
          () => CustomRadioListTile<SupervisorLangugueFilter>(
            title: const CustomGoogleTextWidget(
              text: 'العربية',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: SupervisorLangugueFilter.arabic,
            groupValue: controller.selectedSupervisorLanguage.value,
            selected: controller.selectedSupervisorLanguage.value ==
                SupervisorLangugueFilter.arabic,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected $value");
                controller.selectedSupervisorLanguage.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<SupervisorLangugueFilter>(
            title: const CustomGoogleTextWidget(
              text: 'الانجليزية',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: SupervisorLangugueFilter.english,
            groupValue: controller.selectedSupervisorLanguage.value,
            selected: controller.selectedSupervisorLanguage.value ==
                SupervisorLangugueFilter.english,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected lang: $value");
                controller.selectedSupervisorLanguage.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<SupervisorLangugueFilter>(
            title: const CustomGoogleTextWidget(
              text: 'الكل',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: SupervisorLangugueFilter.all,
            groupValue: controller.selectedSupervisorLanguage.value,
            selected: controller.selectedSupervisorLanguage.value ==
                SupervisorLangugueFilter.all,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected role: $value");
                controller.selectedSupervisorLanguage.value = value;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderFilter() {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "الجنس",
        fontSize: 16.0,
      ),
      children: [
        Obx(
          () => CustomRadioListTile<GenderSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'ذكر',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GenderSearchFiltter.male,
            groupValue: controller.selectedGender.value,
            selected:
                controller.selectedGender.value == GenderSearchFiltter.male,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected $value");
                controller.selectedGender.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<GenderSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'انثى',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GenderSearchFiltter.female,
            groupValue: controller.selectedGender.value,
            selected:
                controller.selectedGender.value == GenderSearchFiltter.female,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected role: $value");
                controller.selectedGender.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<GenderSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'الكل',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GenderSearchFiltter.both,
            groupValue: controller.selectedGender.value,
            selected:
                controller.selectedGender.value == GenderSearchFiltter.both,
            onChanged: (value) {
              if (value != null) {
                debugPrint("Selected role: $value");
                controller.selectedGender.value = value;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupObjectiveFilter() {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "الهدف من المجموعة",
        fontSize: 16.0,
      ),
      children: [
        Obx(
          () => CustomRadioListTile<GroupObjectiveSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'تحفيظ',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupObjectiveSearchFiltter.memorization,
            groupValue: controller.selectedGroupObjective.value,
            selected: controller.selectedGroupObjective.value ==
                GroupObjectiveSearchFiltter.memorization,
            onChanged: (value) {
              if (value != null) {
                controller.selectedGroupObjective.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<GroupObjectiveSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'تلاوة',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupObjectiveSearchFiltter.recitation,
            groupValue: controller.selectedGroupObjective.value,
            selected: controller.selectedGroupObjective.value ==
                GroupObjectiveSearchFiltter.recitation,
            onChanged: (value) {
              if (value != null) {
                controller.selectedGroupObjective.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<GroupObjectiveSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'مراجعة',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupObjectiveSearchFiltter.review,
            groupValue: controller.selectedGroupObjective.value,
            selected: controller.selectedGroupObjective.value ==
                GroupObjectiveSearchFiltter.review,
            onChanged: (value) {
              if (value != null) {
                controller.selectedGroupObjective.value = value;
              }
            },
          ),
        ),
        Obx(
          () => CustomRadioListTile<GroupObjectiveSearchFiltter>(
            title: const CustomGoogleTextWidget(
              text: 'الكل',
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: AppColors.blackColor,
            ),
            value: GroupObjectiveSearchFiltter.all,
            groupValue: controller.selectedGroupObjective.value,
            selected: controller.selectedGroupObjective.value ==
                GroupObjectiveSearchFiltter.all,
            onChanged: (value) {
              if (value != null) {
                controller.selectedGroupObjective.value = value;
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      children: [
        CustomGoogleTextWidget(
          text: "البحث عن أستاذ وحلقة مناسبة",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        SizedBox(
          height: 16.0,
        ),
        CustomGoogleTextWidget(
          text:
              "قم باستخدام معايير البحث واضغط على زر البحث وسيقوم نظام المطابقة بعرض قائمة الأساتذة والحلقات حسب مناسبتها لمتطلباتك ورغباتك",
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColors.blackColor,
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
