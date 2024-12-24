import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/participant_controllers/participant_searched_group_details_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/participant/participant_searched_group_details_service.dart';

class ParticipantSearchedGroupDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParticipantSearchedGroupDetailsService>(
      () => ParticipantSearchedGroupDetailsService(),
    );
    Get.lazyPut<ParticipantSearchedGroupDetailsController>(
      () => ParticipantSearchedGroupDetailsController(
        Get.find<ParticipantSearchedGroupDetailsService>(),
      ),
    );
  }
}
