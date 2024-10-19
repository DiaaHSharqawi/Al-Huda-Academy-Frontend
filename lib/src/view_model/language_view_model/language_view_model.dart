import 'package:get/get.dart';

class LanguageViewModel extends GetxController {
  void navigateToLoginSceen() {
    Get.offNamed('/auth/login');
  }
}
