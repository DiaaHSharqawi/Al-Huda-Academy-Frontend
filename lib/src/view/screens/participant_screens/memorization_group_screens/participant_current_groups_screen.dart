import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_current_groups_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_image_with_text.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_search_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_screens_widgets/custom_group_card.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class ParticipantCurrentGroupsScreen
    extends GetView<ParticipantCurrentGroupsController> {
  const ParticipantCurrentGroupsScreen({super.key});

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
                          _buildSupervisorCurrentGroupsText(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildSearchField(context),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: _buildSupervisorCurrentGroupsList(),
                          ),
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

  Widget _buildSupervisorCurrentGroupsList() {
    return Column(
      children: [
        Obx(() {
          if (controller.participantGroupsList.isEmpty) {
            return const Center(
              child: CustomImageWithText(
                imageProvider: AssetImage(AppImages.quranImage3),
                text: 'لم تقم بالانضمام إلى أي حلقة بعد',
                width: 300.0,
                height: 300.0,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.participantGroupsList.length,
            itemBuilder: (context, index) {
              if (index < controller.participantGroupsList.length) {
                return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
                    child: CustomGroupCard(
                      groupName: controller.participantGroupsList[index]
                          .memorizationGroup!.groupName!,
                      groupDescription: controller.participantGroupsList[index]
                          .memorizationGroup?.groupDescription!,
                      onDetailsPressed: () {
                        debugPrint("Details pressed");
                        controller.navigateToGroupDetailsScreen(
                          controller.participantGroupsList[index].id!
                              .toString(),
                        );
                      },
                    ));
              }

              if (index == controller.totalRecords.value) {
                return const SizedBox.shrink();
              }
              return const SizedBox.shrink();
            },
          );
        }),
        Obx(
          () => controller.participantGroupsList.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    CustomDropdownWidget(
                      currentPage: controller.currentPage,
                      dropDownItems: controller.dropDownItems,
                      limit: controller.limit,
                      queryParams: controller.queryParams,
                      fetcherFunction: controller.fetchparticipantGroups,
                    ),
                    _buildPagination(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return PaginationWidget(
      queryParams: controller.queryParams,
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      dataFetchingFunction: controller.fetchparticipantGroups,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

  Widget _buildSupervisorCurrentGroupsText() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: const CustomGoogleTextWidget(
        text: 'حلقاتي الحالية',
        textAlign: TextAlign.center,
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return CustomSearchField(
      queryParams: controller.queryParams,
      searchController: controller.searchController,
      searchQuery: controller.searchQuery,
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
