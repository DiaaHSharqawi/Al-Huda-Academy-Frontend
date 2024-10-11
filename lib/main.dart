import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/view/language_screen.dart/language_screen.dart';
import 'src/view/splash_screen_view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: 'assets/.env');
    debugPrint("Loaded .env file successfully.");
  } catch (e) {
    debugPrint("Error loading .env file: ${e.runtimeType} - $e");
  }

  runApp(const AlHudaAcademy());
}

class AlHudaAcademy extends StatelessWidget {
  const AlHudaAcademy({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      getPages: [
        GetPage(
          name: '/language',
          page: () => const LanguageScreen(),
        ),
      ],
    );
  }
}
