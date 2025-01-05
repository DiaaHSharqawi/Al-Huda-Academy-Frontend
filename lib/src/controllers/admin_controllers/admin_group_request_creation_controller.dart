import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_group_request_creation_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/memorization_group_details_response_model.dart';

class AdminGroupRequestCreationController extends GetxController {
  final AdminGroupRequestCreationService _adminGroupDetailsService;
  AdminGroupRequestCreationController(this._adminGroupDetailsService);

  @override
  void onInit() async {
    super.onInit();
    debugPrint("onInit");
    await fetchMemorizationGroupDetails();
  }

  var isLoading = false.obs;
  var groupId = "".obs;

  var memorizationGroupDetails = Rxn<MemorizationGroupDetails>();

  String convertTo12HourFormat(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    String minute = parts[1];
    String period = hour >= 12 ? 'مساءاً' : 'صباحاً';

    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    return '$hour:$minute $period';
  }

  Future<void> fetchMemorizationGroupDetails() async {
    isLoading.value = true;

    groupId.value = Get.arguments;
    groupId.refresh();

    debugPrint("groupId fetch memo group details: ${groupId.toString()}");

    debugPrint("groupId: ${groupId.toString()}");

    try {
      MemorizationGroupDetailsResponseModel
          memorizationGroupDetailsResponseModel =
          await _adminGroupDetailsService
              .fetchMemorizationGroupDetails(groupId.toString());

      debugPrint(
          "memorizationGroupDetailsResponseModel fetched : ${memorizationGroupDetailsResponseModel.memorizationGroup?.juzas.toString()}");

      if (memorizationGroupDetailsResponseModel.statusCode == 200) {
        memorizationGroupDetails.value =
            memorizationGroupDetailsResponseModel.memorizationGroup;

        debugPrint(
            "memorizationGroupDetails: ${memorizationGroupDetails.value?.teachingMethod.toString()}");
      }
    } catch (e) {
      debugPrint('Error fetching memorization group details, controller: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
