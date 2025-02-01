import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_custom_bottom_navigation_bar_service.dart';

class SupervisorCustomBottomNavigationBarController extends GetxController {
  final SupervisorCustomBottomNavigationBarService
      // ignore: unused_field
      _supervisorCustomBottomNavigationBarService;

  SupervisorCustomBottomNavigationBarController(
    this._supervisorCustomBottomNavigationBarService,
  );

  var currentIndex = 0.obs;
}
