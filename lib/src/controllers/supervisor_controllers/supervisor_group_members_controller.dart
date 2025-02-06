import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_members_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/memorization_group/group_membership_response_model.dart';

class SupervisorGroupMembershipController extends GetxController {
  final SupervisorGroupMembersService _supervisorGroupMembershipService;
  SupervisorGroupMembershipController(this._supervisorGroupMembershipService);

  var isLoading = false.obs;

  var groupId = "".obs;
  var groupMembersList = <GroupMember>[].obs;

  final List<int> dropDownItems = [1, 3, 5, 7, 10];

  var queryParams = <String, dynamic>{}.obs;

  var currentPage = 1.obs;
  var limit = 3.obs;

  var totalPages = 0.obs;
  var totalRecords = 0.obs;

  var searchQuery = ''.obs;

  var sortOrder = SortOrder.notSelected.obs;

  TextEditingController searchController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    isLoading(true);

    groupId.value = Get.arguments;
    queryParams.value = {
      'page': currentPage.value,
      'limit': limit.value,
    };
    try {
      await fetchGroupMembers();
    } catch (e) {
      debugPrint("Error SupervisorGroupMembershipController onInit : $e");
    } finally {
      isLoading(false);
    }

    debounce(
      searchQuery,
      (_) {
        if (searchQuery.value.isEmpty) {
          groupMembersList.clear();
          queryParams['fullName'] = '';

          queryParams['page'] = currentPage.value;
          queryParams['limit'] = limit.value;

          searchQuery.value = '';
        }

        debugPrint("Debounced query triggered: ${searchQuery.value}");
        buildFilterQueryParams();
        fetchGroupMembers();
      },
      time: const Duration(milliseconds: 1200),
    );
  }

  Future<void> fetchGroupMembers() async {
    groupMembersList.clear();

    try {
      isLoading(true);

      GroupMembersResponseModel groupMembersResponseModel =
          await _supervisorGroupMembershipService.fetchGroupMembers(
        groupId.value,
        queryParams,
      );

      debugPrint("groupMembersResponseModel.statusCode");

      if (groupMembersResponseModel.statusCode == 200) {
        if (groupMembersResponseModel.groupMembers.isNotEmpty) {
          groupMembersList.addAll(groupMembersResponseModel.groupMembers);

          totalPages.value =
              groupMembersResponseModel.groupMembersMetaData!.totalPages!;

          debugPrint("groupMembersList*****");

          debugPrint(groupMembersList.toString());
        }
      }
    } catch (e) {
      debugPrint("Error fetching group members from service model: $e");
    } finally {
      isLoading(false);
    }
  }

  Map<String, dynamic> buildFilterQueryParams() {
    debugPrint("buildFilterQueryParams -------------------------------------");

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    if (searchQuery.value.isNotEmpty) {
      queryParams['fullName'] = searchQuery.value;
    }
    if (sortOrder.value != SortOrder.notSelected) {
      queryParams['sortOrder'] =
          sortOrder.value == SortOrder.ascending ? 'asc' : 'desc';
    }

    debugPrint(queryParams.toString());

    groupMembersList.clear();

    return queryParams;
  }

  void navigateToGroupMemberFollowUpRecords(
      {required String groupMemberId, required String groupId}) {
    Get.toNamed(
      AppRoutes.groupMemberFollowUpRecords,
      arguments: {
        'groupId': groupId,
        'groupMemberId': groupMemberId,
      },
    );
  }
}
