import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppService extends GetxService {
  late GetStorage languageStorage;

  Future<AppService> init() async {
    await GetStorage.init();
    languageStorage = GetStorage();
    return this;
  }
}

Future<void> initialServices() async {
  await Get.putAsync(() => AppService().init());
}
