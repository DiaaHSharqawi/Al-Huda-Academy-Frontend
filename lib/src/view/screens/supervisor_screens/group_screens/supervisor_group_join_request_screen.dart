import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_join_request_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_box.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorGroupJoinRequestScreen
    extends GetView<SupervisorGroupJoinRequestController> {
  const SupervisorGroupJoinRequestScreen({super.key});

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
                          _buildSearchField(context),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildGroupJoinRequestSection(context),
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

  Widget _buildGroupJoinRequestSection(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 32.0,
        ),
        _buildGroupJoinRequestList(context),
      ],
    );
  }

  Widget _buildGroupJoinRequestList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            if (controller.groupJoinRequestsList.isEmpty) {
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
                  itemCount: controller.groupJoinRequestsList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: CustomGroupJoinRequest(
                            height: 120.0,
                            text: controller.groupJoinRequestsList[index]
                                .participant!.fullName!,
                            textSize: 18.0,
                            textColor: AppColors.blackColor,
                            boxColor: AppColors.primaryColor.withOpacity(0.2),
                            imagePath: controller.groupJoinRequestsList[index]
                                .participant?.profileImage!,
                            onTap: () {
                              _showModalBottomSheet(context, index: index);
                            },
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
            () => controller.groupJoinRequestsList.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      CustomDropdownWidget(
                        dropDownItems: controller.dropDownItems,
                        limit: controller.limit,
                        queryParams: controller.queryParams,
                        fetcherFunction: controller.fetchGroupJoinRequests,
                      ),
                      _buildPagination(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context, {int? index}) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          width: double.infinity,
          height: 600,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomGoogleTextWidget(
                    text: "تفاصيل طلب الانضمام",
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _buildProfileDetailsRow(index!),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: _buildAcceptRequestButton()),
                      const SizedBox(width: 16.0),
                      Expanded(child: _buildRejectRequestButton()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileDetailsRow(int index) {
    return Column(
      children: [
        _buildParticipantProfileImage(index),
        const SizedBox(
          height: 16.0,
        ),
        _buildProfileDetailsRowHeader(),
        const SizedBox(
          height: 16.0,
        ),
        _buildParticipantFullName(index),
        const SizedBox(
          height: 16.0,
        ),
        _buildParticipantAge(index),
        const SizedBox(
          height: 16.0,
        ),
        _buildParticipantMemorizingAmount(index),
        const SizedBox(
          height: 16.0,
        ),
        _buildParticipantProfileMoreDetails(),
      ],
    );
  }

  Widget _buildProfileDetailsRowHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: AppColors.primaryColor.withOpacity(0.2),
            child: const CustomGoogleTextWidget(
              text: "التفاصيل",
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            color: AppColors.primaryColor.withOpacity(0.2),
            child: const CustomGoogleTextWidget(
              text: "المعلومات",
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantMemorizingAmount(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          child: CustomGoogleTextWidget(
            text: "كمية القدرة على الحفظ",
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: CustomGoogleTextWidget(
            text:
                "${controller.groupJoinRequestsList[index].participant!.quranMemorizingAmount!.amountArabic} ",
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantProfileMoreDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: CustomButton(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.blueAccent,
        buttonText: 'عرض المزيد',
        buttonTextColor: AppColors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        onPressed: () {
          // Handle button press
        },
      ),
    );
  }

  Widget _buildParticipantAge(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          child: CustomGoogleTextWidget(
            text: "عمر المشترك",
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: CustomGoogleTextWidget(
            text:
                "${DateTime.now().year - controller.groupJoinRequestsList[index].participant!.dateOfBirth!.year} سنة",
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildParticipantFullName(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          child: CustomGoogleTextWidget(
            text: "اسم المشترك",
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: CustomGoogleTextWidget(
            text:
                controller.groupJoinRequestsList[index].participant!.fullName!,
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: AppColors.blackColor,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptRequestButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: "قبول الطلب",
        buttonTextColor: AppColors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        onPressed: () {
          // Handle accept request
        },
      ),
    );
  }

  Widget _buildRejectRequestButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.red,
        buttonText: 'رفض الطلب',
        buttonTextColor: AppColors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        onPressed: () {
          // Handle accept request
        },
      ),
    );
  }

  Widget _buildParticipantProfileImage(int index) {
    return CircleAvatar(
      foregroundColor: Colors.white,
      radius: 80.0,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          controller.groupJoinRequestsList[index].participant!.profileImage!,
          fit: BoxFit.cover,
          width: 120.0,
          height: 120.0,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPagination() {
    return PaginationWidget(
      queryParams: controller.queryParams,
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      dataFetchingFunction: controller.fetchGroupJoinRequests,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              onChanged: (String value) async {
                if (value.isEmpty) {
                  debugPrint("Search query is empty");
                }
                controller.searchQuery.value = value;
              },
              iconName: Icons.search,
              textFormHintText: 'ابحث عن اسم طالب',
              controller: controller.searchController,
              textFormFieldValidator: (value) {
                if (value == null || value.isEmpty) {
                  return "الرجاء إدخال كلمة البحث";
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGroupHeaderText() {
    return Container(
      margin: const EdgeInsets.only(top: 32.0),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CustomGoogleTextWidget(
          text: 'طلبات الانضمام للحلقة',
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
