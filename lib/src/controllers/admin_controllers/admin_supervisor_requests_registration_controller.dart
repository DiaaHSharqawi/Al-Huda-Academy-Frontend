import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_supervisor_requests_registration_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/supervisor_requests_registration_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/sort_order_enum.dart';

class AdminSupervisorRequestsRegistrationController extends GetxController {
  final AdminSupervisorRequestsRegistrationService
      _adminSupervisorRequestsRegistrationService;
  AdminSupervisorRequestsRegistrationController(
    this._adminSupervisorRequestsRegistrationService,
  );

  @override
  void onInit() async {
    super.onInit();
    debugPrint("AdminSupervisorRequestsRegistrationController onInit");

    queryParams.value = {
      'page': currentPage.value,
      'limit': limit.value,
    };

    await fetchSupervisorRequestsRegistration();

    currentPage.listen((page) {
      debugPrint("currentPage.listen");

      queryParams['page'] = page;
    });
  }

  var isLoading = false.obs;

  late int totalSupervisorRequestsRegistration;

  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var limit = 3.obs;

  var isFilterApplied = false.obs;

  var queryParams = <String, dynamic>{}.obs;

  var sortOrder = SortOrder.notSelected.obs;

  var supervisorRequestsRegistrationList =
      RxList<SupervisorRequestsRegistration>();

  var shouldRefreshData = false.obs;

  Future<void> navigateToSupervisorRequestRegistrationDetailsScreen(
      String supervisorId) async {
    debugPrint("navigateToSupervisorRequestRegistrationDetailsScreen");

    var result = await Get.toNamed(
      AppRoutes.adminSupervisorRequestRegistrationDetails,
      arguments: supervisorId,
    );
    debugPrint("result: $result");

    if (result != null) {
      debugPrint("shouldRefreshData.listen");
      supervisorRequestsRegistrationList.clear();
      await fetchSupervisorRequestsRegistration();
    }
  }

  Future<void> fetchSupervisorRequestsRegistration() async {
    try {
      isLoading(true);

      supervisorRequestsRegistrationList.clear();

      debugPrint("queryParams, $queryParams");
      SupervisorRequestsRegistrationResponseModel
          supervisorRequestsRegistrationResponseModel =
          await _adminSupervisorRequestsRegistrationService
              .fetchSupervisorRequestsRegistration(
        queryParams,
      );

      if (supervisorRequestsRegistrationResponseModel.statusCode == 200 &&
          supervisorRequestsRegistrationResponseModel
              .supervisorRequestsRegistrationList.isNotEmpty) {
        debugPrint("supervisorRequestsRegistrationResponseModel");
        debugPrint(supervisorRequestsRegistrationResponseModel
            .supervisorRequestsRegistrationList.first
            .toString());

        supervisorRequestsRegistrationList.addAll(
            supervisorRequestsRegistrationResponseModel
                .supervisorRequestsRegistrationList);

        debugPrint("supervisorRequestsRegistrationList*****");
        debugPrint(supervisorRequestsRegistrationList.toString());

        debugPrint(supervisorRequestsRegistrationList.length.toString());

        totalPages.value = supervisorRequestsRegistrationResponseModel
            .supervisorRequestsRegistrationMetaData!.totalPages!;

        totalSupervisorRequestsRegistration =
            supervisorRequestsRegistrationResponseModel
                .supervisorRequestsRegistrationMetaData!.totalRecords!;
      } else if (supervisorRequestsRegistrationResponseModel.statusCode ==
          404) {
        supervisorRequestsRegistrationList.clear();
      }
    } catch (e) {
      debugPrint("Error fetching supervisor requests registration: $e");
      isLoading(false);
    } finally {
      isLoading(false);
    }
  }

  Map<String, dynamic> buildFilterQueryParams() {
    debugPrint("buildFilterQueryParams -------------------------------------");

    isFilterApplied.value = true;

    queryParams['page'] = currentPage.value;
    queryParams['limit'] = limit.value;

    if (sortOrder.value != SortOrder.notSelected) {
      queryParams['sortOrder'] =
          sortOrder.value == SortOrder.ascending ? 'asc' : 'desc';
    }

    debugPrint(queryParams.toString());

    supervisorRequestsRegistrationList.clear();

    return queryParams;
  }

  void clearFilterQueryParams() {
    debugPrint(
        "------------------------------------- clearFilterQueryParams -------------------------------------");

    isFilterApplied.value = false;

    currentPage.value = 1;
    limit.value = 10;

    queryParams.clear();

    supervisorRequestsRegistrationList.clear();
  }
}
