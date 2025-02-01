import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/meeting_controllers/supervisor_meeting_dashboard_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_search_field.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorMeetingDashboardScreen
    extends GetView<SupervisorMeetingDashboardController> {
  const SupervisorMeetingDashboardScreen({super.key});

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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 32.0,
                          ),
                          _buildSupervisorGroupsMeetingsHeaderText(),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildSearchField(context),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSupervisorMeetingTable(),
                              ],
                            ),
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

  Widget _buildSupervisorMeetingTable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.supervisorGroupsList.isEmpty) {
            return const Center(
              heightFactor: 10,
              child: CustomGoogleTextWidget(
                text: 'ليس لديك اي مجموعات،',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),
            );
          }
          return SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  horizontalMargin: 16.0,
                  columnSpacing: 18.0,
                  dataRowMinHeight: 100.0,
                  dataRowMaxHeight: 200.0,
                  columns: const [
                    DataColumn(
                      label: Flexible(
                        child: Center(
                          child: CustomGoogleTextWidget(
                            text: 'اسم الحلقة',
                            fontSize: 16.0,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Flexible(
                        child: Center(
                          child: CustomGoogleTextWidget(
                            text: 'ايام الحلقة',
                            fontSize: 16.0,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Flexible(
                        child: Center(
                          child: CustomGoogleTextWidget(
                            text: "وقت الحلقة",
                            fontSize: 16.0,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Flexible(
                        child: Center(
                          child: CustomGoogleTextWidget(
                            text: "تاريخ اللقاء القادم",
                            fontSize: 16.0,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Flexible(
                        child: Center(
                          child: CustomGoogleTextWidget(
                            text: 'التفاصيل',
                            fontSize: 16.0,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: controller.supervisorGroupsList.map((group) {
                    return DataRow(cells: [
                      DataCell(
                        Center(
                          child: CustomGoogleTextWidget(
                            text: group.groupName!,
                            textAlign: TextAlign.center,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: CustomGoogleTextWidget(
                            text:
                                group.days.map((day) => day.nameAr).join("- "),
                            textAlign: TextAlign.center,
                            fontSize: 16.0,
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: CustomGoogleTextWidget(
                            text:
                                '${controller.formatTime(group.startTime.toString())} - ${controller.formatTime(group.endTime.toString())}',
                            textAlign: TextAlign.center,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: CustomGoogleTextWidget(
                            text: group.groupPlans.isNotEmpty
                                ? group.groupPlans.first.dayDate as String
                                : "لم يتم اضافة خطة للقاء القادم",
                            textAlign: TextAlign.center,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(
                        Center(
                          child: CustomButton(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.white,
                            buttonText: 'التفاصيل',
                            buttonTextColor: AppColors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            onPressed: () async {
                              debugPrint("Button pressed");
                            },
                          ),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          );
        }),
        Obx(
          () => controller.supervisorGroupsList.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    CustomDropdownWidget(
                      currentPage: controller.currentPage,
                      dropDownItems: controller.dropDownItems,
                      limit: controller.limit,
                      queryParams: controller.queryParams,
                      fetcherFunction: controller.fetchSupervisorGroupsMeeting,
                    ),
                    _buildPagination(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildPagination() {
    return Column(
      children: [
        PaginationWidget(
          queryParams: controller.queryParams,
          currentPage: controller.currentPage,
          totalPages: controller.totalPages,
          dataFetchingFunction: controller.fetchSupervisorGroupsMeeting,
          primaryColor: AppColors.primaryColor,
          textColor: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildSupervisorGroupsMeetingsHeaderText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text: 'اللقاءات',
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: CustomSearchField(
              queryParams: controller.queryParams,
              searchController: controller.searchController,
              searchQuery: controller.searchQuery,
            ),
          ),
          Obx(
            () => IconButton(
              icon: Icon(
                size: 20.0,
                controller.isFilterApplied.value
                    ? Icons.filter_list_outlined
                    : Icons.filter_list_off_outlined,
                color: controller.isFilterApplied.value
                    ? Colors.red
                    : AppColors.blackColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildFilterDialog(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDialog(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      surfaceTintColor: AppColors.white,
      title: const CustomGoogleTextWidget(
        text: "فلترة البحث",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: AppColors.blackColor,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildSearchOrderFiltter(context),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: "إلغاء",
            color: Colors.red,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () async {
            // Clear filter logic
            Navigator.of(context).pop();
            controller.queryParams.clear();
            controller.supervisorGroupsList.clear();
            controller.clearFilterQueryParams();

            controller.buildFilterQueryParams();
            await controller.fetchSupervisorGroupsMeeting();
            controller.isFilterApplied.value = false;
          },
          child: const CustomGoogleTextWidget(
            text: "إزالة التصفية",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        TextButton(
          onPressed: () async {
            // Apply filter logic
            debugPrint("Apply filter");

            Navigator.of(context).pop();

            controller.buildFilterQueryParams();

            controller.isFilterApplied.value = true;

            await controller.fetchSupervisorGroupsMeeting();

            debugPrint("Query params: ${controller.queryParams}");
          },
          child: const CustomGoogleTextWidget(
            text: "تطبيق",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      elevation: 24.0,
    );
  }

  Widget _buildSearchOrderFiltter(BuildContext context) {
    return ExpansionTile(
      title: const CustomGoogleTextWidget(
        text: "عرض حسب",
        fontSize: 16.0,
      ),
      children: [
        ListTile(
          title: const CustomGoogleTextWidget(
            text: "من الأحدث إلى الأقدم",
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: AppColors.blackColor,
          ),
          leading: Obx(() => Radio<SortOrder>(
                value: SortOrder.descending,
                groupValue: controller.sortOrder.value,
                onChanged: (SortOrder? value) {
                  if (value != null) {
                    controller.sortOrder.value = value;
                    debugPrint("Sort order: ${controller.sortOrder.value}");
                  }
                },
              )),
        ),
        ListTile(
          title: const CustomGoogleTextWidget(
            text: "من الأقدم إلى الأحدث",
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: AppColors.blackColor,
          ),
          leading: Obx(() => Radio<SortOrder>(
                value: SortOrder.ascending,
                groupValue: controller.sortOrder.value,
                onChanged: (SortOrder? value) {
                  if (value != null) {
                    controller.sortOrder.value = value;
                    debugPrint("Sort order: ${controller.sortOrder.value}");
                  }
                },
              )),
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
