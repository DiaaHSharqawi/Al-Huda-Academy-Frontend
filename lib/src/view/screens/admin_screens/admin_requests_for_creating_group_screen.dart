import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_requests_for_creating_group_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_radio_list_tile.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender_search_filtter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/group_objective_search_filter.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_screens_widgets/custom_group_card.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AdminRequestsForCreatingGroupScreen
    extends GetView<AdminRequestsForCreatingGroupController> {
  const AdminRequestsForCreatingGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRequestsForCreatingGroups(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildSearchField(context),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildRequestsForCreatingGroupsList(),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SupervisorCustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildRequestsForCreatingGroupsList() {
    return Column(
      children: [
        Obx(() {
          if (controller.requestsForCreatingGroupsModelsList.isEmpty) {
            return const Center(
              child: CustomGoogleTextWidget(
                text: 'لا يوجد بيانات لعرضها',
              ),
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollUpdateNotification) {
                if (notification.scrollDelta != null) {
                  return false;
                }
              }
              return true;
            },
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.requestsForCreatingGroupsModelsList.length,
              itemBuilder: (context, index) {
                if (index <
                    controller.requestsForCreatingGroupsModelsList.length) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
                    child: CustomGroupCard(
                      groupTime:
                          "${controller.requestsForCreatingGroupsModelsList[index].startTime!} - ${controller.requestsForCreatingGroupsModelsList[index].endTime!}",
                      groupName: controller
                          .requestsForCreatingGroupsModelsList[index]
                          .groupName!,
                      groupSupervisorName: controller
                          .requestsForCreatingGroupsModelsList[index]
                          .supervisor
                          ?.fullName!,
                      studentsCount: controller
                          .requestsForCreatingGroupsModelsList[index].capacity!
                          .toString(),
                      onDetailsPressed: () {
                        debugPrint(
                            "Group id: ${controller.requestsForCreatingGroupsModelsList[index].id}");

                        controller.navigateToRequestsForCreatingGroupDetails(
                            controller
                                .requestsForCreatingGroupsModelsList[index].id!
                                .toString());
                      },
                    ),
                  );
                }

                if (index == controller.totalRequestsForCreatingGroups) {
                  return const SizedBox.shrink();
                }
                return null;
              },
            ),
          );
        }),
        Obx(
          () => controller.requestsForCreatingGroupsModelsList.isEmpty
              ? const SizedBox.shrink()
              : _buildPagination(),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return PaginationWidget(
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      fetchRequestsForCreatingGroup: controller.fetchRequestsForCreatingGroup,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

/*
  Widget _buildPagination() {
    return Obx(() {
      if (controller.totalPages <= 1) {
        return const SizedBox.shrink();
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: controller.currentPage.value > 1
                    ? () async {
                        //  controller.currentPage.value--;
                        controller.currentPage.update(
                          (val) => controller.currentPage.value--,
                        );
                        await controller.fetchRequestsForCreatingGroup();
                      }
                    : null,
              ),
              ...List.generate(controller.totalPages, (index) {
                if (index == 0 ||
                    index == controller.totalPages - 1 ||
                    (index >= controller.currentPage.value - 2 &&
                        index <= controller.currentPage.value)) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomButton(
                      backgroundColor: controller.currentPage.value == index + 1
                          ? AppColors.primaryColor.withOpacity(0.8)
                          : AppColors.primaryColor,
                      foregroundColor: AppColors.white,
                      buttonText: '${index + 1}',
                      buttonTextColor: AppColors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      onPressed: () async {
                        //controller.currentPage.value = index + 1;
                        //
                        controller.currentPage.update(
                          (val) => controller.currentPage.value = index + 1,
                        );
                        await controller.fetchRequestsForCreatingGroup();
                      },
                    ),
                  );
                } else if (index == controller.currentPage.value - 3 ||
                    index == controller.currentPage.value + 1) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: CustomGoogleTextWidget(
                      text: '...',
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: controller.currentPage.value < controller.totalPages
                    ? () async {
                        //  controller.currentPage.value++;
                        controller.currentPage.update(
                          (val) => controller.currentPage.value++,
                        );
                        await controller.fetchRequestsForCreatingGroup();
                      }
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }
*/
  Widget _buildRequestsForCreatingGroups() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text: 'طلبات إنشاء الحلقات',
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
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
              onChanged: (String value) async {
                if (value.isEmpty) {
                  debugPrint("Search query is empty");
                  //   controller.memorizationGroups.clear();
                  //  controller.buildFilterQueryParams();
                  //  await controller.fetchMemorizationGroup();
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
        ],
      ),
    );
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
            _buildGroupGoalilter(),
            const SizedBox(
              height: 16.0,
            ),
            _buildStudentsLevelFiltter(),
            const SizedBox(
              height: 16.0,
            ),
            _buildSearchOrderFiltter(context),
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
          onPressed: () async {
            // Clear filter logic
            Navigator.of(context).pop();
            controller.queryParams.clear();
            controller.requestsForCreatingGroupsModelsList.clear();
            controller.clearFilterQueryParams();

            controller.buildFilterQueryParams();
            await controller.fetchRequestsForCreatingGroup();
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

            Navigator.of(context).pop();

            controller.buildFilterQueryParams();

            await controller.fetchRequestsForCreatingGroup();

            debugPrint("Query params: ${controller.queryParams}");
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

  Widget _buildSearchOrderFiltter(BuildContext context) {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "عرض حسب",
        fontSize: 16.0,
      ),
      children: [
        ListTile(
          title: const CustomGoogleTextWidget(
            text: "من الأحدث إلى الأقدم",
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: AppColors.blackColor,
          ),
          leading: Obx(() => Radio<SortOrder>(
                value: SortOrder.descending,
                groupValue: controller.sortOrder.value,
                onChanged: (SortOrder? value) {
                  if (value != null) {
                    controller.sortOrder.value = value;
                    debugPrint("Sort order: ${controller.sortOrder.value}");
                  }
                },
              )),
        ),
        ListTile(
          title: const CustomGoogleTextWidget(
            text: "من الأقدم إلى الأحدث",
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: AppColors.blackColor,
          ),
          leading: Obx(() => Radio<SortOrder>(
                value: SortOrder.ascending,
                groupValue: controller.sortOrder.value,
                onChanged: (SortOrder? value) {
                  if (value != null) {
                    controller.sortOrder.value = value;
                    debugPrint("Sort order: ${controller.sortOrder.value}");
                  }
                },
              )),
        ),
      ],
    );
  }

  Widget _buildGroupGoalilter() {
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

  Widget _buildStudentsLevelFiltter() {
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
                  debugPrint(
                      "controller.selectedGender.value ${controller.selectedGender.value}");
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

/*
  Widget _buildCurrentMemorizationGroupCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/images/meeting.png'),
          backgroundColor: Colors.transparent,
          shape: GFAvatarShape.standard,
          size: 40.0,
        ),
        radius: 8.0,
        color: AppColors.secondaryColor,
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(32.0),
        selected: true,
        subTitle: const Center(
          child: CustomGoogleTextWidget(
            text: 'الحلقات الحالية',
            fontSize: 18.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
        ),
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.blackColor,
          size: 40.0,
        ),
        onTap: () {},
        shadow: const BoxShadow(
          color: AppColors.primaryColor,
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: Offset(0.0, 0.0),
          blurStyle: BlurStyle.inner,
        ),
      ),
    );
  }
*/
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
