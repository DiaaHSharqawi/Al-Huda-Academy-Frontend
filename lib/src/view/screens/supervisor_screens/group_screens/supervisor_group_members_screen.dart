import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_members_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_box.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorGroupMembersScreen
    extends GetView<SupervisorGroupMembershipController> {
  const SupervisorGroupMembersScreen({super.key});

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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24.0),
                          _buildHeaderText(),
                          const SizedBox(height: 16.0),
                          _buildSearchField(context),
                          Container(
                            margin: const EdgeInsets.only(top: 64.0),
                            child: _buildGroupMembersList(context),
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
                  controller.groupMembersList.clear();
                  controller.buildFilterQueryParams();
                  await controller.fetchGroupMembers();
                }
                controller.searchQuery.value = value;
              },
              iconName: Icons.search,
              textFormHintText: "... ابحث عن طالب",
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
          const SizedBox(width: 16.0),
          Obx(
            () => controller.searchQuery.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      controller.searchController.clear();
                      controller.searchQuery.value = "";

                      controller.groupMembersList.clear();
                      controller.queryParams['fullName'] = '';

                      controller.queryParams['page'] =
                          controller.currentPage.value;
                      controller.queryParams['limit'] = controller.limit.value;

                      controller.searchQuery.value = '';

                      controller.buildFilterQueryParams();
                      controller.fetchGroupMembers();
                    },
                  ),
          ),
          IconButton(
            icon: controller.sortOrder.value == SortOrder.ascending
                ? const Icon(Icons.arrow_upward)
                : const Icon(Icons.arrow_downward),
            onPressed: () {
              controller.sortOrder.value =
                  controller.sortOrder.value == SortOrder.notSelected
                      ? SortOrder.ascending
                      : controller.sortOrder.value == SortOrder.ascending
                          ? SortOrder.descending
                          : SortOrder.ascending;
              controller.buildFilterQueryParams();
              controller.fetchGroupMembers();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGroupMembersList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            if (controller.groupMembersList.isEmpty) {
              return const Center(
                heightFactor: 4.0,
                child: CustomGoogleTextWidget(
                  text: "لا طلاب المسجلين بالحلقة",
                  fontSize: 18.0,
                  color: AppColors.blackColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.groupMembersList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: CustomBox(
                            height: 120.0,
                            text: controller
                                .groupMembersList[index].participant!.fullName!,
                            textSize: 18.0,
                            textColor: AppColors.blackColor,
                            boxColor: AppColors.primaryColor.withOpacity(0.2),
                            imagePath: controller.groupMembersList[index]
                                .participant?.profileImage!,
                            onTap: () {},
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
            () => controller.groupMembersList.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      CustomDropdownWidget(
                        dropDownItems: controller.dropDownItems,
                        limit: controller.limit,
                        queryParams: controller.queryParams,
                        fetcherFunction: controller.fetchGroupMembers,
                      ),
                      _buildPagination(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPagination() {
    return PaginationWidget(
      queryParams: controller.queryParams,
      currentPage: controller.currentPage,
      totalPages: controller.totalPages,
      dataFetchingFunction: controller.fetchGroupMembers,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

  Widget _buildHeaderText() {
    return const SizedBox(
      width: double.infinity,
      child: CustomGoogleTextWidget(
        text: "اسماء الطلاب المسجلين بالحلقة",
        fontSize: 18.0,
        color: AppColors.blackColor,
        fontWeight: FontWeight.bold,
        textAlign: TextAlign.center,
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
