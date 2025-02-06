import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_group_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_card.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class ParticipantGroupDashboardScreen
    extends GetView<ParticipantGroupDashboardController> {
  const ParticipantGroupDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
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
                          _buildGradesHeaderText(),
                          _buildGradesSection(),
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

  Widget _buildGradesSection() {
    return Column(
      children: [
        const SizedBox(
          height: 32.0,
        ),
        const SizedBox(
          height: 32.0,
        ),
        _buildGroupGradeCard(),
      ],
    );
  }

  Widget _buildGroupGradeCard() {
    return CustomCard(
      paddingListTile: 24.0,
      marginListTile: 32.0,
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'سجل العلامات',
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
      onTap: () {},
    );
  }

  Widget _buildGradesHeaderText() {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CustomGoogleTextWidget(
          text: 'مجموعة عمر بن الخطاب',
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
