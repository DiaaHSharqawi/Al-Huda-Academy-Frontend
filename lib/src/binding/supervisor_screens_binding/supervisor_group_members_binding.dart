import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_group_members_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/supervisor_group_members_service.dart';

class SupervisorGroupMembersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupervisorGroupMembersService>(
      () => SupervisorGroupMembersService(),
    );

    Get.lazyPut<SupervisorGroupMembershipController>(
      () => SupervisorGroupMembershipController(
        Get.find<SupervisorGroupMembersService>(),
      ),
    );
  }
}
