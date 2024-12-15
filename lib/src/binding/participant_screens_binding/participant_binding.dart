import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_service.dart';

class ParticipantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ParticipantService());
    Get.lazyPut<ParticipantController>(() => ParticipantController(
          Get.find<ParticipantService>(),
        ));
  }
}
