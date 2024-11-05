class SplashScreenLanguageConstants {
  static String academyName = "splash_screen.academy_name";
  static String pageIsLoading = "splash_screen.page_is_loading";
}

class LangugeScreenLanguageConstants {
  static String chooseLanguage = "languge_screen.choose_language";
  static String arabicText = "languge_screen.arabic_text";
  static String englishText = "languge_screen.english_text";
  static String engLanguageCode = "en";
  static String arLanguageCode = "ar";
}

class LoginScreenLanguageConstants {
  static String greeting = "login_screen.greeting";
  static String welcomeBack = "login_screen.welcome_back";

  static String formFieldsInputsEmail = "login_screen.formFieldsInputs_email";
  static String formFieldsInputsPassword =
      "login_screen.formFieldsInputs_password";
  static String formFieldsInputsForgetPassword =
      "login_screen.formFieldsInputs_forget_password";

  static String buttonTextLogin = "login_screen.button_text_login";
  static String dontHaveAnAccount = "login_screen.dont_have_an_account";
  static String newUser = "login_screen.new_user";

  static String hintTextAuthEmail = "name@example.com";
  static String hintTextAuthPassword = "******";

  static String enterAValidEmail = "login_screen.enter_a_valid_email";
  static String userIdentifierRequired =
      "login_screen.user_Identifier_required";

  static String userPasswordRequired = "login_screen.user_password_required";
  static String enterAValidPassword = "login_screen.enter_a_valid_password";

  static String loginFailedMessage = "login_screen.login_failed_message";
  static String invalidInputs = "login_screen.invalid_inputs";

  static String invalidCredentials =
      "login_screen.invalid_credentials_server_error_message";
}

class RegisterScreenLanguageConstants {
  static String createANewAccount = "register_screen.create_a_new_account";
  static String fullName = "register_screen.full_name";
  static String enterAFullName = "register_screen.enter_a_full_name";

  static String email = "register_screen.email";
  static String hintEmail = "name@example.com";

  static String phoneNumber = "register_screen.phone_number";
  static String phoneNumberHint = "059 999-9999";

  static String password = "register_screen.password";
  static String passwordHint = "********";

  static String saveData = "register_screen.save_data";

  static String residence = "register_screen.residence";
  static String enterACountry = "register_screen.enter_a_country";
  static String enterACity = "register_screen.enter_a_city";

  static String age = "register_screen.age";
  static String enterTheAge = "register_screen.enter_the_age";

  static String enterTheGender = "register_screen.enter_the_gender";
  static String genderMale = "register_screen.gender_male";
  static String genderFemale = "register_screen.gender_female";
  static String pleaseChooseTheGender =
      "register_screen.please_choose_the_gender";
  static String pleaseMakeSureToFillAllFields =
      "register_screen.please_make_sure_to_fill_all_fields";

  static String pleaseMakeSureToUploadYourProfileImage =
      "register_screen.please_make_sure_to_upload_your_profile_image";

  static String userRegisteredSuccessfully =
      "register_screen.user_registered_successfully";
}

class AuthValidationsLanguageConstants {
  static String phoneNumberIsRequired =
      "auth_validations.phone_number_is_required";
  static String enterValidPhoneNumber =
      "auth_validations.enter_valid_phone_number";

  static String enterCountry = "auth_validations.enter_country";
  static String countryMinLength = "auth_validations.country_name_min_length";

  static String enterACity = "auth_validations.enter_city";
  static String cityNameMinLength = "auth_validations.city_name_min_length";

  static String enterFullName = "auth_validations.enter_full_name";
  static String enterFullNameMinLength =
      "auth_validations.enter_full_name_min_length";

  static String enterAge = "auth_validations.enter_age";
  static String ageMustBeInteger = "auth_validations.age_must_be_integer";
  static String ageMustBeGreaterThanSix =
      "auth_validations.age_must_be_greater_than_six";
  static String ageMustBeLessThanOneHundred =
      "auth_validations.age_must_be_less_than_one_hundred";

  static String error = "auth_validations.error";
  static String success = "auth_validations.success";

  static String enterAValidPassword = "auth_validations.enter_a_valid_password";
  static String userPasswordRequired =
      "auth_validations.user_password_required";

  static String userIdentifierRequired =
      "auth_validations.user_Identifier_required";

  static String enterAValidEmail = "auth_validations.enter_a_valid_email";

  static String validationCodeRequired =
      "reset_password_screen.validation_code_required";

  static String verificationCodeMustBeFourCharacters =
      "auth_validations.verification_code_must_be_four_characters";
  static String verificationCodeMustBeExactlyFourCharactersAndNoSpaces =
      "reset_password_screen.verification_code_must_be_exactly_four_characters_and_no_spaces";
}

class SharedLanguageConstants {
  static String academyName = "shared.academy_name";
  static String email = "shared.email";
}

class SendPasswordResetCodeScreenLanguageConstants {
  static String forgetPassword =
      "send_password_reset_code_screen.forget_password";
  static String forgetPasswordInstructions =
      "send_password_reset_code_screen.forget_password_instructions";

  static String email = "send_password_reset_code_screen.email";
  static String hintEmailText = "name@example.com";

  static String sendCode = "send_password_reset_code_screen.send_code";
  static String passwordResetCodeSentToYourEmail =
      "send_password_reset_code_screen.password_reset_code_sent_to_your_email";
  static String codeAlreadySent =
      "send_password_reset_code_screen.code_already_sent";

  static String invalidCredentials =
      "send_password_reset_code_screen.invalid_credentials";

  static String pleaseMakeSureToFillAllFields =
      "send_password_reset_code_screen.please_make_sure_to_fill_all_fields";
}

class ResetPasswordScreenLanguageConstants {
  static String passowrd = "reset_password_screen.password";
  static String passwordHintText = "******";

  static String verifyCode = "reset_password_screen.verify_code";
  static String invalidOrExpiredCode =
      "reset_password_screen.invalid_or_expired_code";
  static String passwordResetSuccessfully =
      "reset_password_screen.password_reset_successfully";

  static String enterVerificationCode =
      "reset_password_screen.enter_the_verification_code_sent_to_your_email";
}
