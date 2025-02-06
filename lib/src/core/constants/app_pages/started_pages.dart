import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';

class StartedPages extends StatefulWidget {
  const StartedPages({super.key});

  @override
  StartedPagesState createState() => StartedPagesState();
}

class StartedPagesState extends State<StartedPages> {
  late PageController _pageController;
  late int initialPage;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CupertinoOnboarding(
        bottomButtonColor: AppColors.primaryColor,
        bottomButtonChild: const Text('البدء'),
        onPressedOnLastPage: () => Get.offNamed(
          AppRoutes.login,
        ),
        pages: [
          // Page 1: Welcome
          CupertinoOnboardingPage(
            title: const Text('أهلاً بك في أكاديمية الهدى للقران الكريم'),
            body: Image.asset(
              AppImages.quranImage3,
              width: 300,
              height: 300,
            ),
          ),

          // Page 2: Overview
          CupertinoOnboardingPage(
            title: const Text('نظرة عامة'),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'تساعد أكاديمية الهدى الطلاب على حفظ القرآن الكريم بطريقة تفاعلية ومنظمة.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 80),
                Image.asset(
                  "assets/images/quran_image_6.png",
                  width: 250,
                  height: 250,
                )
              ],
            ),
          ),

          // Page 3: Objectives

          // Page 5: Call to Action
          CupertinoOnboardingPage(
            title: const Text('انضم إلينا الآن!'),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'ابدأ رحلتك في حفظ القرآن الكريم معنا.\n'
                  'نحن هنا لدعمك في كل خطوة!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  "assets/images/quran_image_4.png",
                  width: 250,
                  height: 250,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
