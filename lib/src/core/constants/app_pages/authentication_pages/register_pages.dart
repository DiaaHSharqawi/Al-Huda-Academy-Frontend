import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moltqa_al_quran_frontend/src/binding/auth_screens_binding/register_binding.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/register_screens/credential_details_register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/register_screens/gender_selection_register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/register_screens/personal_details_register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/register_screens/qualifications_register_screens.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/register_screens/role_selection_register_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/auth_screens/register_screens/select_profile_image_register_screen.dart';

class RegisterPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.qualificationsRegister,
      page: () => const QualificationsRegisterScreens(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: AppRoutes.credentialDetailsRegister,
      page: () => const CredentialDetailsRegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: AppRoutes.genderSelectionRegister,
      page: () => const GenderSelectionRegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
    GetPage(
      name: AppRoutes.roleSelectionRegister,
      page: () => const RoleSelectionRegisterScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.selectProfileImageRegister,
      page: () => const SelectProfileImageRegisterScreen(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.personalDetailsRegister,
      page: () => const PersonalDetailsRegisterScreen(),
      binding: RegisterBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 1000),
    ),
  ];
}
