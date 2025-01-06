import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_card.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AdminHomeScreen extends GetView<AdminController> {
  const AdminHomeScreen({super.key});

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGroupSection(),
                const SizedBox(
                  height: 32.0,
                ),
                const Divider(
                  color: AppColors.blackColor,
                  thickness: 2.0,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                _buildSupervisorSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSupervisorSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSupervisorHeaderText(),
        const SizedBox(
          height: 16.0,
        ),
        _buildSupervisorCard(),
      ],
    );
  }

  Widget _buildSupervisorHeaderText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: const CustomGoogleTextWidget(
        text: 'المشرفين',
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildSupervisorCard() {
    return CustomCard(
      marginListTile: 16.0,
      paddingListTile: 32.0,
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'المشرفين',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: const Color(0xFF365FF4),
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
        controller.navigateToAdminSupervisorDashboardScreen();
      },
    );
  }

  Widget _buildGroupSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroupHeaderText(),
        const SizedBox(
          height: 16.0,
        ),
        _buildGroupCard(),
      ],
    );
  }

  PreferredSize _buildAppBar() {
    return CustomAppBar(
      showBackArrow: true,
      arrowMargin: 16.0,
      preferredSize: const Size.fromHeight(150.0),
      appBarBackgroundImage: "assets/images/ornament1.png",
      appBarChilds: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeText(),
            const SizedBox(
              height: 16.0,
            ),
            _buildAdminext(),
          ],
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      child: const SizedBox.expand(),
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

  Widget _buildAdminext() {
    return const CustomGoogleTextWidget(
      text: 'المشرف العام',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
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
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: GFListTile(
        avatar: const GFAvatar(
          backgroundImage: AssetImage('assets/images/admin_meeting.png'),
          backgroundColor: Colors.transparent,
          shape: GFAvatarShape.standard,
          size: 40.0,
        ),
        radius: 8.0,
        color: const Color(0xFFF9FBF7).withOpacity(0.8),
        margin: const EdgeInsets.all(16.0),
        padding: const EdgeInsets.all(32.0),
        selected: true,
        subTitle: const Center(
          child: CustomGoogleTextWidget(
            text: 'ادارة الحلقات',
            fontSize: 18.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        icon: const Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primaryColor,
          size: 40.0,
        ),
        onTap: () {
          controller.navigateToAdminGroupDashboardScreen();
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
