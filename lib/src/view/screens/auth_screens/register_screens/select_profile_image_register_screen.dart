import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/profile_image.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/role.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class SelectProfileImageRegisterScreen extends GetView<RegisterController> {
  const SelectProfileImageRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildPleaseChooseProfileImageText(),
                    const SizedBox(height: 50.0),
                    _buildProfileImagePicker(),
                    const SizedBox(height: 80.0),
                    _buildOrChooseFromText(),
                    const SizedBox(height: 80.0),
                    _buildImagesProfile(),
                    const SizedBox(height: 80.0),
                    _buildRegisterButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return const CustomAppBar(
      showBackArrow: true,
      arrowColor: Colors.black,
      preferredSize: Size.fromHeight(50),
      appBarChilds: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
      appBarBackgroundImage: null,
      backgroundColor: Colors.white,
      child: SizedBox.expand(),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => CustomButton(
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          buttonText: "تسجيل",
          buttonTextColor: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          onPressed: () async {
            controller.isSubmitting(true);

            if (!context.mounted) return;
            if (controller.selectedProfileImage.value ==
                ProfileImage.notSelected) {
              CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.info,
                'يرجى اختيار صورة شخصية',
                "يرجى اختيار صورة شخصية للمتابعة",
              );
            } else {
              if (!context.mounted) return;
              controller.isSubmitting(false);

              debugPrint("Role selected: ${controller.selectedRole.value}");
              debugPrint("Navigate to qualifications screen");
              controller.isSubmitting.value = false;
              // controller.navigateToCredentialScreen();
              Object registerResult = {};

              if (controller.selectedRole.value == Role.participant) {
                registerResult = await controller.registerParticipant();
              } else if (controller.selectedRole.value == Role.supervisor) {
                registerResult = await controller.registerSupervisor();
              }

              if (!context.mounted) return;
              if (registerResult is Map && registerResult['success']) {
                await CustomAwesomeDialog.showAwesomeDialog(
                  context,
                  DialogType.success,
                  'تم التسجيل بنجاح',
                  (registerResult)['message'],
                );
                controller.navigateToLoginScreen();
              } else {
                controller.isSubmitting(false);

                await CustomAwesomeDialog.showAwesomeDialog(
                  context,
                  DialogType.error,
                  'حدث خطأ',
                  (registerResult as Map)['message'],
                );
              }
            }
          },
          loadingWidget: controller.isLoading.value
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildOrChooseFromText() {
    return Column(
      children: [
        const CustomGoogleTextWidget(
          text: 'أو اختر من الصور التالية :',
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 16.0),
        if (controller.selectedProfileImage.value == ProfileImage.notSelected &&
            controller.isSubmitting.value)
          const CustomGoogleTextWidget(
            text: 'الرجاء اختيار صورة شخصية',
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
      ],
    );
  }

  Widget _buildImagesProfile() {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildMaleImageProfile(),
            const SizedBox(width: 20.0),
            _buildFemaleImageProfile(),
          ],
        );
      },
    );
  }

  Widget _buildFemaleImageProfile() {
    return GestureDetector(
      onTap: () {
        debugPrint("pressed");
        controller.selectedProfileImage.value = ProfileImage.female;
        assetToUint8List(
          'assets/images/femaleImageProfile.png',
        );
      },
      child: _buildCircleAvatar(
        'femaleImageProfile.png',
        ProfileImage.female,
      ),
    );
  }

  Widget _buildMaleImageProfile() {
    return GestureDetector(
      onTap: () {
        controller.selectedProfileImage.value = ProfileImage.male;
        assetToUint8List(
          'assets/images/maleImageProfile.png',
        );
      },
      child: _buildCircleAvatar(
        'maleImageProfile.png',
        ProfileImage.male,
      ),
    );
  }

  Widget _buildCircleAvatar(String imageName, ProfileImage? profileImage) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: controller.selectedProfileImage.value == profileImage
            ? Border.all(color: AppColors.blackColor, width: 5.0)
            : null,
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          radius: 81.0,
          backgroundImage: AssetImage('assets/images/$imageName'),
        ),
      ),
    );
  }

  Widget _buildPleaseChooseProfileImageText() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomGoogleTextWidget(
        text: 'الرجاء اختيار صورة شخصية',
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Obx(
      () {
        return Stack(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[100],
              radius: 64.0,
              backgroundImage: controller.profileImage.value != null
                  ? MemoryImage(controller.profileImage.value!)
                  : const AssetImage(
                      AppImages.userAvatarImage,
                    ),
            ),
            Positioned(
              bottom: -10.0,
              right: 0.0,
              child: IconButton(
                onPressed: _selectImage,
                icon: const Icon(
                  Icons.add_a_photo,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            if (controller.profileImage.value != null)
              Positioned(
                top: 0,
                right: -5.0,
                child: IconButton(
                  onPressed: () {
                    controller.profileImage.value = null;
                    controller.selectedProfileImage.value =
                        ProfileImage.notSelected;
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _selectImage() async {
    Uint8List? img = await CustomImagePicker.pickImage(ImageSource.gallery);
    if (img != null) {
      controller.updateProfileImage(img);
      controller.selectedProfileImage.value = ProfileImage.upload;
    }
  }

  Future<void> assetToUint8List(String assetPath) async {
    ByteData byteData = await rootBundle.load(assetPath);
    controller.profileImage.value = byteData.buffer.asUint8List();
  }
}
