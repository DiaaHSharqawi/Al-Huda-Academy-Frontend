import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_group_request_creation_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AdminRequestedGroupDetailsScreen
    extends GetView<AdminGroupRequestCreationController> {
  const AdminRequestedGroupDetailsScreen({super.key});

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
            child: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: Lottie.asset(
                        'assets/images/loaderLottie.json',
                        width: 600,
                        height: 600,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderSection(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildGroupDetails(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildAcceptRejectGroupButton(),
                        ],
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAcceptRejectGroupButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.primaryColor,
            buttonText: 'قبول الطلب',
            buttonTextColor: AppColors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            onPressed: () {
              debugPrint("Join Group Button Pressed");
            },
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            foregroundColor: AppColors.white,
            backgroundColor: const Color(0xFFCC4055),
            buttonText: 'رفض الطلب',
            buttonTextColor: AppColors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            onPressed: () {
              debugPrint("Join Group Button Pressed");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupDetails() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTableHeader(),
        _buildGroupName(),
        _buildGroupGoal(),
        _buildGroupLevel(),
        _buildGroupDescription(),
        _buildGroupTime(),
        _buildGroupCapacity(),
        _buildGroupDays(),
        _buildGroupGender(),
        _buildSuperVisorGroupDetails(),
        _buildGroupContent(),
        const SizedBox(
          height: 12.0,
        ),
        if ((controller.memorizationGroupDetails.value!.teachingMethod!.id ==
                    1 ||
                controller.memorizationGroupDetails.value!.teachingMethod!.id ==
                    4) &&
            controller.memorizationGroupDetails.value!.surahs.isNotEmpty)
          _buildGroupSurahs()
        else if ((controller
                        .memorizationGroupDetails.value!.teachingMethod!.id ==
                    2 ||
                controller.memorizationGroupDetails.value!.teachingMethod!.id ==
                    3) &&
            controller.memorizationGroupDetails.value!.juzas.isNotEmpty)
          _buildGroupJuza(),
        if (controller.memorizationGroupDetails.value!.teachingMethod!.id ==
                5 &&
            controller.memorizationGroupDetails.value!.extracts.isNotEmpty)
          _buildGroupExtracts(),
      ],
    );
  }

  Widget _buildSuperVisorGroupDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.manage_accounts,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "مشرف/مشرفة \n الحلقة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .memorizationGroupDetails.value!.supervisor!.fullName!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

// start juza
  Widget _buildGroupJuza() {
    return Column(
      children: [
        _buildGroupContentJuzaDetailsHeader(),
        _buildGroupContentJuzaRows(),
      ],
    );
  }

  Widget _buildGroupContentJuzaRows() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            controller.memorizationGroupDetails.value!.juzas.map((content) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: content.juzaId.toString(),
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: content.juza!.arabicPart!,
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildGroupContentJuzaDetailsHeader() {
    return Center(
      child: Container(
        color: const Color(0xffd1c7af),
        padding: const EdgeInsets.all(12.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomGoogleTextWidget(
                text: "رقم الجزء",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            Expanded(
              child: CustomGoogleTextWidget(
                text: "اسم الجزء",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
// end juza

// start surahs
  Widget _buildGroupSurahs() {
    return Column(
      children: [
        _buildGroupContentSurahsDetailsHeader(),
        Container(
          child: _buildGroupContentSurhasRows(),
        ),
      ],
    );
  }

  Widget _buildGroupContentSurhasRows() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: 350,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: controller.memorizationGroupDetails.value!.surahs
                .map((content) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomGoogleTextWidget(
                        text: content.surahId.toString(),
                        textAlign: TextAlign.center,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                    Expanded(
                      child: CustomGoogleTextWidget(
                        text: content.surah!.name!,
                        textAlign: TextAlign.center,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupContentSurahsDetailsHeader() {
    return Center(
      child: Container(
        color: const Color(0xffd1c7af),
        padding: const EdgeInsets.all(12.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomGoogleTextWidget(
                text: "رقم السورة",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            Expanded(
              child: CustomGoogleTextWidget(
                text: "اسم السورة",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
// end surahs

// extracts
  Widget _buildGroupExtracts() {
    return Column(
      children: [
        _buildGroupContentExtractsDetailsHeader(),
        _buildGroupContentExtractsRows(),
      ],
    );
  }

  Widget _buildGroupContentExtractsDetailsHeader() {
    return Center(
      child: Container(
        color: const Color(0xffd1c7af),
        padding: const EdgeInsets.all(12.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: CustomGoogleTextWidget(
                text: "رقم السورة",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            Expanded(
              child: CustomGoogleTextWidget(
                text: "اسم السورة",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
            Expanded(
              child: CustomGoogleTextWidget(
                text: "رقم الايات",
                fontSize: 14.0,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupContentExtractsRows() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
            controller.memorizationGroupDetails.value!.extracts.map((content) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: content.surah!.id.toString(),
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Expanded(
                  child: CustomGoogleTextWidget(
                    text: content.surah!.name!,
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
                Expanded(
                  child: CustomGoogleTextWidget(
                    textDirection: TextDirection.rtl,
                    text: content.ayat
                        .toString()
                        .split(',')
                        .map((range) => range.contains('-')
                            ? range.split('-').reversed.join('-')
                            : range)
                        .toList()
                        .join(', '),
                    textAlign: TextAlign.center,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

// extracts end

  Widget _buildGroupContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.book,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "محتوى الحلقة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.memorizationGroupDetails.value!.teachingMethod!
                  .methodNameArabic!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupGender() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.person,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "جنس المشاركين",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.memorizationGroupDetails.value!.gender!.nameAr!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupDays() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.calendar,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "أيام الحلقة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.memorizationGroupDetails.value!.days
                  .map((day) => day.nameAr)
                  .join(", "),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupCapacity() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            CupertinoIcons.person_3_fill,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "سعة المجموعة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.memorizationGroupDetails.value!.capacity
                  .toString(),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupTime() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.lock_clock,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "وقت الحلقة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text:
                  "${controller.convertTo12HourFormat(controller.memorizationGroupDetails.value!.startTime!)} - ${controller.convertTo12HourFormat(controller.memorizationGroupDetails.value!.endTime!)}",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupName() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.group,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "اسم المجموعة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.memorizationGroupDetails.value!.groupName!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupDescription() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.description,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "وصف المجموعة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text:
                  controller.memorizationGroupDetails.value!.groupDescription!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupLevel() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.star,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "المستوى",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller.memorizationGroupDetails.value!.participantLevel!
                  .participantLevelAr!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupGoal() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 16.0),
          const Expanded(
            child: CustomGoogleTextWidget(
              text: "هدف المجموعة",
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: controller
                  .memorizationGroupDetails.value!.groupGoal!.groupGoalAr!,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: AppColors.primaryColor.withOpacity(0.4),
      padding: const EdgeInsets.all(16.0),
      child: const Row(
        children: [
          Expanded(
            child: CustomGoogleTextWidget(
              text: "معيار التدريس",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: CustomGoogleTextWidget(
              text: "معايير هذه الحلقة",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return const Column(
      children: [
        CustomGoogleTextWidget(
          text: "تفاصيل المجموعة",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
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
