import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/services/app_service.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_button.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appService = Get.find<AppService>();
    final isArabic = appService.languageStorage.read('language') ==
        'ar'; // Accessing language setting
    debugPrint("$isArabic");
    final TextDirection textDirection =
        isArabic ? TextDirection.rtl : TextDirection.ltr;
    debugPrint("$textDirection");
    final String fontFamily = isArabic
        ? AppFonts.arabicFont // Arabic font if locale is Arabic
        : AppFonts.englishFont; // English font otherwise

    debugPrint(fontFamily);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Directionality(
          textDirection: textDirection,
          child: Container(
            color: Colors.white,
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomGoogleTextWidget(
                      text: "login_screen.greeting".tr,
                      color: AppColors.primaryColor,
                      fontFamily: fontFamily,
                      // textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    CustomGoogleTextWidget(
                      text: "login_screen.welcome_back".tr,
                      color: AppColors.primaryColor,
                    ),
                    FittedBox(
                      child: Image.asset(
                        AppImages.holyQuranLogo,
                        width: 250,
                        height: 250,
                      ),
                    ),
                    Column(
                      children: [
                        CustomAuthTextFormField(
                          textFormLabelText:
                              "login_screen.formFieldsInputs_email".tr,
                          textFormHintText: "diaa@gmail.com",
                          iconName: Icons.email,
                          colorIcon: AppColors.primaryColor,
                          hintTextDirection:
                              isArabic ? TextDirection.rtl : TextDirection.ltr,
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        CustomAuthTextFormField(
                          obscureText: true,
                          textFormLabelText:
                              "login_screen.formFieldsInputs_password".tr,
                          textFormHintText: "*********",
                          iconName: Icons.remove_red_eye,
                          colorIcon: AppColors.primaryColor,
                          hintTextDirection:
                              isArabic ? TextDirection.rtl : TextDirection.ltr,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomGoogleTextWidget(
                            text:
                                "login_screen.formFieldsInputs_forget_password"
                                    .tr,
                            color: AppColors.primaryColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomAuthTextButton(
                            foregroundColor: Colors.white,
                            backgroundColor: AppColors.primaryColor,
                            buttonText: "login_screen.button_text_login".tr,
                            buttonTextColor: Colors.white,
                            fontFamily: fontFamily,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 24.0,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomGoogleTextWidget(
                                  text: "login_screen.dont_have_an_account".tr,
                                  fontFamily: fontFamily,
                                  fontSize: 16.0,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                const SizedBox(
                                  width: 12.0,
                                ),
                                CustomGoogleTextWidget(
                                  text: "login_screen.new_user".tr,
                                  fontFamily: fontFamily,
                                  fontSize: 16.0,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
