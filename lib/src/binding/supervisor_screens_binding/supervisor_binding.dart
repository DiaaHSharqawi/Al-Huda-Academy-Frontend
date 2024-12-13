import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_controller.dart';

class SupervisorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorController>(() => SupervisorController());
  }
}
