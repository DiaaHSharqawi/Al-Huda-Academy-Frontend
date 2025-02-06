import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/notification_controllers/notification_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_box.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_pagination_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_show_boxes_drop_down_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_custom_bottom_navigation_bar.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class NotificationsScreen extends GetView<NotificationController> {
  const NotificationsScreen({super.key});

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
                          const CustomGoogleTextWidget(
                            text: "الإشعارات",
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          _buildNotificationsList(context),
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

  Widget _buildNotificationsList(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            if (controller.userNotificationsList.isEmpty) {
              return const Center(
                heightFactor: 4.0,
                child: CustomGoogleTextWidget(
                  text: "لا يوجد إشعارات",
                  fontSize: 18.0,
                  color: AppColors.blackColor,
                ),
              );
            } else {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.userNotificationsList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: CustomBox(
                            height: 120.0,
                            text:
                                controller.userNotificationsList[index].title!,
                            textSize: 18.0,
                            textColor: AppColors.blackColor,
                            boxColor: AppColors.primaryColor.withOpacity(0.2),
                            fontWeight:
                                controller.userNotificationsList[index].isRead!
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                            imageProvider:
                                const AssetImage(AppImages.notificationImage),
                            onTap: () {
                              debugPrint("Notification tapped");

                              showNotificationDetailsDialog(
                                  controller.userNotificationsList[index].id!,
                                  context);
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
            () => controller.userNotificationsList.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      CustomDropdownWidget(
                        currentPage: controller.currentPage,
                        dropDownItems: controller.dropDownItems,
                        limit: controller.limit,
                        queryParams: controller.queryParams,
                        fetcherFunction: controller.fetchUserNotification,
                      ),
                      _buildPagination(),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  void showNotificationDetailsDialog(
      int notificationId, BuildContext context) async {
    controller.queryParams['notificationId'] = notificationId;

    await controller.fetchUserNotification();
    Get.dialog(
      AlertDialog(
        title: const CustomGoogleTextWidget(
          text: "تفاصيل الإشعار",
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Row(
                children: [
                  const CustomGoogleTextWidget(
                    text: "العنوان: ",
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: CustomGoogleTextWidget(
                      text: controller.userNotificationsList[0].title ??
                          "No title",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: CustomGoogleTextWidget(
                      text: "الرسالة: ",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    flex: 4,
                    child: CustomGoogleTextWidget(
                      text: controller.userNotificationsList[0].message ??
                          "No body",
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const CustomGoogleTextWidget(
              text: "إغلاق",
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
            onPressed: () async {
              Get.back();
              controller.queryParams.remove('notificationId');
              await controller.fetchUserNotification();
            },
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
      dataFetchingFunction: controller.fetchUserNotification,
      primaryColor: AppColors.primaryColor,
      textColor: AppColors.white,
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
