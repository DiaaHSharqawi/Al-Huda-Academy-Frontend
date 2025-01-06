import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_supervisor_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_card.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AdminSupervisorDashboardScreen
    extends GetWidget<AdminSupervisorDashboardController> {
  const AdminSupervisorDashboardScreen({super.key});

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
                  _buildSupervisorDashboardHeaderText(),
                  _buildSupervisorRequestCreationCard(),
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

  Widget _buildSupervisorDashboardHeaderText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text: 'لوحة تحكم المشرفين',
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

  Widget _buildSupervisorRequestCreationCard() {
    return CustomCard(
      marginListTile: 16.0,
      paddingListTile: 32.0,
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'طلبات التسجيل كمشرفين',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: const Color(0xFF9536F4),
      cardTextColor: AppColors.blackColor,
      avatarCard: const Icon(
        Icons.supervisor_account_rounded,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      icon: const Icon(
        Icons.arrow_forward_ios,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      onTap: () {
        controller.navigateToAdminSupervisorRequestsRegistrationScreen();
      },
    );
  }
}
