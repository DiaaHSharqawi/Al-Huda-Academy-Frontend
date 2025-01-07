class SupervisorRequestRegistrationDetailsResponseModel {
  SupervisorRequestRegistrationDetailsResponseModel({
    required this.success,
    required this.message,
    required this.supervisorRequestRegistrationDetails,
    required this.statusCode,
  });

  final bool? success;
  final String? message;
  final SupervisorRequestRegistrationDetails?
      supervisorRequestRegistrationDetails;

  final int? statusCode;

  factory SupervisorRequestRegistrationDetailsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SupervisorRequestRegistrationDetailsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      supervisorRequestRegistrationDetails:
          json["supervisorRequestRegistrationDetails"] == null
              ? null
              : SupervisorRequestRegistrationDetails.fromJson(
                  json["supervisorRequestRegistrationDetails"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "supervisorRequestRegistrationDetails":
            supervisorRequestRegistrationDetails?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $supervisorRequestRegistrationDetails, ";
  }
}

class SupervisorRequestRegistrationDetails {
  SupervisorRequestRegistrationDetails({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.phone,
    required this.city,
    required this.country,
    required this.genderId,
    required this.details,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    required this.user,
    required this.juzas,
    required this.supervisorCertificates,
    required this.gender,
  });

  final int? id;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? phone;
  final String? city;
  final String? country;
  final int? genderId;
  final String? details;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;
  final SupervisorRequestRegistrationJuzaUser? user;
  final List<SupervisorRequestRegistrationJuza> juzas;
  final List<SupervisorCertificate> supervisorCertificates;
  final Gender? gender;

  factory SupervisorRequestRegistrationDetails.fromJson(
      Map<String, dynamic> json) {
    return SupervisorRequestRegistrationDetails(
      id: json["id"],
      fullName: json["fullName"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      phone: json["phone"],
      city: json["city"],
      country: json["country"],
      genderId: json["gender_id"],
      details: json["details"],
      profileImage: json["profileImage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      userId: json["userId"],
      user: json["User"] == null
          ? null
          : SupervisorRequestRegistrationJuzaUser.fromJson(json["User"]),
      juzas: json["Juzas"] == null
          ? []
          : List<SupervisorRequestRegistrationJuza>.from(json["Juzas"]!
              .map((x) => SupervisorRequestRegistrationJuza.fromJson(x))),
      supervisorCertificates: json["SupervisorCertificates"] == null
          ? []
          : List<SupervisorCertificate>.from(json["SupervisorCertificates"]!
              .map((x) => SupervisorCertificate.fromJson(x))),
      gender: json["Gender"] == null ? null : Gender.fromJson(json["Gender"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "phone": phone,
        "city": city,
        "country": country,
        "gender_id": genderId,
        "details": details,
        "profileImage": profileImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "User": user?.toJson(),
        "Juzas": juzas.map((x) => x.toJson()).toList(),
        "SupervisorCertificates":
            supervisorCertificates.map((x) => x.toJson()).toList(),
        "Gender": gender?.toJson(),
      };

  @override
  String toString() {
    return "$id, $fullName, $dateOfBirth, $phone, $city, $country, $genderId, $details, $profileImage, $createdAt, $updatedAt, $userId, $user, $juzas, $supervisorCertificates, $gender, ";
  }
}

class Gender {
  Gender({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json["id"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
      };

  @override
  String toString() {
    return "$id, $nameAr, $nameEn, ";
  }
}

class SupervisorRequestRegistrationJuza {
  SupervisorRequestRegistrationJuza({
    required this.id,
    required this.arabicPart,
    required this.englishPart,
  });

  final int? id;
  final String? arabicPart;
  final String? englishPart;

  factory SupervisorRequestRegistrationJuza.fromJson(
      Map<String, dynamic> json) {
    return SupervisorRequestRegistrationJuza(
      id: json["id"],
      arabicPart: json["arabic_part"],
      englishPart: json["english_part"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "arabic_part": arabicPart,
        "english_part": englishPart,
      };

  @override
  String toString() {
    return "$id, $arabicPart, $englishPart, ";
  }
}

class SupervisorCertificate {
  SupervisorCertificate({
    required this.id,
    required this.certificateImage,
    required this.createdAt,
    required this.updatedAt,
    required this.supervisorId,
  });

  final int? id;
  final String? certificateImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? supervisorId;

  factory SupervisorCertificate.fromJson(Map<String, dynamic> json) {
    return SupervisorCertificate(
      id: json["id"],
      certificateImage: json["certificateImage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      supervisorId: json["supervisorId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "certificateImage": certificateImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "supervisorId": supervisorId,
      };

  @override
  String toString() {
    return "$id, $certificateImage, $createdAt, $updatedAt, $supervisorId, ";
  }
}

class SupervisorRequestRegistrationJuzaUser {
  SupervisorRequestRegistrationJuzaUser({
    required this.email,
    required this.isActive,
    required this.createdAt,
  });

  final String? email;
  final bool? isActive;
  final DateTime? createdAt;

  factory SupervisorRequestRegistrationJuzaUser.fromJson(
      Map<String, dynamic> json) {
    return SupervisorRequestRegistrationJuzaUser(
      email: json["email"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$email, $isActive, $createdAt, ";
  }
}
