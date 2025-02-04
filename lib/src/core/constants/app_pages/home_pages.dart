import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/binding/home_binding.dart';
import 'package:moltqa_al_quran_frontend/src/binding/notification_binding/notification_bindings.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/middlewares/verify_token_jwt_middle_ware.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/home_screen.dart';
import 'package:moltqa_al_quran_frontend/src/view/screens/notification_screens/notifications_screen.dart';

class HomePages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => const NotificationsScreen(),
      binding: NotificationBindings(),
      middlewares: [VerifyTokenJwtMiddleWare()],
    ),
  ];
}
