class AppRoutes {
  // Entry Screens
  static String splach = "/";
  static String language = "/language";

  // Authentication Screens

  static String auth = "/auth";
  static String login = "$auth/login";

  static String register = "$auth/register";
  static String registerParticipant = "$register/participant";
  static String registerSupervisor = "$register/supervisor";
  static String qualificationsRegister = "$auth/qualifications";
  static String credentialDetailsRegister = "$register/credential-details";
  static String personalDetailsRegister = "$register/personal-details";
  static String roleSelectionRegister = "$register/role-selection";
  static String genderSelectionRegister = "$register/gender-selection";
  static String selectProfileImageRegister = "$register/select-profile-image";

  static String sendPasswordResetCode = "$auth/send-password-reset-code";
  static String resetPassword = "$auth/reset-password";

  // Home Screens
  static String home = "/home";

  // Athkar Screens
  static String athkar = "/athkar/category";
  static String athkarCategories = "/athkar/categories";

  // Family Link Screens
  static String familyLink = "/family-link";
  static String addChildParticipantFamilyLink = "/family-link/add-participant";
  static String doesYourChildHaveAccountFamilyLink =
      "/family-link/does-your-child-have-account";
  static String enterYourChildEmailFamilyLink =
      "/family-link/enter-your-child-email";
  static String enterYourChildVerificationCodeFamilyLink =
      "/family-link/enter-your-child-verification-code";
  static String childAccountLinkedSuccessfullyScreen =
      "/family-link/child-account-linked-successfully";

  // Supervisor Screens
  static String supervisor = "/supervisor";
  static String supervisorHomeScreen = "/supervisor/home";
  static String createGroupSupervisorScreen = "/supervisor/create-group";

  // Participant Screens
  static String participant = "/participant";
  static String participantHomeScreen = "/participant/home";

  // Admin Screens
  static String admin = "/admin";
  static String adminHomeScreen = "/admin/home";
}
