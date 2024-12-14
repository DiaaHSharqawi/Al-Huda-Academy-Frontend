import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/family_link_screens_binding/family_link_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/family_link_screens/add_participant_family_link/child_account_linked_successfully_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/family_link_screens/add_participant_family_link/does_your_child_have_account_add_participant_family_link_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/family_link_screens/add_participant_family_link/enter_child_verification_code_family_link_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/family_link_screens/add_participant_family_link/enter_your_child_email_family_link_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/family_link_screens/add_participant_family_link/family_links_dashboard_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/family_link_screens/add_participant_family_link/overview_add_participant_family_link_screen.dart';

class FamilyLinksPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.familyLink,
      page: () => const FamilyLinksDashboardScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.addChildParticipantFamilyLink,
      page: () => const OverviewAddParticipantFamilyLinkScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: FamilyLinkBinding(),
    ),
    GetPage(
      name: AppRoutes.doesYourChildHaveAccountFamilyLink,
      page: () =>
          const DoesYourChildHaveAccountAddParticipantFamilyLinkScreen(),
      transition: Transition.size,
    ),
    GetPage(
      name: AppRoutes.enterYourChildEmailFamilyLink,
      page: () => const EnterYourChildEmailFamilyLinkScreen(),
      transition: Transition.topLevel,
    ),
    GetPage(
      name: AppRoutes.enterYourChildVerificationCodeFamilyLink,
      page: () => const EnterChildVerificationCodeFamilyLinkScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.childAccountLinkedSuccessfullyScreen,
      page: () => const ChildAccountLinkedSuccessfullyScreen(),
      transition: Transition.leftToRightWithFade,
    ),
  ];
}
