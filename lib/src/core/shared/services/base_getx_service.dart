import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';

abstract class BaseGetxService extends GetxService {
  static String staticTokenBarrier = "AL_HUDA";
  get tokenBarrier => staticTokenBarrier;

  static final alHudaBaseURL = dotenv.env['Al_HUDA_BASE_URL'] ?? 'No URL found';

  var appService = Get.find<AppService>();

  Future<String?> getToken() async {
    String? token = await appService.getToken();
    return "$tokenBarrier $token";
  }

  get getAlHudaBaseURL => alHudaBaseURL;
  get getAlHudaBaseURLString => alHudaBaseURL.toString();

  get getAppService => appService;
}
