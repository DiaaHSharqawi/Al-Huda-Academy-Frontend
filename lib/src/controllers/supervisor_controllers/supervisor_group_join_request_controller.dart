import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_join_request_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/supervisor/supervisor_group_join_requests_response_model.dart';

class SupervisorGroupJoinRequestController extends GetxController {
  final SupervisorGroupJoinRequestService _supervisorGroupJoinRequestService;
  SupervisorGroupJoinRequestController(this._supervisorGroupJoinRequestService);

  var isLoading = false.obs;

  var groupId = "".obs;

  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController();

  var groupJoinRequestsList = <SupervisorGroupJoinRequest>[].obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  var currentPage = 1.obs;
  var limit = 10.obs;
  var totalPages = 0.obs;
  var totalRecords = 0.obs;

  var queryParams = <String, dynamic>{}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    try {
      isLoading(true);

      debounceSearchController();

      queryParams.addAll({
        "page": currentPage.value,
        "limit": limit.value,
      });
      groupId.value = Get.arguments;
      await fetchGroupJoinRequests();
    } catch (e) {
      debugPrint("Error fetching supervisor group join requests data : $e");
    } finally {
      isLoading(false);
    }
  }

  void debounceSearchController() {
    debounce(
      searchQuery,
      (_) async {
        debugPrint("Debounced query triggered: ${searchQuery.value}");
        clearFilterQueryParams();
        queryParams['fullName'] = searchQuery.value;
        await fetchGroupJoinRequests();
      },
      time: const Duration(milliseconds: 1000),
    );
  }

  void clearFilterQueryParams() {
    debugPrint(
        "------------------------------------- clearFilterQueryParams -------------------------------------");

    queryParams.clear();

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    groupJoinRequestsList.clear();
  }

  Future<void> fetchGroupJoinRequests() async {
    debugPrint("fetchGroupJoinRequests");

    try {
      isLoading(true);
      SupervisorGroupJoinRequestsResponseModel groupJoinRequestsResponseModel =
          await _supervisorGroupJoinRequestService.fetchGroupJoinRequests(
        groupId.value,
        queryParams,
      );

      if (groupJoinRequestsResponseModel.statusCode == 200) {
        groupJoinRequestsList.value =
            groupJoinRequestsResponseModel.groupJoinRequests;

        currentPage.value = groupJoinRequestsResponseModel
            .groupJoinRequestsMetaData!.currentPage;

        totalPages.value = groupJoinRequestsResponseModel
            .groupJoinRequestsMetaData!.totalPages;
      } else {
        // Handle the error
        debugPrint(
            "Error fetching supervisor group join requests data : ${groupJoinRequestsResponseModel.message}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
