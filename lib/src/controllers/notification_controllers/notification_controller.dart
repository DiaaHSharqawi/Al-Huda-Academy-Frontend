import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/notification/notification_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/notifications/notifications_response_model.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService;

  NotificationController(this._notificationService);
  var isLoading = false.obs;

  final userNotificationsList = <UserNotification>[].obs;

  var queryParams = <String, dynamic>{}.obs;

  var currentPage = 1.obs;

  var totalPages = 1.obs;
  var limit = 3.obs;

  var totalRecords = 0.obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  @override
  void onInit() async {
    super.onInit();
    try {
      isLoading(true);

      queryParams.value = {
        'page': 1,
        'limit': limit.value,
      };
      await fetchUserNotification();
    } catch (e) {
      debugPrint("Error during onInit: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserNotification() async {
    try {
      isLoading(true);

      userNotificationsList.clear();

      debugPrint("queryParams, $queryParams");

      NotificationsResponseModel notificationsResponseModel =
          await _notificationService.fetchUserNotification(
        queryParams,
      );

      if (notificationsResponseModel.statusCode == 200) {
        debugPrint("notificationsResponseModel");

        debugPrint(notificationsResponseModel.toString());

        userNotificationsList
            .addAll(notificationsResponseModel.userNotifications);

        debugPrint("userNotificationsList*****");
        debugPrint(userNotificationsList.toString());

        debugPrint(userNotificationsList.length.toString());

        totalPages.value = notificationsResponseModel.meta!.totalPages!;

        currentPage.value = notificationsResponseModel.meta!.page!;

        totalRecords.value = notificationsResponseModel.meta!.totalRecords!;
      } else if (notificationsResponseModel.statusCode == 404) {
        userNotificationsList.clear();
      }
    } catch (e) {
      debugPrint("Error fetching supervisor requests registration: $e");
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }
}
