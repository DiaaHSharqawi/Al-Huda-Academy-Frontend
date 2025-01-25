import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_current_groups_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_current_groups_service.dart';

class ParticipantCurrentGroupsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantCurrentGroupsService>(
        () => ParticipantCurrentGroupsService());

    Get.lazyPut<ParticipantCurrentGroupsController>(
      () => ParticipantCurrentGroupsController(
        Get.find<ParticipantCurrentGroupsService>(),
      ),
    );
  }
}
