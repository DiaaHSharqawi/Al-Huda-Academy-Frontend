import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/Validations.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/role.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class QualificationsRegisterScreens extends GetView<RegisterController> {
  const QualificationsRegisterScreens({super.key});
  final double sizeBoxColumnSpace = 20.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildQualificationsImage(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  //    _buildPleaseConfirmTheFollowingReading(),
                  _buildDoYouHaveAnyQualificationsText(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  _buildHowMuchOfTheQuranDoYouMemorize(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  controller.selectedRole.value == Role.supervisor
                      ? _buildUploadCertificate()
                      : const SizedBox(),
                  SizedBox(
                    height: sizeBoxColumnSpace,
                  ),
                  _buildAnyDetailsYouWouldLikeToMention(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  _buildPleaseConfirmTheFollowingReading(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  _buildContinueButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnyDetailsYouWouldLikeToMention() {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomGoogleTextWidget(
            text: 'هل تود ذكر أي تفاصيل أخرى؟',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: sizeBoxColumnSpace,
          ),
          CustomAuthTextFormField(
            maxLines: 5,
            textFormHintText: 'أكتب هنا',
            controller: controller.anyDetailsController,
            textFormFieldValidator: (value) {
              return null; // Make it optional by not validating
            },
            autovalidateMode: controller.isSubmitting.value
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            onTap: () {
              debugPrint('onTap');
            },
          ),
        ],
      );
    });
  }

  Widget _buildUploadCertificate() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: 'يرجى تحميل شهادة تثبت خبرتك :',
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GestureDetector(
            onTap: () {
              // Handle the tap event here
              _selectImages();
              debugPrint('Upload certificate tapped');
            },
            child: Obx(
              () {
                return GFBorder(
                  dashedLine: const [4, 6],
                  type: GFBorderType.rect,
                  color: AppColors.primaryColor,
                  child: Center(
                    child: controller.certificateImages.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (var i = 0;
                                    i < controller.certificateImages.length;
                                    i++)
                                  Stack(
                                    children: [
                                      Image.memory(
                                          controller.certificateImages[i]),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                          onPressed: () {
                                            controller.certificateImages
                                                .removeAt(i);
                                            debugPrint(
                                                'Certificate image removed');
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: 50,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(height: 8.0),
                              CustomGoogleTextWidget(
                                text: 'اضغط هنا لتحميل الشهادة',
                                fontFamily: AppFonts.arabicFont,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectImages() async {
    final picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    for (var file in pickedFiles) {
      Uint8List img = await file.readAsBytes();
      controller.addCertificateImage(
        img,
      );
    }
  }

  Widget _buildHowMuchOfTheQuranDoYouMemorize() {
    return Obx(
      () {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomGoogleTextWidget(
              text: 'عدد أجزاء القرآن الكريم التي تحفظها',
              fontFamily: AppFonts.arabicFont,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: sizeBoxColumnSpace),
            CustomAuthTextFormField(
              textFormHintText: 'من فضلك ادخل رقماَ ما بين 0 و 30',
              controller: controller.partsController,
              textFormFieldValidator:
                  Validations.validateNumberOfPartsMemorized,
              autovalidateMode: controller.isSubmitting.value
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              onTap: () {
                debugPrint('onTap');
              },
            ),
            const SizedBox(height: 12.0),
            const CustomGoogleTextWidget(
              text: 'عدد سور القرآن الكريم التي تحفظها',
              fontFamily: AppFonts.arabicFont,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: sizeBoxColumnSpace),
            CustomAuthTextFormField(
              textFormHintText: 'من فضلك ادخل رقماَ ما بين 0 و 114',
              controller: controller.surahsController,
              textFormFieldValidator:
                  Validations.validateNumberOfSurahsMemorized,
              autovalidateMode: controller.isSubmitting.value
                  ? AutovalidateMode.always
                  : AutovalidateMode.onUserInteraction,
              onTap: () {
                debugPrint('onTap');
              },
            ),
          ],
        );
      },
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

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
        buttonText: 'استمر',
        buttonTextColor: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        onPressed: () async {
          Object result = controller.validateQualifications();
          debugPrint("Result: $result");
          if (result is Map && result['status'] == false) {
            CustomAwesomeDialog.showAwesomeDialog(
              context,
              DialogType.error,
              'خطأ',
              result['message'],
            );
          } else {
            debugPrint('Navigate to the next screen');
            controller.isSubmitting.value = false;
            controller.navigateToPersonalDetailsScreen();
          }
        },
      ),
    );
  }

  Widget _buildPleaseConfirmTheFollowingReading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomGoogleTextWidget(
                text: 'نرجو تأكيد قراءة التالي :',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: sizeBoxColumnSpace,
              ),
              if (controller.selectedRole.value == Role.supervisor)
                _buildRequiresATestInMemorizingTheHolyQuran()
              else
                const SizedBox(),
              _buildNeedAnInterviewCheckBox()
            ],
          );
        }),
      ],
    );
  }

  Widget _buildRequiresATestInMemorizingTheHolyQuran() {
    return GFCheckboxListTile(
      position: GFPosition.start,
      title: const CustomGoogleTextWidget(
        text: 'يتطلب اختبار في حفظ القرآن الكريم',
        fontSize: 18.0,
      ),
      size: 32,
      activeBgColor: Colors.green,
      type: GFCheckboxType.circle,
      activeIcon: const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      ),
      onChanged: (value) {
        debugPrint('value: $value');
        controller.confirmations[1] = value;
      },
      value: controller.confirmations[1],
      inactiveIcon: null,
    );
  }

  Widget _buildNeedAnInterviewCheckBox() {
    return GFCheckboxListTile(
      position: GFPosition.start,
      title: const CustomGoogleTextWidget(
        text: 'يتطلب مقابلة',
        fontSize: 18.0,
      ),
      size: 32,
      activeBgColor: Colors.green,
      type: GFCheckboxType.circle,
      activeIcon: const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      ),
      onChanged: (value) {
        debugPrint('value: $value');
        controller.confirmations[0] = value;
      },
      value: controller.confirmations[0],
      inactiveIcon: null,
    );
  }

  Widget _buildQualificationsImage() {
    return Image.asset(
      'assets/images/qualification.png',
      width: double.infinity,
      height: 150.0,
    );
  }

  Widget _buildDoYouHaveAnyQualificationsText() {
    return const CustomGoogleTextWidget(
      text: 'هل أنت حافظ للقرآن الكريم أو متقن لأحكام التجويد؟',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }
}
