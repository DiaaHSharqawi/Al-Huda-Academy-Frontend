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
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_loading_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/role.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class RoleSelectionRegisterScreen extends GetView<RegisterController> {
  const RoleSelectionRegisterScreen({super.key});
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
            child: Obx(
              () => controller.isLoading.value
                  ? SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: const Center(
                        child: CustomLoadingWidget(
                          width: 500.0,
                          height: 500.0,
                          imagePath: AppImages.loadingImage,
                        ),
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 250,
                          child: _buildImageLogo(),
                        ),
                        SizedBox(height: sizeBoxColumnSpace * 2),
                        _buildPleaseChooseText(),
                        Column(
                          children: [
                            SizedBox(height: sizeBoxColumnSpace * 2),
                            _buildRoleSelection(),
                            SizedBox(height: sizeBoxColumnSpace * 2),
                          ],
                        ),
                        _buildChooseButton(context),
                      ],
                    ),
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
        onPressed: () {
          controller.isSubmitting(true);

          if (!context.mounted) return;
          if (controller.selectedRole.value == Role.notSelected) {
            CustomAwesomeDialog.showAwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              title: 'يرجى اختيار النوع للاستمرار',
              description: "يرجى اختيار نوع المستخدم للمتابعة: طالب أو مشرف.",
              btnOkOnPress: () {},
              btnCancelOnPress: null,
            );
            //controller.isSubmitting(false);
          } else {
            debugPrint("Role selected: ${controller.selectedRole.value}");
            debugPrint("Navigate to qualifications screen");
            controller.isSubmitting(false);
            controller.navigateToCredentialScreen();
          }
        },
      ),
    );
  }

  Widget _buildPleaseChooseText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomGoogleTextWidget(
          text: 'التسجيل كـ',
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(width: 10.0),
        CustomGoogleTextWidget(
          text: '*',
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ],
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      children: [
        if (controller.selectedRole.value == Role.notSelected &&
            controller.isSubmitting.value)
          const CustomGoogleTextWidget(
            text: "يرجى اختيار نوع المستخدم للمتابعة:\n طالب أو مشرف.",
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: controller.roles.take(2).map((role) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedRole.value?.name == role.roleName
                        ? AppColors.primaryColor
                        : Colors.grey,
                    width: controller.selectedRole.value?.name == role.roleName
                        ? 3.0
                        : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: GFCheckbox(
                  type: GFCheckboxType.circle,
                  activeBgColor: AppColors.white,
                  onChanged: (value) {
                    controller.selectedRole.value =
                        role.roleName == Role.participant.name
                            ? Role.participant
                            : Role.supervisor;
                    debugPrint("Role selected: $role");
                    controller.selectedRoleId.value = role.id.toString();
                    debugPrint(
                        "controller.selectedRoleId: ${controller.selectedRoleId.value}");
                  },
                  value: controller.selectedRole.value?.name == role.roleName,
                  size: 180.0,
                  inactiveIcon: _buildCheckBoxIcon(
                    'assets/images/${role.roleName}.png',
                    role.roleNameAr.toString(),
                  ),
                  activeIcon: _buildCheckBoxIcon(
                    'assets/images/${role.roleName}.png',
                    role.roleNameAr.toString(),
                  ),
                  inactiveBorderColor: Colors.grey,
                ),
              ),
            );
          }).toList(),
        ),
      ],
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
}
