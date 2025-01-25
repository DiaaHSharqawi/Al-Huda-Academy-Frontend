import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_plans_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_box.dart';
import 'package:intl/intl.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SupervisorGroupPlansScreen
    extends GetView<SupervisorGroupPlansController> {
  const SupervisorGroupPlansScreen({super.key});

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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildGroupPlanSection(context),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.navigateToCreateGroupPlanScreen();
          },
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            color: AppColors.white,
          ),
        ),
        bottomNavigationBar: SupervisorCustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildFilterDialog(BuildContext context) {
    return AlertDialog(
      title: const CustomGoogleTextWidget(
        text: "اختيار فلتر",
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24.0),
              _buildDateFilter(context),
              const SizedBox(height: 32.0),
              SizedBox(width: double.infinity, child: _buildSortOrderFilter()),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            controller.applyFilters();
            Navigator.of(context).pop();
            await controller.fetchGroupPlans();
          },
          child: const CustomGoogleTextWidget(
            text: "تطبيق",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        TextButton(
          onPressed: () {
            controller.clearFilters();
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: "إزالة الفلتر",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const CustomGoogleTextWidget(
            text: "إلغاء",
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDateFilter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "تاريخ من",
          fontSize: 16.0,
        ),
        Obx(
          () => TextFormField(
            controller: TextEditingController(
              text: controller.fromDateController.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(controller.fromDateController.value!)
                  : '',
            ),
            decoration: InputDecoration(
              hintText: 'اختر تاريخ البدء',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: AppColors.primaryColor,
                          ),
                          focusColor: AppColors.primaryColor,
                          cardColor: AppColors.primaryColor,
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    controller.fromDateController.value = pickedDate;
                  }
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        const CustomGoogleTextWidget(
          text: "تاريخ إلى",
          fontSize: 16.0,
        ),
        Obx(
          () => TextFormField(
            controller: TextEditingController(
              text: controller.toDateController.value != null
                  ? DateFormat('yyyy-MM-dd')
                      .format(controller.toDateController.value!)
                  : '',
            ),
            decoration: InputDecoration(
              hintText: 'اختر تاريخ النهاية',
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    controller.toDateController.value = pickedDate;
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSortOrderFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "ترتيب",
          fontSize: 16.0,
        ),
        Obx(
          () => DropdownButton<SortOrder>(
            value: controller.sortOrder.value,
            items: SortOrder.values.take(2).map((SortOrder sortOrder) {
              return DropdownMenuItem<SortOrder>(
                value: sortOrder,
                child: CustomGoogleTextWidget(
                  text: sortOrder == SortOrder.ascending ? "تصاعدي" : "تنازلي",
                  fontSize: 16.0,
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.sortOrder.value = value!;
              debugPrint("Sort Order: ${controller.sortOrder.value}");
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupPlanSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24.0),
          _buildPlanTitle(context),
          const SizedBox(
            height: 64.0,
          ),
          _buildPlanList(context),
        ],
      ),
    );
  }

  Widget _buildPlanList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            if (controller.groupPlanList.isEmpty) {
              return const Center(
                heightFactor: 4.0,
                child: CustomGoogleTextWidget(
                  text: "لا يوجد أي خطة أسبوعية للمجموعة",
                  fontSize: 18.0,
                  color: AppColors.blackColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.groupPlanList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: CustomBox(
                            height: 150.0,
                            text:
                                'خطة يوم ${DateFormat('EEEE', 'ar').format(controller.groupPlanList[index].dayDate!)} بتاريخ ${DateFormat('yyyy-MM-dd').format(controller.groupPlanList[index].dayDate!)}',
                            textAlign: TextAlign.center,
                            textSize: 18.0,
                            textColor: AppColors.blackColor,
                            boxColor: AppColors.primaryColor.withOpacity(0.2),
                            imageProvider: const AssetImage(
                              "assets/images/quran_image_1.png",
                            ),
                            onTap: () {
                              debugPrint(
                                  "Group Plan Id: ${controller.groupPlanList[index].id}");
                              controller.navigateToGroupPlanDetailsScreen(
                                  controller.groupPlanList[index].id
                                      .toString());
                            },
                            boxChildren: const [
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
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
            () => controller.groupPlanList.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      CustomDropdownWidget(
                        dropDownItems: controller.dropDownItems,
                        limit: controller.limit,
                        queryParams: controller.queryParams,
                        fetcherFunction: controller.fetchGroupPlans,
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
      dataFetchingFunction: controller.fetchGroupPlans,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
    );
  }

  Widget _buildPlanTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomGoogleTextWidget(
          text: "خطط الحلقة",
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        IconButton(
          icon: Obx(
            () => Icon(
              Icons.filter_list,
              color: controller.isFilterApplied.value
                  ? Colors.red
                  : AppColors.primaryColor,
            ),
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
