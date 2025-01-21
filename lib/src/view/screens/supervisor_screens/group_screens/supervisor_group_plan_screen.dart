import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_box.dart';
import 'package:intl/intl.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorGroupPlanScreen extends GetView<SupervisorGroupPlanController> {
  const SupervisorGroupPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildGroupPlanSection(context),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDatePickerDialog(context);
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
        bottomNavigationBar: SupervisorCustomBottomNavigationBar(),
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
                  focusedDay: controller.selectedDate.value,
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
//    if (!context.mounted) return;

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
            controller.navigateToGroupPlanDetailsScreen();
          },
        );

        await controller.fetchGroupPlans();
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

  Widget _buildGroupPlanSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24.0),
          _buildPlanTitle(),
          const SizedBox(
            height: 64.0,
          ),
          _buildPlanList(context),
        ],
      ),
    );
  }

  Widget _buildPlanList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            if (controller.groupPlanList.isEmpty) {
              return const Center(
                heightFactor: 4.0,
                child: CustomGoogleTextWidget(
                  text: "لا يوجد أي خطة أسبوعية للمجموعة",
                  fontSize: 18.0,
                  color: AppColors.blackColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.groupPlanList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: CustomBox(
                            height: 150.0,
                            text:
                                'خطة يوم ${DateFormat('EEEE', 'ar').format(controller.groupPlanList[index].dayDate!)} بتاريخ ${DateFormat('yyyy-MM-dd').format(controller.groupPlanList[index].dayDate!)}',
                            textAlign: TextAlign.center,
                            textSize: 18.0,
                            textColor: AppColors.blackColor,
                            boxColor: AppColors.primaryColor.withOpacity(0.2),
                            imageProvider: const AssetImage(
                              "assets/images/quran_image_1.png",
                            ),
                            onTap: () {
                              debugPrint(
                                  "Group Plan Id: ${controller.groupPlanList[index].id}");
                              controller.navigateToGroupPlanDetailsScreen();
                            },
                            boxChildren: const [
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    );
                  });
            }
          }),
          Obx(
            () => controller.groupPlanList.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      CustomDropdownWidget(
                        dropDownItems: controller.dropDownItems,
                        limit: controller.limit,
                        queryParams: controller.queryParams,
                        fetcherFunction: controller.fetchGroupPlans,
                      ),
                      _buildPagination(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return PaginationWidget(
      queryParams: controller.queryParams,
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      dataFetchingFunction: controller.fetchGroupPlans,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

  Widget _buildPlanTitle() {
    return const CustomGoogleTextWidget(
      text: "خطط الحلقة",
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
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
