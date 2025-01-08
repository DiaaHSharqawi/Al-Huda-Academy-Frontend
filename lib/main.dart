import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/change_localization.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/translation.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:toastification/toastification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  await AppTranslation.loadTranslations();

  try {
    await dotenv.load(fileName: 'assets/.env');
    debugPrint("Loaded .env file successfully.");
  } catch (e) {
    debugPrint("Error loading .env file: ${e.runtimeType} - $e");
  }
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']!,
      appId: dotenv.env['FIREBASE_APP_ID']!,
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
      projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    ),
  );

  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint("Firebase Messaging Token: $token");

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize(dotenv.env['ONESIGNAL_APP_ID']!);
  OneSignal.Notifications.requestPermission(true);

  runApp(const AlHudaAcademy());
}

class AlHudaAcademy extends StatelessWidget {
  const AlHudaAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    LocalizationController localizationController =
        Get.put(LocalizationController());

    return ToastificationWrapper(
      child: GetMaterialApp(
        locale: localizationController.initialLanguage,
        translations: AppTranslation(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.language,
        getPages: [
          ...AppPages.pages,
        ],
      ),
    );
  }
}
