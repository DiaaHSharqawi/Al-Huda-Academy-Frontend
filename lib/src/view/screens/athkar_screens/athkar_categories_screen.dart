import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/athkar_controllers/athkar_categories_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_category.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class AthkarCategoriesScreen extends GetView<AthkarCategoriesController> {
  AthkarCategoriesScreen({super.key}) {
    controller.scrollController.addListener(controller.scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: AppColors.primaryColor,
          preferredSize: const Size.fromHeight(180.0),
          appBarChilds: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildPageTitle(),
              ],
            ),
          ),
          child: const SizedBox.expand(),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 16.0,
            ),
            _buildSearchBar(),
            const SizedBox(
              height: 16.0,
            ),
            _buildAthkarCategoriesList(),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildPageTitle() {
    return const CustomGoogleTextWidget(
      text: 'الأذكار',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller.searchController,
        onChanged: (query) {
          debugPrint("Query: $query");
          controller.query.value = query;
          controller.fetchAthkarCategories();
        },
        decoration: InputDecoration(
          labelText: 'بحث...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildAthkarCategoriesList() {
    return Expanded(
      child: Obx(() {
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              if (notification.scrollDelta != null) {}
            }
            return true;
          },
          child: ListView.builder(
            controller: controller.scrollController,
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.athkarsCategories.length +
                (controller.isMoreDataLoading.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < controller.athkarsCategories.length) {
                var element = controller.athkarsCategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomCategory(
                    categoryFontSize: 20.0,
                    height: 120.0,
                    categoryName: element.category!,
                    categoryColor: AppColors.primaryColor.withOpacity(0.1),
                    textColor: Colors.black,
                    imagePath: 'assets/images/quran-rehal.png',
                    onTap: () async {
                      debugPrint(
                          "Category ID: ${element.athkarCategotyId}, Category Name: ${element.category}");
                      controller.update();
                      Get.toNamed(AppRoutes.athkar,
                          arguments: {'categoryId': element.athkarCategotyId});
                    },
                  ),
                );
              } else if (index == controller.athkarsCategories.length &&
                  controller.athkarsCategories.length <
                      controller.totalAthkarsCategories) {
                return _buildLoadingIndicator();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      }),
    );
  }
}
