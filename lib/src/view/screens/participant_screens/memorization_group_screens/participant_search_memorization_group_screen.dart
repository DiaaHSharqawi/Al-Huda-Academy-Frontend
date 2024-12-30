import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_search_memorization_group_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_radio_list_tile.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_content_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/supervisor_langugue_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/surahs/surahs.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_screens_widgets/custom_group_card.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ParticipantSearchMemorizationGroupScreen
    extends GetView<ParticipantSearchMemorizationGroupController> {
  const ParticipantSearchMemorizationGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: Lottie.asset(
                        'assets/images/loaderLottie.json',
                        width: 600,
                        height: 600,
                      ),
                    )
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(),
                        const SizedBox(
                          height: 8.0,
                        ),
                        _buildSearchField(context),
                        Expanded(
                          child: _buildMemorizationGroupList(),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(children: [
        Expanded(
          child: CustomTextFormField(
            onChanged: (String value) async {
              if (value.isEmpty) {
                debugPrint("Search query is empty");
                controller.memorizationGroups.clear();
                controller.buildFilterQueryParams();
                await controller.fetchMemorizationGroup();
                controller.isFilterApplied.value = false;
              }
              controller.searchQuery.value = value;
            },
            iconName: Icons.search,
            textFormHintText: "ابحث عن حلقة",
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
        Obx(
          () => IconButton(
            icon: Icon(
              controller.isFilterApplied.value
                  ? Icons.filter_list_outlined
                  : Icons.filter_list_off_outlined,
              color: controller.isFilterApplied.value
                  ? Colors.red
                  : AppColors.blackColor,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _buildFilterDialog(context);
                },
              );
            },
          ),
        )
      ]),
    );
  }

  Widget _buildMemorizationGroupList() {
    return Obx(() {
      if (controller.memorizationGroups.isEmpty) {
        return const Center(
          child: Text(
            'No groups found',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        );
      }
      return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            //  debugPrint("Notification: $notification");
            if (notification is ScrollUpdateNotification) {
              if (notification.scrollDelta != null) {
                // debugPrint("Scrolling");
                return false;
              }
            }
            return true;
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollController,
            itemCount: controller.memorizationGroups.length +
                (controller.isMoreDataLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.memorizationGroups.length) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  width: double.infinity,
                  child: CustomGroupCard(
                    groupTime:
                        "${controller.memorizationGroups[index].startTime!} - ${controller.memorizationGroups[index].endTime!}",
                    days: controller.memorizationGroups[index].days
                        .map((day) => day.nameAr)
                        .join(', '),
                    groupName: controller.memorizationGroups[index].groupName!,
                    groupGoal: controller
                        .memorizationGroups[index].groupGoal!.groupGoalAr!,
                    studentsCount: 0.toString(),
                    groupGender:
                        controller.memorizationGroups[index].gender!.nameAr!,
                    participantsLevel: controller.memorizationGroups[index]
                        .participantLevel!.participantLevelAr!,
                    onDetailsPressed: () {
                      debugPrint("Details pressed");
                      debugPrint(
                          "Group id: ${controller.memorizationGroups[index].id}");
                      debugPrint("index: $index");
                      controller.navigateToGroupDetailsScreen(
                        controller.memorizationGroups[index].id!.toString(),
                      );
                    },
                  ),
                );
              }

              if (index == controller.totalMemorizationGroups) {
                return const SizedBox.shrink();
              }

              return _buildLoadingIndicator();
            },
          ));
    });
  }

  Widget _buildFilterDialog(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      surfaceTintColor: AppColors.white,
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
            controller.queryParams.clear();
            controller.memorizationGroups.clear();
            controller.clearFilterQueryParams();

            controller.fetchMemorizationGroup();
            controller.isFilterApplied.value = false;
          },
          child: const CustomGoogleTextWidget(
            text: "إزالة التصفية",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        TextButton(
          onPressed: () async {
            // Apply filter logic
            debugPrint("Apply filter");
            debugPrint(controller.selectedGender.value.name);
            debugPrint(controller.selectedGroupObjective.value.name);

            Navigator.of(context).pop();
            controller.buildFilterQueryParams();

            await controller.fetchMemorizationGroup();

            debugPrint("Query params: ${controller.queryParams}");
            debugPrint(controller.selectedSurahs.toString());
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
    return ExpansionTile(
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
              Obx(() {
                if (controller.participantLevel.length < 3) {
                  return const Center(
                    child: Text('Not enough data to display slider'),
                  );
                }
                double minLevel =
                    controller.participantLevel.first.id!.toDouble();
                double maxLevel = controller.participantLevel[2].id!.toDouble();

                debugPrint(
                    "Min level: $minLevel , Max level: $maxLevel ,controller.participantLevel.length ${controller.participantLevel.length}");
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
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          controller.participantLevel.take(3).map((level) {
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

  Widget _buildGroupContentFilter(BuildContext context) {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "المحتوى",
        fontSize: 16.0,
      ),
      children: [
        ...controller.teachingMethods.map((method) {
          return Obx(
            () => Column(
              children: [
                CustomRadioListTile<GroupContentFilter>(
                  title: CustomGoogleTextWidget(
                    text: method.methodNameArabic!,
                    fontSize: 16.0,
                    fontWeight: FontWeight.normal,
                    color: AppColors.blackColor,
                  ),
                  value: GroupContentFilter.values.firstWhere(
                      (filter) => filter.name == method.methodNameEnglish),
                  groupValue: controller.selectedGroupContent.value,
                  selected: controller.selectedGroupContent.value.toString() ==
                      method.methodNameEnglish,
                  onChanged: (value) {
                    if (value != null) {
                      debugPrint("Selected content: $value");
                      controller.selectedGroupContent.value = value;
                    }
                  },
                ),
                if (controller.selectedGroupContent.value.name ==
                    method.methodNameEnglish)
                  Obx(() => _buildPartOfQuranChoice()),
              ],
            ),
          );
        }),
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
      padding: const EdgeInsets.all(8.0),
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
        if (controller.selectedGroupContent.value ==
            GroupContentFilter.surahsQuran)
          Obx(
            () => MultiSelectDialogField<Surah>(
              searchable: true,
              searchHint: 'ابحث عن سورة',
              initialValue: controller.selectedSurahs,
              items: controller.surahs
                  .map((surah) => MultiSelectItem<Surah>(surah, surah.name!))
                  .toList(),
              chipDisplay: MultiSelectChipDisplay<Surah>(
                chipColor: AppColors.primaryColor,
                textStyle: const TextStyle(color: Colors.white),
                items: controller.selectedSurahs
                    .map((surah) => MultiSelectItem<Surah>(surah, surah.name!))
                    .toList(),
                onTap: (value) {
                  controller.selectedSurahs.remove(value);
                },
              ),
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
              buttonText: Text(
                "اختر السور",
                style: GoogleFonts.almarai(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
              ),
              onConfirm: (values) {
                debugPrint("Selected surahs: $values");
                debugPrint("Selected surahs: ${values.isEmpty}");

                controller.selectedSurahs.value = values;
                debugPrint(
                    "Selected surahs: ${controller.selectedSurahs.toString()}");
              },
            ),
          )
      ],
    );
  }

  Widget _buildMultiJuzzaSelection() {
    return Column(
      children: [
        if (controller.selectedGroupContent.value ==
            GroupContentFilter.juzasQuran)
          MultiSelectDialogField(
            items: controller.juzas
                .map((juz) => MultiSelectItem(juz, juz.arabicPart!))
                .toList(),
            chipDisplay: MultiSelectChipDisplay<Juza>(
              chipColor: AppColors.primaryColor,
              textStyle: GoogleFonts.getFont(
                'Almarai',
                color: Colors.white,
                fontSize: 16.0,
              ),
              items: controller.selectedJuzzas
                  .map((juz) => MultiSelectItem<Juza>(juz, juz.arabicPart!))
                  .toList(),
              onTap: (value) {
                controller.selectedJuzzas.remove(value);
              },
            ),
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
            buttonText: Text(
              "اختر الأجزاء",
              style: GoogleFonts.almarai(
                fontSize: 16.0,
                color: AppColors.blackColor,
              ),
            ),
            onConfirm: (values) {
              controller.selectedJuzzas.value = values;
              debugPrint(
                  "Selected juzs: ${controller.selectedJuzzas.toString()}");
            },
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
        ...controller.groupLanguages.map((language) {
          return Obx(
            () => CustomRadioListTile<SupervisorLangugueFilter>(
              title: CustomGoogleTextWidget(
                text: language.nameAr!,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: AppColors.blackColor,
              ),
              value: SupervisorLangugueFilter.values
                  .firstWhere((lang) => lang.name == language.nameEn),
              groupValue: controller.selectedSupervisorLanguage.value,
              selected:
                  controller.selectedSupervisorLanguage.value.toString() ==
                      language.nameEn,
              onChanged: (value) {
                if (value != null) {
                  debugPrint("Selected lang: $value");
                  controller.selectedSupervisorLanguage.value = value;
                }
              },
            ),
          );
        }),
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
        ...controller.genders.map((gender) {
          return Obx(
            () => CustomRadioListTile<GenderSearchFiltter>(
              title: CustomGoogleTextWidget(
                text: gender.nameAr!,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: AppColors.blackColor,
              ),
              value: GenderSearchFiltter.values.firstWhere(
                  (genderSearch) => genderSearch.name == gender.nameEn),
              groupValue: controller.selectedGender.value,
              selected:
                  controller.selectedGender.value.toString() == gender.nameEn,
              onChanged: (value) {
                if (value != null) {
                  debugPrint("Selected $value");
                  controller.selectedGender.value = value;
                }
              },
            ),
          );
        }),
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
        ...controller.groupGoals.map((goal) {
          return Obx(
            () => CustomRadioListTile<GroupObjectiveSearchFiltter>(
              title: CustomGoogleTextWidget(
                text: goal.groupGoalAr!,
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: AppColors.blackColor,
              ),
              value: GroupObjectiveSearchFiltter.values.firstWhere(
                  (objective) => objective.name == goal.groupGoalEng),
              groupValue: controller.selectedGroupObjective.value,
              selected: controller.selectedGroupObjective.value.toString() ==
                  goal.groupGoalEng,
              onChanged: (value) {
                if (value != null) {
                  debugPrint("Selected $value");
                  controller.selectedGroupObjective.value = value;
                }
              },
            ),
          );
        }),
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
