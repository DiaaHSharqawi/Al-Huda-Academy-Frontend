import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_create_group_weekly_plan_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorCreateGroupWeeklyPlanScreen
    extends GetView<SupervisorCreateGroupWeeklyPlanController> {
  const SupervisorCreateGroupWeeklyPlanScreen({super.key});

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
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildCreateGroupWeeklyPlanSection(),
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

  Widget _buildCreateGroupWeeklyPlanSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCreateGroupWeeklyPlanHeader(),
      ],
    );
  }

  Widget _buildCreateGroupWeeklyPlanHeader() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24.0),
        const CustomGoogleTextWidget(
          text: "انشاء خطة أسبوعية للحلقة",
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        const SizedBox(height: 24.0),
        const CustomGoogleTextWidget(
          text: "من فضلك قم بإدخال البيانات التالية لإنشاء خطة أسبوعية للحلقة",
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: AppColors.blackColor,
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            const CustomGoogleTextWidget(
              text: "خطة للاسبوع رقم",
              fontSize: 18.0,
              color: AppColors.blackColor,
            ),
            const SizedBox(width: 8.0),
            CustomGoogleTextWidget(
              text: Get.arguments["nextWeekNumber"].toString(),
              fontSize: 18.0,
              color: AppColors.blackColor,
            ),
          ],
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
