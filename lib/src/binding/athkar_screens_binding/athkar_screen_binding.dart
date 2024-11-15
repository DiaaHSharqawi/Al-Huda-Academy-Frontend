import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/athkar_controllers/athkar_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/athkar/athkar_service.dart';

class AthkarScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AthkarService>(() => AthkarService());
    Get.put(AthkarController(Get.find<AthkarService>()));
  }
}
