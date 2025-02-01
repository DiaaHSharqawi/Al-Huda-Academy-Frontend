import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_group_dashboard_service.dart';

class ParticipantGroupDashboardController extends GetxController {
  final ParticipantGroupDashboardService _participantGroupDashboardService;

  ParticipantGroupDashboardController(this._participantGroupDashboardService);

  var isLoading = false.obs;
}
