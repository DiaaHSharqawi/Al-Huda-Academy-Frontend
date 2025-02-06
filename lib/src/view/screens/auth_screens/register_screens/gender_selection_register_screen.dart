import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:getwidget/types/gf_checkbox_type.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/gender.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class GenderSelectionRegisterScreen extends GetView<RegisterController> {
  const GenderSelectionRegisterScreen({super.key});
  final double sizeBoxColumnSpace = 20.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child: _buildImageLogo(),
                ),
                SizedBox(height: sizeBoxColumnSpace * 1.5),
                _buildPleaseChooseText(),
                Obx(
                  () {
                    return Column(
                      children: [
                        SizedBox(height: sizeBoxColumnSpace * 2),
                        _buildGenderSelection(),
                        SizedBox(height: sizeBoxColumnSpace * 2)
                      ],
                    );
                  },
                ),
                _buildChooseButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageLogo() {
    return CustomProjectLogo(
      imagePath: AppImages.holyQuranLogo,
      width: 300,
      height: 300,
      text: SharedLanguageConstants.academyName.tr,
    );
  }

  PreferredSize _buildAppBar() {
    return CustomAppBar(
      showBackArrow: true,
      arrowColor: Colors.black,
      appBarChilds: Column(
        children: [
          Container(
            width: 0,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      preferredSize: const Size.fromHeight(50.0),
      child: const SizedBox(),
    );
  }

  Widget _buildChooseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: 'اختيار',
        buttonTextColor: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        onPressed: () async {
          controller.isSubmitting(true);

          if (!context.mounted) return;
          if (controller.selectedGender.value == Gender.notSelected) {
            await CustomAwesomeDialog.showAwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              title: 'يرجى اختيار نوع الجنس  ',
              description: " يرجى اختيار نوع الجنس للمتابعة: ذكر أو أنثى.",
              btnOkOnPress: () {},
              btnCancelOnPress: null,
            );
          } else {
            controller.isSubmitting(false);

            debugPrint("Gender selected: ${controller.selectedGender.value}");
            debugPrint("Navigate to qualifications screen");
            controller.isSubmitting.value = false;
            controller.navigateToSelectProfileImageScreen();
          }
        },
      ),
    );
  }

  Widget _buildPleaseChooseText() {
    return const CustomGoogleTextWidget(
      text: 'الرجاء الاختيار',
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    );
  }

  Widget _buildCheckBoxIcon(String imagePath, String text) {
    return SizedBox(
      width: 180.0,
      height: 100.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 80.0,
            height: 80.0,
          ),
          const SizedBox(width: 10.0),
          CustomGoogleTextWidget(
            text: text,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Column(
      children: [
        if (controller.selectedGender.value == Gender.notSelected &&
            controller.isSubmitting.value)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: CustomGoogleTextWidget(
              text: 'يرجى اختيار نوع الجنس للمتابعة',
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: controller.genders.map((gender) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: controller.selectedGender.value?.name == gender.nameEn
                      ? AppColors.primaryColor
                      : Colors.grey.withOpacity(0.1),
                  width: controller.selectedGender.value?.name == gender.nameEn
                      ? 5.0
                      : 1.0,
                ),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: GFCheckbox(
                type: GFCheckboxType.circle,
                activeBgColor: AppColors.white,
                onChanged: (value) {
                  debugPrint("value: $value");
                  controller.selectedGender.value =
                      gender.nameEn == "male" ? Gender.male : Gender.female;

                  controller.selectedGenderId.value = gender.id.toString();
                },
                value: gender.nameEn == controller.selectedGender.value?.name,
                size: 180.0,
                inactiveIcon: _buildCheckBoxIcon(
                  'assets/images/${gender.nameEn}.png',
                  gender.nameAr.toString(),
                ),
                activeIcon: _buildCheckBoxIcon(
                  'assets/images/${gender.nameEn}.png',
                  gender.nameAr.toString(),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
