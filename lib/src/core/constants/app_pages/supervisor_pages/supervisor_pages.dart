import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/create_group_supervisor_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/group_member_follow_up_records_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/group_plan_screens_binding/supervisor_create_group_plan_screen_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/meeting_screens_binding/supervisor_meeting_dashboard_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_current_groups_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_group_dashboard_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_group_join_request_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_group_members_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/group_plan_screens_binding/supervisor_group_plan_details_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/group_plan_screens_binding/supervisor_group_plans_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/supervisor_screens_binding/supervisor_memorization_group_dashboard_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/middlewares/verify_token_jwt_middle_ware.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/create_group_screens/supervisor_create_group_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/group_member_follow_up_records_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/group_plan_screens/supervisor_create_group_plan_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_current_groups_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_group_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_group_join_request_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_group_members_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/group_plan_screens/supervisor_group_plans_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/group_plan_screens/supervisor_group_plan_details_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/group_screens/supervisor_memorization_groups_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/meeting_screens/supervisor_meeting_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/supervisor_screens/supervisor_home_screen.dart';

class SupervisorPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.supervisorHomeScreen,
      page: () => SupervisorHomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: SupervisorBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorGroupDashboard,
      page: () => const SupervisorMemorizationGroupsDashboardScreen(),
      transition: Transition.fadeIn,
      binding: SupervisorMemorizationGroupDashboardBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.createGroupSupervisorScreen,
      page: () => const SupervisorCreateGroupScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: SupervisorCreateGroupScreenBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorCurrentGroupsScreen,
      page: () => const SupervisorCurrentGroupsScreen(),
      transition: Transition.size,
      binding: SupervisorCurrentGroupsBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorGroupDashboardScreen,
      page: () => const SupervisorGroupDashboardScreen(),
      transition: Transition.downToUp,
      binding: SupervisorGroupDashboardBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorGroupJoinRequest,
      page: () => const SupervisorGroupJoinRequestScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: SupervisorGroupJoinRequestBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorGroupMembership,
      page: () => const SupervisorGroupMembersScreen(),
      transition: Transition.topLevel,
      binding: SupervisorGroupMembersBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.createGroupPlanScreen,
      page: () => const SupervisorCreateGroupPlanScreen(),
      transition: Transition.downToUp,
      binding: SupervisorCreateGroupPlanScreenBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorGroupPlanScreen,
      page: () => const SupervisorGroupPlansScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: SupervisorGroupPlansBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorGroupPlanDetails,
      page: () => const SupervisorGroupPlanDetailsScreen(),
      transition: Transition.cupertino,
      binding: SupervisorGroupPlanDetailsBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.groupMemberFollowUpRecords,
      page: () => const GroupMemberFollowUpRecordsScreen(),
      transition: Transition.leftToRightWithFade,
      binding: GroupMemberFollowUpRecordsBinding(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
    GetPage(
      name: AppRoutes.supervisorMeetingDashboard,
      page: () => const SupervisorMeetingDashboardScreen(),
      transition: Transition.downToUp,
      middlewares: [VerifyTokenJwtMiddleWare()],
      binding: SupervisorMeetingDashboardBinding(),
    ),
  ];
}
