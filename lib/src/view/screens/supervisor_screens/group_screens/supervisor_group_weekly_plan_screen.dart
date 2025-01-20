import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_weekly_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_box.dart';
import 'package:intl/intl.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/group_plan/create_group_weekly_plan_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorGroupWeeklyPlanScreen
    extends GetView<SupervisorGroupWeeklyPlanController> {
  const SupervisorGroupWeeklyPlanScreen({super.key});

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
                        _buildGroupWeeklyPlanSection(context),
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
            _buildCreateGroupPlanConfirmationDialog(context);
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

  Future<void> _buildCreateGroupPlanConfirmationDialog(BuildContext context) {
    const dialogType = DialogType.info;
    const title = 'تاكيد انشاء خطة اسبوعية جديدة';
    const description = "هل تريد بالتأكيد إنشاء خطة جديدة؟";

    return CustomAwesomeDialog.showAwesomeDialog(
      context: context,
      dialogType: dialogType,
      title: title,
      description: description,
      btnOkOnPress: () {
        debugPrint("Create Group Plan btnOkOnPress");

        _handelCreateGroupPlan(context);
      },
      btnCancelOnPress: () {},
    );
  }

  Future<void> _handelCreateGroupPlan(BuildContext context) async {
    try {
      CreateGroupWeeklyPlanResponseModel createGroupWeeklyPlanResponseModel =
          await controller.createGroupWeeklyPlan();
      debugPrint(
          "Create Group Plan Response : $createGroupWeeklyPlanResponseModel");

      if (createGroupWeeklyPlanResponseModel.statusCode == 200) {
        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          title: "تم اضافة الخطة الأسبوعية بنجاح",
          description:
              "تم اضافة الخطة الأسبوعية بنجاح بامكانك الان الانتقال اليها واضافة باقي التفاصيل",
          btnOkOnPress: () {},
        );

        await controller.fetchGroupPlans();
      } else {
        debugPrint(
            "Error Create Group Plan: ${createGroupWeeklyPlanResponseModel.message}");

        if (!context.mounted) return;

        await CustomAwesomeDialog.showAwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          title: "خطأ",
          description: createGroupWeeklyPlanResponseModel.message!,
          btnOkOnPress: () {},
        );
      }
    } catch (e) {
      debugPrint("Error _handelCreateGroupPlan : $e");
    }
  }

  Widget _buildGroupWeeklyPlanSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24.0),
          _buildWeeklyPlanTitle(),
          const SizedBox(
            height: 64.0,
          ),
          _buildWeeklyPlanList(context),
        ],
      ),
    );
  }

  Widget _buildWeeklyPlanList(BuildContext context) {
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
                                "الخطة للأسبوع\n رقم   ${controller.groupPlanList[index].weekNumber! + 1}",
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
                            },
                            boxChildren: [
                              const SizedBox(
                                height: 16.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomGoogleTextWidget(
                                    text: "التاريخ : ",
                                    fontSize: 16.0,
                                    color: AppColors.blackColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  CustomGoogleTextWidget(
                                    text: DateFormat('yyyy-MM-dd').format(
                                        controller.groupPlanList[index]
                                            .startWeekDayDate!
                                            .toLocal()
                                            .add(
                                              Duration(
                                                  days: controller
                                                          .supervisorGroupDaysList
                                                          .first
                                                          .dayId! -
                                                      1),
                                            )),
                                    fontSize: 16.0,
                                    color: AppColors.blackColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                ],
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

  Widget _buildWeeklyPlanTitle() {
    return const CustomGoogleTextWidget(
      text: "الخطة الأسبوعية للمجموعة",
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
