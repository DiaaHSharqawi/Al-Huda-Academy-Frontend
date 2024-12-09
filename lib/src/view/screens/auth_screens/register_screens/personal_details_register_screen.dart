import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:board_datetime_picker/board_datetime_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:moltqa_al_quran_frontend/src/controllers/auth_screens_controllers/register_controller.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_colors.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_fonts.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/app_images.dart';
import 'package:moltqa_al_quran_frontend/src/core/constants/language_constants.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_awesome_dialog.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_button.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_project_logo.dart';
import 'package:moltqa_al_quran_frontend/src/core/shared/custom_text_widget.dart';
import 'package:moltqa_al_quran_frontend/src/core/utils/auth_validations.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/auth_screens_widgets/custom_auth_text_form_field.dart';
import 'package:moltqa_al_quran_frontend/src/view/widgets/home_screens_widgets/custom_app_bar.dart';

class PersonalDetailsRegisterScreen extends GetView<RegisterController> {
  const PersonalDetailsRegisterScreen({super.key});
  final double sizeBoxColumnSpace = 20.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child: _buildImageLogo(),
                ),
                SizedBox(height: sizeBoxColumnSpace * 1.5),
                _buildPersonalDetailsText(),
                SizedBox(height: sizeBoxColumnSpace * 1.5),
                _buildPersonalDetailsForm(),
                SizedBox(height: sizeBoxColumnSpace * 1.5),
                _buildPhoneNumberField(),
                SizedBox(height: sizeBoxColumnSpace * 1.5),
                _buildBirthOfDateField(context),
                SizedBox(height: sizeBoxColumnSpace * 1.5),
                _buildContinueButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomGoogleTextWidget(
          text: RegisterScreenLanguageConstants.phoneNumber.tr,
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        IntlPhoneField(
          invalidNumberMessage: 'من فضلك ادخل رقم هاتف صحيح',
          pickerDialogStyle: PickerDialogStyle(
            searchFieldInputDecoration: const InputDecoration(
              hintText: 'ابحث عن دولتك',
            ),
          ),
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          textAlignVertical: TextAlignVertical.center,
          validator: (phone) =>
              AuthValidations.validatePhoneNumber(phone?.number),
          controller: controller.phoneController,
          cursorColor: AppColors.primaryColor,
          decoration: const InputDecoration(
            focusColor: AppColors.primaryColor,
            hoverColor: Colors.red,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor,
                width: 40.0,
              ),
            ),
          ),
          initialCountryCode: 'PS',
          onSaved: (phone) {
            debugPrint("phone is saved : ${phone.toString()}");
            controller.phoneController.text = phone.toString();
          },
          onSubmitted: (phone) {
            debugPrint("phone is submitted ${phone.toString()}");
            controller.phoneController.text = phone;
          },
        ),
      ],
    );
  }

  Widget _buildBirthOfDateField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomGoogleTextWidget(
          text: "تاريخ الميلاد",
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            Expanded(
              child: BoardDateTimeInputField(
                validators: BoardDateTimeInputFieldValidators(
                  onIllegalFormat: (value) {
                    return 'الرجاء اختيار تاريخ صحيح';
                  },
                  onRequired: () {
                    return 'الرجاء اختيار تاريخ الميلاد';
                  },
                ),
                decoration: InputDecoration(
                  hintText: 'إضغط لاختيار تاريخ الميلاد',
                  hintStyle: GoogleFonts.almarai(
                    textStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                controller: controller.dateTimeController,
                pickerType: DateTimePickerType.date,
                options: const BoardDateTimeOptions(
                  pickerFormat: PickerFormat.dmy,
                  calendarSelectionRadius: BorderSide.strokeAlignOutside,
                  languages: BoardPickerLanguages.en(),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  activeColor: AppColors.primaryColor,
                ),
                textStyle: Theme.of(context).textTheme.bodyMedium,
                onChanged: (date) {
                  controller.dateTimeController.setDate(date);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPersonalDetailsForm() {
    return Column(
      children: [
        _buildFullNameTextField(),
        SizedBox(height: sizeBoxColumnSpace * 1.5),
        _buildResidenceFields(),
      ],
    );
  }

  Widget _buildFullNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomGoogleTextWidget(
          text: RegisterScreenLanguageConstants.fullName.tr,
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        CustomAuthTextFormField(
          textFormHintText: RegisterScreenLanguageConstants.enterAFullName.tr,
          colorIcon: AppColors.primaryColor,
          controller: controller.fullNameController,
          textFormFieldValidator: AuthValidations.validateFullName,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
        ),
      ],
    );
  }

  Widget _buildResidenceFields() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomGoogleTextWidget(
            text: RegisterScreenLanguageConstants.residence.tr,
            fontFamily: AppFonts.arabicFont,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 25.0,
        ),
        const CustomGoogleTextWidget(
          text: 'الدولة',
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        CustomAuthTextFormField(
          textFormHintText: RegisterScreenLanguageConstants.enterACountry.tr,
          controller: controller.countryController,
          textFormFieldValidator: AuthValidations.validateCountry,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          obscureText: false,
        ),
        const SizedBox(height: 24.0),
        const CustomGoogleTextWidget(
          text: 'المدينة',
          fontFamily: AppFonts.arabicFont,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12.0),
        CustomAuthTextFormField(
          textFormHintText: RegisterScreenLanguageConstants.enterACity.tr,
          controller: controller.cityController,
          textFormFieldValidator: AuthValidations.validateCity,
          autovalidateMode: controller.isSubmitting.value
              ? AutovalidateMode.always
              : AutovalidateMode.onUserInteraction,
          obscureText: false,
        ),
      ],
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
            Object result = controller.validatePersonalDetails();

            if (result is Map && result['status'] == false) {
              await CustomAwesomeDialog.showAwesomeDialog(
                context,
                DialogType.error,
                'خطأ',
                result['message'],
              );
            } else {
              debugPrint("Valid personal details");
              controller.navigateToGenderSelectionScreen();
            }
          }),
    );
  }

  Widget _buildPersonalDetailsText() {
    return const CustomGoogleTextWidget(
      text: 'ادخل معلوماتك الشخصية :',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }
}
