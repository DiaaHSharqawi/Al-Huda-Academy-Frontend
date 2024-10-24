import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppService extends GetxService {
  late GetStorage languageStorage;
  var isRtl = false.obs;
  Future<AppService> init() async {
    await GetStorage.init();
    languageStorage = GetStorage();

    String? lang = languageStorage.read('language');
    debugPrint("lang device : $lang");
    lang == 'ar' ? isRtl.value = true : isRtl.value = false;

    return this;
  }

  void changeLanguage(String langCode) {
    Locale language = Locale(langCode);
    Get.updateLocale(language);
    languageStorage.write('language', langCode);
    isRtl.value = (langCode == 'ar');
  }
}

Future<void> initialServices() async {
  await Get.putAsync(() => AppService().init());
}
