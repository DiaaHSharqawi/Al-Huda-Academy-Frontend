import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/enums/role.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/juzas/juza_response.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/quran_memorizing_amount/quran_memorizing_amount_response_model.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

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
          padding: const EdgeInsets.all(32.0),
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
                  //    _buildHowMuchOfTheQuranDoYouMemorize(),
                  _buildMultiJuzzaSelection(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
                  ),
                  controller.selectedRole.value == Role.supervisor
                      ? _buildUploadCertificate()
                      : const SizedBox(),
                  controller.selectedRole.value == Role.participant
                      ? _buildQuranMemorizingAmount()
                      : const SizedBox(),
                  SizedBox(
                    height: sizeBoxColumnSpace * 2,
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

  Widget _buildQuranMemorizingAmount() {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CustomGoogleTextWidget(
                text: 'مقدار الحفظ يومياً',
                fontFamily: AppFonts.arabicFont,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 8.0),
              CustomGoogleTextWidget(
                text: ' *',
                color: Colors.red,
                fontSize: 32.0,
              ),
            ],
          ),
          SizedBox(height: sizeBoxColumnSpace),
          if (controller.quranMemorizingAmounts.isNotEmpty)
            GFDropdown(
              dropdownColor: Colors.white,
              focusColor: Colors.white,
              items: controller.quranMemorizingAmounts.map((entry) {
                return DropdownMenuItem<QuranMemorizingAmount>(
                  key: Key(entry.id.toString()),
                  value: entry,
                  child: CustomGoogleTextWidget(
                    text: entry.amountArabic!,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                debugPrint('newValue: $newValue');

                controller.selectedQuranMemorizingAmountId.value =
                    newValue!.id.toString();

                debugPrint(
                    "controller.selectedQuranMemorizingAmountId: ${controller.selectedQuranMemorizingAmountId.value}");
              },
              value: controller.quranMemorizingAmounts.firstWhereOrNull(
                  (entry) =>
                      entry.id.toString() ==
                      controller.selectedQuranMemorizingAmountId.value),
              hint: const CustomGoogleTextWidget(
                text: 'اختر مقدار الحفظ',
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              borderRadius: BorderRadius.circular(5),
              border: const BorderSide(color: Colors.black, width: 1),
            ),
          if (controller.isSubmitting.value &&
              controller.selectedQuranMemorizingAmountId.value.isEmpty)
            const CustomGoogleTextWidget(
              text: 'يرجى اختيار مقدار الحفظ',
              color: Colors.red,
              fontSize: 14.0,
            ),
        ],
      );
    });
  }

  Widget _buildAnyDetailsYouWouldLikeToMention() {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CustomGoogleTextWidget(
                text: 'هل تود ذكر أي تفاصيل أخرى؟',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 8.0),
              CustomGoogleTextWidget(
                text: ' (اختياري)',
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ],
          ),
          SizedBox(
            height: sizeBoxColumnSpace,
          ),
          CustomAuthTextFormField(
            maxLines: 5,
            textFormHintText: 'أكتب هنا',
            controller: controller.anyDetailsController,
            textFormFieldValidator: (value) {
              return null;
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
        const Row(
          children: [
            CustomGoogleTextWidget(
              text: 'يرجى تحميل شهادة تثبت خبرتك :',
              fontFamily: AppFonts.arabicFont,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 8.0),
            CustomGoogleTextWidget(
              text: ' *',
              color: Colors.red,
              fontSize: 32.0,
            ),
          ],
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
                return Column(
                  children: [
                    GFBorder(
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
                                              icon: const Icon(
                                                  Icons.remove_circle,
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
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (controller.isSubmitting.value &&
                        controller.certificateImages.isEmpty)
                      const CustomGoogleTextWidget(
                        text: 'يرجى تحميل شهادة تثبت خبرتك',
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                  ],
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

  Widget _buildMultiJuzzaSelection() {
    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CustomGoogleTextWidget(
                text: 'اختر الأجزاء التي تحفظها',
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(width: 8.0),
              CustomGoogleTextWidget(
                text: ' *',
                color: Colors.red,
                fontSize: 32.0,
              ),
            ],
          ),
          SizedBox(
            height: sizeBoxColumnSpace,
          ),
          GFRadioListTile(
            title: const CustomGoogleTextWidget(
              text: 'لا شيء',
              fontSize: 16.0,
            ),
            size: 25,
            activeBgColor: AppColors.primaryColor,
            value: 'none',
            groupValue: controller.selectedMemorizingOption.value,
            onChanged: (value) {
              controller.selectedJuzzas.clear();
              controller.selectedMemorizingOption.value = value.toString();
            },
          ),
          GFRadioListTile(
            title: const CustomGoogleTextWidget(
              text: 'كل الأجزاء',
              fontSize: 16.0,
            ),
            size: 25,
            activeBgColor: AppColors.primaryColor,
            value: 'all',
            groupValue: controller.selectedMemorizingOption.value,
            onChanged: (value) {
              controller.selectedJuzzas.clear();
              controller.selectedMemorizingOption.value = value.toString();
              debugPrint(
                  "Selected memorizing option: ${controller.selectedMemorizingOption.value}");
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GFRadioListTile(
              title: const CustomGoogleTextWidget(
                text: 'أجزاء محددة',
                fontSize: 16.0,
              ),
              size: 25,
              activeBgColor: AppColors.primaryColor,
              value: 'parts',
              groupValue: controller.selectedMemorizingOption.value,
              onChanged: (value) {
                controller.selectedJuzzas.clear();
                controller.selectedMemorizingOption.value = value.toString();
                debugPrint(
                    "Selected memorizing option: ${controller.selectedMemorizingOption.value}");
              },
            ),
          ),
          if (controller.selectedMemorizingOption.value == 'parts')
            MultiSelectDialogField(
              searchable: true,
              searchHint: 'ابحث عن الجزء',
              items: controller.juzas
                  .map((juz) => MultiSelectItem(juz, juz.arabicPart!))
                  .toList(),
              chipDisplay: MultiSelectChipDisplay<Juza>(
                chipColor: AppColors.primaryColor,
                textStyle: GoogleFonts.getFont(
                  'Almarai',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
                items: controller.selectedJuzzas
                    .map((juz) => MultiSelectItem<Juza>(juz, juz.arabicPart!))
                    .toList(),
                onTap: (value) {
                  controller.selectedJuzzas.remove(value);
                },
              ),
              title: const CustomGoogleTextWidget(
                text: "اختر الأجزاء",
                fontSize: 16.0,
              ),
              selectedColor: AppColors.primaryColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 2,
                ),
              ),
              buttonIcon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryColor,
              ),
              buttonText: Text(
                "اختر الأجزاء",
                style: GoogleFonts.almarai(
                  fontSize: 16.0,
                  color: AppColors.blackColor,
                ),
              ),
              onConfirm: (values) {
                controller.selectedJuzzas.value = values;
                debugPrint(
                    "Selected juzs: ${controller.selectedJuzzas.toString()}");
              },
            ),
          if (controller.selectedMemorizingOption.value == 'parts' &&
              controller.selectedJuzzas.isEmpty &&
              controller.isSubmitting.value)
            const CustomGoogleTextWidget(
              text: 'يرجى اختيار الاجزاء المحددة التي تحفظها',
              color: Colors.red,
              fontSize: 14.0,
            ),
          if (controller.isSubmitting.value &&
              controller.selectedJuzzas.isEmpty &&
              controller.selectedMemorizingOption.value == '')
            const CustomGoogleTextWidget(
              text: 'يرجى اختيار الأجزاء التي تحفظها',
              color: Colors.red,
              fontSize: 14.0,
            ),
        ],
      );
    });
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
      child: Obx(
        () {
          return CustomButton(
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
                  context: context,
                  dialogType: DialogType.error,
                  title: 'خطأ',
                  description: result['message'],
                  btnOkOnPress: () {},
                  btnCancelOnPress: null,
                );
              } else {
                debugPrint('Navigate to the next screen');
                controller.isSubmitting.value = false;
                controller.navigateToPersonalDetailsScreen();
              }
            },
            loadingWidget: controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : null,
            isEnabled: !controller.isLoading.value,
          );
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
              const Row(
                children: [
                  CustomGoogleTextWidget(
                    text: 'نرجو تأكيد قراءة التالي :',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(width: 8.0),
                  CustomGoogleTextWidget(
                    text: ' *',
                    color: Colors.red,
                    fontSize: 32.0,
                  ),
                ],
              ),
              SizedBox(
                height: sizeBoxColumnSpace,
              ),
              if (controller.selectedRole.value == Role.supervisor)
                _buildRequiresATestInMemorizingTheHolyQuran()
              else
                const SizedBox(),
              _buildNeedAnInterviewCheckBox(),
              if (controller.isSubmitting.value &&
                  !controller.confirmations.contains(true))
                const CustomGoogleTextWidget(
                  text: 'يرجى تأكيد قراءة المتطلبات',
                  color: Colors.red,
                  fontSize: 14.0,
                ),
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
