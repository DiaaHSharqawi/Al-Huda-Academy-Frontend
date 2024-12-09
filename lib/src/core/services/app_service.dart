import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppService extends GetxService {
  late GetStorage languageStorage;
  var isRtl = false.obs;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

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

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'token');
  }

  Future<void> clearToken() async {
    await _secureStorage.delete(key: 'token');
  }

  Future<Map<String, dynamic>?> getDecodedToken(token) async {
    String? token = await getToken();
    if (token != null && JwtDecoder.isExpired(token) == false) {
      return JwtDecoder.decode(token);
    } else {
      debugPrint("Token is either null or expired");
      return null;
    }
  }
}

Future<void> initialServices() async {
  await Get.putAsync(() => AppService().init());
}
