import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:lottie/lottie.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/admin_controllers/admin_supervisor_requests_registration_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AdminSupervisorRequestsRegistrationScreen
    extends GetView<AdminSupervisorRequestsRegistrationController> {
  const AdminSupervisorRequestsRegistrationScreen({super.key});

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
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildRequestsForSupervisorRegistration(),
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
                                _buildRequestsForSupervisorRegistrationTable(),
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

  Widget _buildDropSelectItem() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CustomGoogleTextWidget(
            text: "عرض",
            fontSize: 18.0,
          ),
          const SizedBox(width: 16.0),
          Obx(
            () => DropdownButton<int>(
              dropdownColor: AppColors.white,
              focusColor: AppColors.primaryColor,
              value: controller.limit.value,
              items: [1, 3, 5, 7, 10].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: CustomGoogleTextWidget(
                    text: value.toString(),
                    fontSize: 16.0,
                    color: AppColors.blackColor,
                  ),
                );
              }).toList(),
              onChanged: (int? newValue) async {
                if (newValue != null) {
                  controller.limit.value = newValue;
                  controller.queryParams['limit'] = controller.limit.value;

                  await controller.fetchSupervisorRequestsRegistration();
                }
              },
            ),
          ),
          const SizedBox(width: 16.0),
          const CustomGoogleTextWidget(
            text: "خانات",
            fontSize: 18.0,
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsForSupervisorRegistrationTable() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          if (controller.supervisorRequestsRegistrationList.isEmpty) {
            return const Center(
              heightFactor: 10,
              child: CustomGoogleTextWidget(
                text: 'لا توجد طلبات تسجيل للمشرفين حالياً',
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
              child: DataTable(
                horizontalMargin: 1,
                columnSpacing: 20.0,
                dataRowMinHeight: 100.0,
                dataRowMaxHeight: 200.0, // Expanded row height
                columns: const [
                  DataColumn(
                    label: Center(
                      child: CustomGoogleTextWidget(
                        text: 'الاسم',
                        fontSize: 16.0,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Center(
                        child: CustomGoogleTextWidget(
                          text: 'الوصف',
                          fontSize: 16.0,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
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
                rows: controller.supervisorRequestsRegistrationList
                    .map((request) {
                  return DataRow(cells: [
                    DataCell(
                      Center(
                        child: CustomGoogleTextWidget(
                          text: request.fullName!,
                          textAlign: TextAlign.center,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: CustomGoogleTextWidget(
                          text: request.details!,
                          textAlign: TextAlign.center,
                          fontSize: 16.0,
                          color: AppColors.blackColor,
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
                            // Handle accept request logic
                            debugPrint("Accept request");

                            debugPrint(
                                " supevisor id: ${controller.supervisorRequestsRegistrationList[0].id}");

                            await controller
                                .navigateToSupervisorRequestRegistrationDetailsScreen(
                              request.id!.toString(),
                            );
                          },
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          );
        }),
        Obx(
          () => controller.supervisorRequestsRegistrationList.isEmpty
              ? const SizedBox.shrink()
              : Column(
                  children: [
                    _buildDropSelectItem(),
                    const SizedBox(height: 16.0),
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
          dataFetchingFunction: controller.fetchSupervisorRequestsRegistration,
          primaryColor: AppColors.primaryColor,
          textColor: AppColors.white,
        ),
      ],
    );
  }

  Widget _buildRequestsForSupervisorRegistration() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: CustomGoogleTextWidget(
        text: 'طلبات التسجيل للمشرفين',
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
          const CustomGoogleTextWidget(
            text: "فلترة البحث",
            fontSize: 18.0,
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
            controller.supervisorRequestsRegistrationList.clear();
            controller.clearFilterQueryParams();

            controller.buildFilterQueryParams();
            await controller.fetchSupervisorRequestsRegistration();
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

            await controller.fetchSupervisorRequestsRegistration();

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
