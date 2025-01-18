import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_searched_group_details_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/memorization_group_details_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/participant/send_request_to_join_group_response_model.dart';

class ParticipantSearchedGroupDetailsController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    debugPrint("onInit");

    debugPrint("Get.args: ${Get.arguments}");

    groupId.value = Get.arguments;
    groupId.refresh();

    try {
      isLoading(true);

      await fetchMemorizationGroupDetails();
    } catch (e) {
      debugPrint('Error in onInit: $e');
    } finally {
      isLoading(false);
    }
  }

  String convertTo12HourFormat(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    String minute = parts[1];
    String period = hour >= 12 ? 'مساءاً' : 'صباحاً';

    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    return '$hour:$minute $period';
  }

  var memorizationGroupDetails = Rxn<MemorizationGroupDetails>();

  var groupId = "".obs;

  var isLoading = false.obs;
  var loader = false.obs;

  final ParticipantSearchedGroupDetailsService
      _participantSearchedGroupDetailsService;

  ParticipantSearchedGroupDetailsController(
    this._participantSearchedGroupDetailsService,
  );

  Future<void> fetchMemorizationGroupDetails() async {
    debugPrint("groupId fetch memo group details: ${groupId.toString()}");

    debugPrint("groupId: ${groupId.toString()}");

    try {
      MemorizationGroupDetailsResponseModel
          memorizationGroupDetailsResponseModel =
          await _participantSearchedGroupDetailsService
              .fetchMemorizationGroupDetails(
        groupId.toString(),
      );

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
    }
  }

  Future<SendRequestToJoinGroupResponseModel> sendRequestToJoinGroup() async {
    try {
      loader(true);

      SendRequestToJoinGroupResponseModel sendRequestToJoinGroupResponseModel =
          await _participantSearchedGroupDetailsService.sendRequestToJoinGroup(
        groupId.toString(),
      );

      debugPrint(
          "sendRequestToJoinGroupResponseModel: $sendRequestToJoinGroupResponseModel");

      return sendRequestToJoinGroupResponseModel;
    } catch (e) {
      debugPrint('Error sending request to join group: $e');
      return SendRequestToJoinGroupResponseModel(
        statusCode: 500,
        success: false,
        message: "Failed to send request to join group",
      );
    } finally {
      loader(false);
    }
  }

  void navigateToSearchGroupScreen() {
    Get.back();
  }
}
