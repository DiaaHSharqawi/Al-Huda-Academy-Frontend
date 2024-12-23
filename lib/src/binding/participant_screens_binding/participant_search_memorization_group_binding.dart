import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_search_memorization_group_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_search_memorization_group_service.dart';

class ParticipantSearchMemorizationGroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantSearchMemorizationGroupService>(
        () => ParticipantSearchMemorizationGroupService());

    Get.lazyPut<ParticipantSearchMemorizationGroupController>(
      () => ParticipantSearchMemorizationGroupController(
        Get.find<ParticipantSearchMemorizationGroupService>(),
      ),
    );
  }
}
