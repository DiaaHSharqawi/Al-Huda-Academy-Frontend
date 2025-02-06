import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_card.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_under_review_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorHomeScreen extends GetView<SupervisorController> {
  SupervisorHomeScreen({super.key});
  final appService = Get.find<AppService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppBar(
          preferredSize: const Size.fromHeight(150.0),
          appBarChilds: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcomeText(),
                    const SizedBox(
                      height: 16.0,
                    ),
                    _buildUserFullName(),
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          child: const SizedBox.expand(),
        ),
        body: appService.user.value?.getAccountStatus.englishName ==
                "under review"
            ? CustomSupervisorAccountUnderReviewDialog(controller: controller)
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildGroupSection(),
                        const SizedBox(
                          height: 16.0,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1.0,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        bottomNavigationBar: SupervisorCustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildGroupSection() {
    return Column(
      children: [
        _buildGroupHeaderText(),
        const SizedBox(
          height: 16.0,
        ),
        _buildGroupCard(),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }

  Widget _buildGroupHeaderText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: const CustomGoogleTextWidget(
        text: 'الحلقات',
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildGroupCard() {
    return CustomCard(
      paddingListTile: 18.0,
      marginListTile: 28.0,
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: "ادارة الحلقات",
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: AppColors.primaryColor,
      cardTextColor: AppColors.primaryColor,
      avatarCard: const GFAvatar(
        backgroundImage: AssetImage('assets/images/current_groups.png'),
        backgroundColor: Colors.transparent,
        shape: GFAvatarShape.standard,
        size: 50.0,
      ),
      icon: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.primaryColor,
        size: 40.0,
      ),
      onTap: () {
        controller.navigateToSupervisorGroupDashboard();
      },
    );
  }

  Widget _buildWelcomeText() {
    return const CustomGoogleTextWidget(
      text: 'السلام عليكم 👋',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  Widget _buildUserFullName() {
    return Row(
      children: [
        const CustomGoogleTextWidget(
          text: "المشرف",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(
          width: 8.0,
        ),
        CustomGoogleTextWidget(
          text: appService.user.value?.getFullName ?? 'Unknown User',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ],
    );
  }

  Widget createANewGroup() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/images/group.png'),
          backgroundColor: Colors.transparent,
          shape: GFAvatarShape.standard,
          size: 40.0,
        ),
        radius: 8.0,
        color: const Color(0xFFF9FBF7).withOpacity(0.8),
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(32.0),
        selected: true,
        subTitle: const CustomGoogleTextWidget(
          text: 'انشاء مجموعة جديدة',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        icon: const Icon(
          Icons.add,
          color: AppColors.primaryColor,
          size: 40.0,
        ),
        onTap: () {
          // Navigate to the group creation screen
          controller.navigateToCreateGroupScreen();
        },
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
}
