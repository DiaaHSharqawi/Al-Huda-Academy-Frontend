import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AdminGroupDashboardScreen extends GetView<AdminGroupDashboardController> {
  const AdminGroupDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGroupDashboardHeaderText(),
                  _buildCurrentMemorizationGroupCard(),
                  // _buildRequestsForcreatingMemorizationGroupCard(),
                  // _buildCreateANewGroupCard(),

                  //  _buildCreateAWeeklyPlan(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  //_buildSupervisorGroups(),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SupervisorCustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildGroupDashboardHeaderText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text: 'لوحة تحكم الحلقات',
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
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

  Widget _buildCurrentMemorizationGroupCard() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/images/meeting-room.png'),
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
            text: 'طلبات انشاء الحلقات',
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
        onTap: () {
          controller.navigateToRequestsForCreatingGroupScreen();
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

  /*Widget _buildOverviewSection() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/images/quran.png'),
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
          text: 'المعلومات الشخصية',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primaryColor,
          size: 40.0,
        ),
        onTap: () {
          // Navigate to the group creation screen
        },
        shadow: const BoxShadow(
            color: AppColors.primaryColor, blurRadius: 10.0, spreadRadius: 3),
      ),
    );
  }*/
/*
  Widget _buildCreateAWeeklyPlan() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/images/weekly_plan.png'),
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
          text: 'انشاء خطة اسبوعية',
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
          // Navigate to the weekly plan creation screen
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
  }*/
/*
  Widget _buildSupervisorGroups() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomGoogleTextWidget(
                      text: "الحلقة الحالية",
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      CustomGoogleTextWidget(
                        text: "عرض الكل",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            GFListTile(
              radius: 8.0,
              color: const Color(0xFFF9FBF7).withOpacity(0.8),
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(32.0),
              selected: false,
              title: const CustomGoogleTextWidget(
                text: 'الحلقة الأولى',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              subTitle: const CustomGoogleTextWidget(
                text: 'عدد طلاب الحلقة ',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
              icon: Row(
                children: [
                  const Icon(
                    Icons.groups,
                    color: AppColors.primaryColor,
                    size: 40.0,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Navigate to the groups screen
              },
              shadow: const BoxShadow(
                color: AppColors.primaryColor,
                blurRadius: 10.0,
                spreadRadius: 3.0,
                offset: Offset(0.0, 0.0),
                blurStyle: BlurStyle.inner,
              ),
            ),
          ],
        ),
      ),
    );
  }
*/
}
