import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_current_groups_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/group_screens_widgets/custom_group_card.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorCurrentGroupsScreen
    extends GetView<SupervisorCurrentGroupsController> {
  const SupervisorCurrentGroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
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
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
          if (controller.supervisorGroupsList.isEmpty) {
            return const Center(
              child: CustomGoogleTextWidget(
                text: 'لا يوجد بيانات لعرضها',
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.supervisorGroupsList.length,
            itemBuilder: (context, index) {
              if (index < controller.supervisorGroupsList.length) {
                return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    width: double.infinity,
                    child: CustomGroupCard(
                      groupName:
                          controller.supervisorGroupsList[index].groupName!,
                      groupDescription: controller
                          .supervisorGroupsList[index].groupDescription!,
                      onDetailsPressed: () {
                        debugPrint("Details pressed");
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
          () => controller.supervisorGroupsList.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    CustomDropdownWidget(
                      dropDownItems: controller.dropDownItems,
                      limit: controller.limit,
                      queryParams: controller.queryParams,
                      fetcherFunction: controller.fetchSupervisorGroups,
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
      dataFetchingFunction: controller.fetchSupervisorGroups,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

  Widget _buildSupervisorCurrentGroupsText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text: 'الحلقات الحالية',
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
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
              textFormHintText: "ابحث عن حلقة",
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
