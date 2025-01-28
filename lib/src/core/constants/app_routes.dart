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
  static String supervisorGroupDashboard = "/supervisor/group-dashboard";
  static String createGroupSupervisorScreen = "/supervisor/create-group";
  static String supervisorCreateMemorizationGroupContentScreen =
      "/supervisor/create-group-content";
  static String supervisorCurrentGroupsScreen = "/supervisor/current-groups";
  static String supervisorGroupDashboardScreen = "/supervisor/group/dashboard";
  static String supervisorGroupJoinRequest = "/supervisor/group/join-request";
  static String supervisorGroupMembership = "/supervisor/group/membership";
  static String supervisorGroupPlanScreen = "/supervisor/group-plan";
  static String createGroupPlanScreen = "/supervisor/group-plan/create";
  static String supervisorGroupPlanDetails = "/supervisor/group-plan/details";
  static String groupMemberFollowUpRecords =
      "/supervisor/group-member/follow-up-records";

  // Participant Screens
  static String participant = "/participant";
  static String participantHomeScreen = "/participant/home";
  static String participantSearchMemorizationGroup =
      "/participant/search-group";
  static String participantSearchedGroupDetails =
      "/participant/searched-group-details";
  static String participantCurrentGroupsScreen = "/participant/current-groups";

  // Admin Screens
  static String admin = "/admin";
  static String adminHomeScreen = "/admin/home";
  static String adminGroupDashboard = "/admin/group-dashboard";
  static String adminRequestsForCreatingGroup =
      "/admin/requests-for-creating-group";
  static String adminRequestedGroupDetails = "/admin/requested-group-details";
  static String adminSupervisorDashboard = "/admin/supervisor-dashboard";
  static String adminSupervisorRequestsRegistration =
      "/admin/supervisor-requests-registration";
  static String adminSupervisorRequestRegistrationDetails =
      "/admin/supervisor-request-registration/details";
}
