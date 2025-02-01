import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/shape/gf_avatar_shape.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_card.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class ParticipantHomeScreen extends GetView<ParticipantController> {
  ParticipantHomeScreen({super.key});
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
          backgroundColor: AppColors.primaryColor,
          child: const SizedBox.expand(),
        ),
        body: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32.0,
                  ),
                  _buildMyGroupsRecordsSection(),
                  const SizedBox(
                    height: 32.0,
                  ),
                  _buildTasksRecordsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTasksRecordsSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomGoogleTextWidget(
            text: 'سجلات المهام',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
          const SizedBox(
            height: 16.0,
          ),
          _buildCurrentTasks(),
          const SizedBox(
            height: 16.0,
          ),
          _buildLateTasks(),
          const SizedBox(
            height: 16.0,
          ),
          _buildSubmittedTasks(),
        ],
      ),
    );
  }

  Widget _buildSubmittedTasks() {
    return CustomCard(
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'المهام المقدمة',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: Colors.amber,
      cardTextColor: AppColors.blackColor,
      avatarCard: const Icon(
        Icons.done_all_rounded,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      icon: const CustomGoogleTextWidget(
        text: '3',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildCurrentTasks() {
    return CustomCard(
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'المهام الحالية',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: AppColors.primaryColor,
      cardTextColor: AppColors.blackColor,
      avatarCard: const Icon(
        Icons.home_work_rounded,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      icon: const CustomGoogleTextWidget(
        text: '3',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.green,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildLateTasks() {
    return CustomCard(
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'المهام المتأخرة',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: Colors.red,
      cardTextColor: AppColors.blackColor,
      avatarCard: const Icon(
        Icons.warning_rounded,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      icon: const CustomGoogleTextWidget(
        text: '3',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.red,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildSearchForSupervisorAndJoinMemorizationGroup() {
    return CustomCard(
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'البحث عن مشرف والانضمام لحلقة تحفيظ',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: AppColors.primaryColor,
      cardTextColor: AppColors.blackColor,
      avatarCard: const GFAvatar(
        backgroundImage: AssetImage('assets/images/quran_groups.png'),
        backgroundColor: Colors.transparent,
        shape: GFAvatarShape.standard,
        size: 30.0,
      ),
      icon: const Icon(
        Icons.search_rounded,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      onTap: () {
        Get.toNamed(AppRoutes.participantSearchMemorizationGroup);
      },
    );
  }

  Widget _buildMyGroupsRecordsSection() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomGoogleTextWidget(
            text: 'سجلات مجموعاتي',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: AppColors.blackColor,
          ),
          const SizedBox(
            height: 16.0,
          ),
          _buildSearchForSupervisorAndJoinMemorizationGroup(),
          const SizedBox(
            height: 16.0,
          ),
          _buildCurrentGroups(),
        ],
      ),
    );
  }

  Widget _buildCurrentGroups() {
    return CustomCard(
      gFListTileColor: const Color(0xFFF9FBF7).withOpacity(0.8),
      cardText: 'مجموعاتي الحالية',
      cardTextSize: 18.0,
      cardInnerBoxShadowColor: Colors.amber,
      cardTextColor: AppColors.blackColor,
      avatarCard: const GFAvatar(
        backgroundImage: AssetImage('assets/images/current_groups.png'),
        backgroundColor: Colors.transparent,
        shape: GFAvatarShape.standard,
        size: 30.0,
      ),
      icon: const Icon(
        Icons.group_rounded,
        color: AppColors.blackColor,
        size: 40.0,
      ),
      onTap: () {
        controller.navigateToCurrentGroupsScreen();
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
        const SizedBox(
          width: 8.0,
        ),
        CustomGoogleTextWidget(
          text: appService.user.value!.getFullName ?? 'Unknown User',
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ],
    );
  }
}
