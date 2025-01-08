import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/admin/admin_supervisor_request_registration_details_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/account_statuses/account_statuses_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/admin/supervisor_request_registration_details_response_model.dart';

class AdminSupervisorRequestRegistrationDetailsController
    extends GetxController {
  final AdminSupervisorRequestRegistrationDetailsService
      _adminSupervisorRequestRegistrationDetailsService;

  AdminSupervisorRequestRegistrationDetailsController(
    this._adminSupervisorRequestRegistrationDetailsService,
  );

  var isLoading = false.obs;
  var supervisorIdRequestRegistrationDetails = ''.obs;

  final List<AccountStatus> accountStatuses = [];

  var supervisorRequestRegistrationDetails =
      Rxn<SupervisorRequestRegistrationDetails>();

  @override
  Future<void> onInit() async {
    super.onInit();

    debugPrint("AdminSupervisorRequestRegistrationDetailsController onInit");

    supervisorIdRequestRegistrationDetails.value = Get.arguments.toString();

    try {
      isLoading(true);

      await fetchSupervisorRequestsRegistrationDetails();
      await getAccountStatusList();
    } catch (e) {
      debugPrint(
          'Error in onInit AdminSupervisorRequestRegistrationDetailsController: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSupervisorRequestsRegistrationDetails() async {
    try {
      isLoading(true);

      debugPrint("fetchSupervisorRequestsRegistrationDetails");

      SupervisorRequestRegistrationDetailsResponseModel
          supervisorRequestRegistrationDetailsResponseModel =
          await _adminSupervisorRequestRegistrationDetailsService
              .fetchSupervisorRequestsRegistrationDetails(
        supervisorIdRequestRegistrationDetails.value,
      );

      if (supervisorRequestRegistrationDetailsResponseModel.statusCode == 200) {
        debugPrint(
            "supervisorRequestRegistrationDetailsResponseModel status is 200");

        supervisorRequestRegistrationDetails.value =
            supervisorRequestRegistrationDetailsResponseModel
                .supervisorRequestRegistrationDetails;
      } else if (supervisorRequestRegistrationDetailsResponseModel.statusCode ==
          404) {
        supervisorRequestRegistrationDetails.value = null;
      }
    } catch (e) {
      debugPrint(
          'Error fetching requests for supervisorRequestRegistrationDetailsResponseModel: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getAccountStatusList() async {
    var accountStatusesResponse =
        await _adminSupervisorRequestRegistrationDetailsService
            .getAccountStatusList();

    debugPrint("accountStatusesResponse");
    debugPrint(accountStatusesResponse.toString());
    if (accountStatusesResponse.isNotEmpty) {
      accountStatuses.addAll(accountStatusesResponse);
    }
  }
}
