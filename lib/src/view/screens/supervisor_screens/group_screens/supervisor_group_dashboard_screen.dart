import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_card.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SupervisorGroupDashboardScreen
    extends GetView<SupervisorGroupDashboardController> {
  const SupervisorGroupDashboardScreen({super.key});

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
                          _buildGroupHeaderText(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildGroupMembersCard(),
                          const SizedBox(
                            height: 64.0,
                          ),
                          _buildGroupJoinRequestSection(),
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

  Widget _buildGroupJoinRequestSection() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildGroupJoinRequestHeader(),
          const SizedBox(
            height: 32.0,
          ),
          _buildGroupJoinRequestList(),
        ]);
  }

  Widget _buildGroupJoinRequestList() {
    return SizedBox(
      height: 240.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(
              () {
                if (controller
                    .groupDashboard.value!.groupJoinRequestsDashboard.isEmpty) {
                  return const Center(
                    heightFactor: 4.0,
                    child: CustomGoogleTextWidget(
                      text: 'لا يوجد اي طلبات انضمام حالياً',
                      fontSize: 18.0,
                      color: AppColors.blackColor,
                    ),
                  );
                } else {
                  return CustomCard(
                    paddingListTile: 24.0,
                    marginListTile: 32.0,
                    gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
                    cardText:
                        'عدد طلبات الانضمام: ${controller.groupDashboard.value!.groupJoinRequestsDashboard.length}',
                    cardTextSize: 18.0,
                    cardInnerBoxShadowColor:
                        Colors.deepOrangeAccent.withOpacity(0.8),
                    cardTextColor: AppColors.blackColor,
                    avatarCard: const FaIcon(
                      FontAwesomeIcons.userPlus,
                      color: Colors.black87,
                      size: 30.0,
                    ),
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.blackColor,
                      size: 30.0,
                    ),
                    onTap: () {
                      controller.navigateToGroupJoinRequestScreen(
                        controller.groupId.value,
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

/*
  Widget _buildGroupJoinRequestList() {
    return SizedBox(
      height: 240.0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller
                  .groupDashboard.value!.groupJoinRequestsDashboard.isEmpty) {
                return const Center(
                  heightFactor: 4.0,
                  child: CustomGoogleTextWidget(
                    text: 'لا يوجد اي طلبات انضمام حالياً',
                    fontSize: 18.0,
                    color: AppColors.blackColor,
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller
                      .groupDashboard.value!.groupJoinRequestsDashboard.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: CustomGroupJoinRequest(
                        height: 120.0,
                        text: controller
                            .groupDashboard
                            .value!
                            .groupJoinRequestsDashboard[index]
                            .participant!
                            .fullName!,
                        textSize: 18.0,
                        textColor: AppColors.blackColor,
                        boxColor: AppColors.primaryColor.withOpacity(0.2),
                        imagePath: controller
                            .groupDashboard
                            .value!
                            .groupJoinRequestsDashboard[index]
                            .participant!
                            .profileImage!,
                        onTap: () {},
                      ),
                    );
                  },
                );
              }
            }),
          ],
        ),
      ),
    );
  }
*/

  Widget _buildGroupJoinRequestHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomGoogleTextWidget(
          text: "طلبات الانضمام",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        const SizedBox(
          width: 8.0,
        ),
        GestureDetector(
          onTap: () {
            controller
                .navigateToGroupJoinRequestScreen(controller.groupId.value);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomGoogleTextWidget(
                text: "عرض الكل",
                fontSize: 16.0,
                color: AppColors.primaryColor,
              ),
              SizedBox(
                width: 16.0,
              ),
              FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: AppColors.primaryColor,
                size: 25.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildGroupMembersCard() {
    return CustomCard(
      paddingListTile: 24.0,
      marginListTile: 32.0,
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: "اسماء الطلاب",
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: Colors.teal.withOpacity(0.8),
      cardTextColor: AppColors.blackColor,
      avatarCard: const FaIcon(
        FontAwesomeIcons.peopleGroup,
        color: Colors.black87,
        size: 30.0,
      ),
      icon: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.blackColor,
        size: 30.0,
      ),
    );
  }

  Widget _buildGroupHeaderText() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomGoogleTextWidget(
          text:
              '${controller.groupDashboard.value!.groupDetailsDashboard?.groupName!}',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
      ),
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
