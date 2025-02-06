import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_pages.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/change_localization.dart';
import 'package:moltqa_al_quran_frontend/src/core/localization/translation.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
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

Future<void> showNotificationDialog(
  String title,
  String body,
  RxBool isNotificationDialogShown,
) async {
  await CustomAwesomeDialog.showAwesomeDialog(
    context: Get.overlayContext!,
    dialogType: DialogType.info,
    title: title,
    description: body,
    btnOkOnPress: () {
      isNotificationDialogShown.value = false;
      Get.back();
      Get.toNamed(AppRoutes.notification);
    },
    btnOkText: "تفاصيل",
    btnCancelOnPress: () {
      isNotificationDialogShown.value = false;
    },
  );

  isNotificationDialogShown.value = false;
}

class AlHudaAcademy extends StatefulWidget {
  const AlHudaAcademy({super.key});

  @override
  AlHudaAcademyState createState() => AlHudaAcademyState();
}

class AlHudaAcademyState extends State<AlHudaAcademy> {
  final isNotificationDialogShown = false.obs;

  @override
  @override
  void initState() {
    super.initState();
    // Register the notification listener only once
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        debugPrint("Notification received: ${event.notification.title}");

        debugPrint("isNotificationDialogShown: $isNotificationDialogShown");

        if (!isNotificationDialogShown.value) {
          isNotificationDialogShown.value = true;
          await showNotificationDialog(
            event.notification.title!,
            event.notification.body!,
            isNotificationDialogShown,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    LocalizationController localizationController =
        Get.put(LocalizationController());

    return ToastificationWrapper(
      child: GetMaterialApp(
        locale: localizationController.initialLanguage,
        translations: AppTranslation(),
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.splach,
        getPages: [
          ...AppPages.pages,
        ],
      ),
    );
  }
}
