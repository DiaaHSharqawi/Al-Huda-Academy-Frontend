import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/group_member_follow_up_records_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/supervisor/group_member_follow_up_records_service.dart';

class GroupMemberFollowUpRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupMemberFollowUpRecordsService>(
      () => GroupMemberFollowUpRecordsService(),
    );

    Get.lazyPut<GroupMemberFollowUpRecordsController>(
      () => GroupMemberFollowUpRecordsController(
        Get.find<GroupMemberFollowUpRecordsService>(),
      ),
    );
  }
}
