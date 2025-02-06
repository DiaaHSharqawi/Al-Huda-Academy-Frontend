import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_current_groups_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_group_dashboard_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_search_memorization_group_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_searched_group_details_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/participant_screens/memorization_group_screens/participant_current_groups_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/participant_screens/memorization_group_screens/participant_group_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/participant_screens/memorization_group_screens/participant_searched_group_details_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/participant_screens/participant_home_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/participant_screens/memorization_group_screens/participant_search_memorization_group_screen.dart';

class ParticipantPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.participantHomeScreen,
      page: () => ParticipantHomeScreen(),
      transition: Transition.fadeIn,
      binding: ParticipantBinding(),
    ),
    GetPage(
      name: AppRoutes.participantSearchMemorizationGroup,
      page: () => const ParticipantSearchMemorizationGroupScreen(),
      transition: Transition.rightToLeftWithFade,
      binding: ParticipantSearchMemorizationGroupBinding(),
    ),
    GetPage(
      name: AppRoutes.participantSearchedGroupDetails,
      page: () => const ParticipantSearchedGroupDetailsScreen(),
      transition: Transition.fadeIn,
      binding: ParticipantSearchedGroupDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.participantCurrentGroupsScreen,
      page: () => const ParticipantCurrentGroupsScreen(),
      transition: Transition.topLevel,
      binding: ParticipantCurrentGroupsBinding(),
    ),
    GetPage(
      name: AppRoutes.participantGroupDashboard,
      page: () => const ParticipantGroupDashboardScreen(),
      transition: Transition.fadeIn,
      binding: ParticipantGroupDashboardBinding(),
    ),
  ];
}
