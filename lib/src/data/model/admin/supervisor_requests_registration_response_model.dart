class SupervisorRequestsRegistrationResponseModel {
  SupervisorRequestsRegistrationResponseModel({
    required this.success,
    required this.message,
    required this.supervisorRequestsRegistrationList,
    required this.statusCode,
    required this.supervisorRequestsRegistrationMetaData,
  });
  final int? statusCode;
  final bool? success;
  final String? message;
  final List<SupervisorRequestsRegistration> supervisorRequestsRegistrationList;
  final SupervisorRequestsRegistrationMetaData?
      supervisorRequestsRegistrationMetaData;

  factory SupervisorRequestsRegistrationResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SupervisorRequestsRegistrationResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      supervisorRequestsRegistrationList:
          json["supervisorRequestsRegistration"] == null
              ? []
              : List<SupervisorRequestsRegistration>.from(
                  json["supervisorRequestsRegistration"]!
                      .map((x) => SupervisorRequestsRegistration.fromJson(x))),
      supervisorRequestsRegistrationMetaData:
          json["supervisorRequestsRegistrationMetaData"] == null
              ? null
              : SupervisorRequestsRegistrationMetaData.fromJson(
                  json["supervisorRequestsRegistrationMetaData"],
                ),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "supervisorRequestsRegistration":
            supervisorRequestsRegistrationList.map((x) => x.toJson()).toList(),
        "supervisorRequestsRegistrationMetaData":
            supervisorRequestsRegistrationMetaData?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $supervisorRequestsRegistrationList, $statusCode, $supervisorRequestsRegistrationMetaData, ";
  }
}

class SupervisorRequestsRegistration {
  SupervisorRequestsRegistration({
    required this.id,
    required this.fullName,
    required this.details,
    required this.profileImage,
    required this.userSupevisor,
  });

  final int? id;
  final String? fullName;
  final String? details;
  final String? profileImage;
  final UserSupevisor? userSupevisor;

  factory SupervisorRequestsRegistration.fromJson(Map<String, dynamic> json) {
    return SupervisorRequestsRegistration(
      id: json["id"],
      fullName: json["fullName"],
      details: json["details"],
      profileImage: json["profileImage"],
      userSupevisor: json["UserSupevisor"] == null
          ? null
          : UserSupevisor.fromJson(json["UserSupevisor"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "details": details,
        "profileImage": profileImage,
        "UserSupevisor": userSupevisor?.toJson(),
      };

  @override
  String toString() {
    return "$id, $fullName, $details, $profileImage, $userSupevisor, ";
  }
}

class UserSupevisor {
  UserSupevisor({
    required this.email,
    required this.isActive,
  });

  final String? email;
  final bool? isActive;

  factory UserSupevisor.fromJson(Map<String, dynamic> json) {
    return UserSupevisor(
      email: json["email"],
      isActive: json["isActive"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "isActive": isActive,
      };

  @override
  String toString() {
    return "$email, $isActive, ";
  }
}

class SupervisorRequestsRegistrationMetaData {
  SupervisorRequestsRegistrationMetaData({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalRecords;

  factory SupervisorRequestsRegistrationMetaData.fromJson(
      Map<String, dynamic> json) {
    return SupervisorRequestsRegistrationMetaData(
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      totalRecords: json["totalRecords"],
    );
  }

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
      };

  @override
  String toString() {
    return "$currentPage, $totalPages, $totalRecords, ";
  }
}
