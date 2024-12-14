import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

class HomeController extends GetxController {
  var welcomeName = "".obs;
  var appService = Get.find<AppService>();

  @override
  void onInit() {
    super.onInit();
    appService.getDecodedToken().then((decodedToken) {
      debugPrint("Decoded Token: $decodedToken");
      debugPrint(decodedToken?["UserInfo"]["fullName"] ?? "");
      welcomeName.value = decodedToken?["UserInfo"]["fullName"] ?? "";
    });
  }
}
