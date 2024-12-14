import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';

class SupervisorController extends GetxController {
  void navigateToCreateGroupScreen() {
    Get.toNamed(AppRoutes.createGroupSupervisorScreen);
  }
}
