import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/family_link/family_link_service.dart';

class FamilyLinkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FamilyLinkService>(() => FamilyLinkService());

    Get.lazyPut<FamilyLinkController>(
        () => FamilyLinkController(Get.find<FamilyLinkService>()));
  }
}
