import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/family_link_controllers/family_link_controller.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/supervisor_controllers/supervisor_custom_bottom_navigation_bar_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_routes.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/family_link/family_link_service.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/family_link/get_childs_by_parent_id_response.dart';

class SupervisorCustomBottomNavigationBar
    extends GetView<SupervisorCustomBottomNavigationBarController> {
  final AppService appService = Get.find<AppService>();
  final FamilyLinkController familyLinkController =
      Get.put(FamilyLinkController(Get.put(FamilyLinkService())));

  SupervisorCustomBottomNavigationBar({super.key});

  bool get isArabic => appService.isRtl.value;

  Future<void> onTap(int index) async {
    if (index == 1) {
      Get.toNamed(AppRoutes.athkarCategories);
    } else if (index == 2) {
      GetChildsByUserIdResponse? response =
          await familyLinkController.getChildrenByParentEmail();

      if (response?.familyLink != null) {
        familyLinkController.familyLinks.assignAll(response!.familyLink!);
      }

      debugPrint("Family links: ${familyLinkController.familyLinks}");
      if (response?.statusCode == 200) {
        Get.toNamed('/family-link/family-links-dashboard');
      } else if (response?.statusCode == 404) {
        Get.toNamed('/family-link/add-participant');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = this.isArabic;
    final String fontFamily =
        isArabic ? AppFonts.arabicFont : AppFonts.englishFont;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 4,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.getFont(
          fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: AppColors.primaryColor,
        ),
        unselectedLabelStyle: GoogleFonts.getFont(
          fontFamily,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
        currentIndex: 1,
        onTap: (index) {
          //controller.currentIndex.value = index;
          onTap(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.book),
            label: 'الأذكار',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.users),
            label: 'الرقابة الابوية',
          ),
        ],
      ),
    );
  }
}
