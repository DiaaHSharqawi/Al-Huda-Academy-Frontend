import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          backgroundColor: AppColors.primaryBackgroundColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200.0,
                    child: _buildAcademyLogo(),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  _buildEnterVerificationCode(),
                  const SizedBox(
                    height: 16.0,
                  ),
                  _buildOTPVerificationField(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAcademyLogo() {
    return CustomProjectLogo(
      imagePath: AppImages.holyQuranLogo,
      width: 250.0,
      height: 250.0,
      text: SharedLanguageConstants.academyName.tr,
      fontSize: 15.0,
    );
  }

  Widget _buildEnterVerificationCode() {
    return const CustomGoogleTextWidget(
      text: "ادخل رمز التحقق",
      fontSize: 18.0,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildOTPVerificationField() {
    return Container();
  }
}
