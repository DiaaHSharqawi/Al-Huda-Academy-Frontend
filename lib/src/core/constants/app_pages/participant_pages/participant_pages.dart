import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_search_memorization_group_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/participant_screens_binding/participant_searched_group_details_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
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
  ];
}
