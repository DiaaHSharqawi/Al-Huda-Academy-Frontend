class MemorizationGroupDetailsResponseModel {
  MemorizationGroupDetailsResponseModel({
    required this.success,
    required this.message,
    required this.memorizationGroup,
    required this.statusCode,
  });

  final bool? success;
  final String? message;
  final MemorizationGroupDetails? memorizationGroup;
  final int statusCode;

  factory MemorizationGroupDetailsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return MemorizationGroupDetailsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      memorizationGroup: json["memorizationGroup"] == null
          ? null
          : MemorizationGroupDetails.fromJson(json["memorizationGroup"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "memorizationGroup": memorizationGroup?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $memorizationGroup, ";
  }
}

class MemorizationGroupDetails {
  MemorizationGroupDetails({
    required this.id,
    required this.groupName,
    required this.groupDescription,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.groupStatusId,
    required this.groupGoalId,
    required this.genderId,
    required this.participantsLevelId,
    required this.teachingMethodId,
    required this.createdAt,
    required this.supervisorId,
    required this.gender,
    required this.days,
    required this.groupStatus,
    required this.participantLevel,
    required this.groupGoal,
    required this.languages,
    required this.teachingMethod,
    required this.supervisor,
    required this.surahs,
    required this.juzas,
    required this.extracts,
  });

  final int? id;
  final String? groupName;
  final String? groupDescription;
  final int? capacity;
  final String? startTime;
  final String? endTime;
  final int? groupStatusId;
  final int? groupGoalId;
  final int? genderId;
  final int? participantsLevelId;
  final int? teachingMethodId;
  final DateTime? createdAt;
  final int? supervisorId;
  final GenderGroupDetails? gender;
  final List<DayGroupDetails> days;
  final GroupStatusDetails? groupStatus;
  final ParticipantLevelGroupDetails? participantLevel;
  final GroupGoalDetails? groupGoal;
  final List<LanguageGroupDetails> languages;
  final TeachingMethodGroupDetails? teachingMethod;
  final SupervisorGroupDetails? supervisor;
  final List<SurahGroup> surahs;
  final List<JuzaGroup> juzas;
  final List<ExtractGroupDetails> extracts;

  factory MemorizationGroupDetails.fromJson(Map<String, dynamic> json) {
    return MemorizationGroupDetails(
      id: json["id"],
      groupName: json["group_name"],
      groupDescription: json["group_description"],
      capacity: json["capacity"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      groupStatusId: json["group_status_id"],
      groupGoalId: json["group_goal_id"],
      genderId: json["gender_id"],
      participantsLevelId: json["participants_level_id"],
      teachingMethodId: json["teaching_method_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      supervisorId: json["supervisor_id"],
      gender: json["Gender"] == null
          ? null
          : GenderGroupDetails.fromJson(json["Gender"]),
      days: json["Days"] == null
          ? []
          : List<DayGroupDetails>.from(
              json["Days"]!.map((x) => DayGroupDetails.fromJson(x))),
      groupStatus: json["GroupStatus"] == null
          ? null
          : GroupStatusDetails.fromJson(json["GroupStatus"]),
      participantLevel: json["ParticipantLevel"] == null
          ? null
          : ParticipantLevelGroupDetails.fromJson(json["ParticipantLevel"]),
      groupGoal: json["GroupGoal"] == null
          ? null
          : GroupGoalDetails.fromJson(json["GroupGoal"]),
      languages: json["Languages"] == null
          ? []
          : List<LanguageGroupDetails>.from(
              json["Languages"]!.map((x) => LanguageGroupDetails.fromJson(x))),
      teachingMethod: json["TeachingMethod"] == null
          ? null
          : TeachingMethodGroupDetails.fromJson(json["TeachingMethod"]),
      supervisor: json["Supervisor"] == null
          ? null
          : SupervisorGroupDetails.fromJson(json["Supervisor"]),
      surahs: json["surahs"] == null
          ? []
          : List<SurahGroup>.from(json["surahs"]!.map((x) => x)),
      juzas: json["juzas"] == null
          ? []
          : List<JuzaGroup>.from(
              json["juzas"]!.map((x) => JuzaGroup.fromJson(x))),
      extracts: json["extracts"] == null
          ? []
          : List<ExtractGroupDetails>.from(json["extracts"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "group_description": groupDescription,
        "capacity": capacity,
        "start_time": startTime,
        "end_time": endTime,
        "group_status_id": groupStatusId,
        "group_goal_id": groupGoalId,
        "gender_id": genderId,
        "participants_level_id": participantsLevelId,
        "teaching_method_id": teachingMethodId,
        "createdAt": createdAt?.toIso8601String(),
        "supervisor_id": supervisorId,
        "Gender": gender?.toJson(),
        "Days": days.map((x) => x.toJson()).toList(),
        "GroupStatus": groupStatus?.toJson(),
        "ParticipantLevel": participantLevel?.toJson(),
        "GroupGoal": groupGoal?.toJson(),
        "Languages": languages.map((x) => x.toJson()).toList(),
        "TeachingMethod": teachingMethod?.toJson(),
        "Supervisor": supervisor?.toJson(),
        "surahs": surahs.map((x) => x.toJson()).toList(),
        "juzas": juzas.map((x) => x.toJson()).toList(),
        "extracts": extracts.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatusId, $groupGoalId, $genderId, $participantsLevelId, $teachingMethodId, $createdAt, $supervisorId, $gender, $days, $groupStatus, $participantLevel, $groupGoal, $languages, $teachingMethod, $supervisor, $surahs, $juzas, $extracts, ";
  }
}

class ExtractGroupDetails {
  ExtractGroupDetails({
    required this.id,
    required this.surahId,
    required this.ayat,
    required this.groupId,
    required this.surah,
  });

  final int? id;
  final int? surahId;
  final String? ayat;
  final int? groupId;
  final SurahGroup? surah;

  factory ExtractGroupDetails.fromJson(Map<String, dynamic> json) {
    return ExtractGroupDetails(
      id: json["id"],
      surahId: json["surahId"],
      ayat: json["ayat"],
      groupId: json["groupId"],
      surah: json["Surah"] == null ? null : SurahGroup.fromJson(json["Surah"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "surahId": surahId,
        "ayat": ayat,
        "groupId": groupId,
        "Surah": surah?.toJson(),
      };

  @override
  String toString() {
    return "$id, $surahId, $ayat, $groupId, $surah, ";
  }
}

class SurahGroup {
  SurahGroup({
    required this.id,
    required this.surahId,
    required this.groupId,
    required this.surah,
  });

  final int? id;
  final int? surahId;
  final int? groupId;
  final SurahClass? surah;

  factory SurahGroup.fromJson(Map<String, dynamic> json) {
    return SurahGroup(
      id: json["id"],
      surahId: json["surahId"],
      groupId: json["groupId"],
      surah: json["Surah"] == null ? null : SurahClass.fromJson(json["Surah"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "surahId": surahId,
        "groupId": groupId,
        "Surah": surah?.toJson(),
      };

  @override
  String toString() {
    return "$id, $surahId, $groupId, $surah, ";
  }
}

class SurahClass {
  SurahClass({
    required this.id,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  final int? id;
  final String? name;
  final String? englishName;
  final String? englishNameTranslation;
  final int? numberOfAyahs;
  final String? revelationType;

  factory SurahClass.fromJson(Map<String, dynamic> json) {
    return SurahClass(
      id: json["id"],
      name: json["name"],
      englishName: json["englishName"],
      englishNameTranslation: json["englishNameTranslation"],
      numberOfAyahs: json["numberOfAyahs"],
      revelationType: json["revelationType"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationType,
      };

  @override
  String toString() {
    return "$id, $name, $englishName, $englishNameTranslation, $numberOfAyahs, $revelationType, ";
  }
}

class GenderGroupDetails {
  GenderGroupDetails({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  final int? id;
  final String? nameEn;
  final String? nameAr;

  factory GenderGroupDetails.fromJson(Map<String, dynamic> json) {
    return GenderGroupDetails(
      id: json["id"],
      nameEn: json["name_en"],
      nameAr: json["name_ar"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
      };

  @override
  String toString() {
    return "$id, $nameEn, $nameAr, ";
  }
}

class DayGroupDetails {
  DayGroupDetails({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.dayMemorizationGroup,
  });

  final int? id;
  final String? nameEn;
  final String? nameAr;
  final DayMemorizationGroup? dayMemorizationGroup;

  factory DayGroupDetails.fromJson(Map<String, dynamic> json) {
    return DayGroupDetails(
      id: json["id"],
      nameEn: json["name_en"],
      nameAr: json["name_ar"],
      dayMemorizationGroup: json["DayMemorizationGroup"] == null
          ? null
          : DayMemorizationGroup.fromJson(json["DayMemorizationGroup"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
        "DayMemorizationGroup": dayMemorizationGroup?.toJson(),
      };

  @override
  String toString() {
    return "$id, $nameEn, $nameAr, $dayMemorizationGroup, ";
  }
}

class DayMemorizationGroup {
  DayMemorizationGroup({
    required this.id,
    required this.dayId,
    required this.groupId,
  });

  final int? id;
  final int? dayId;
  final int? groupId;

  factory DayMemorizationGroup.fromJson(Map<String, dynamic> json) {
    return DayMemorizationGroup(
      id: json["id"],
      dayId: json["day_id"],
      groupId: json["group_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "day_id": dayId,
        "group_id": groupId,
      };

  @override
  String toString() {
    return "$id, $dayId, $groupId, ";
  }
}

class GroupGoalDetails {
  GroupGoalDetails({
    required this.id,
    required this.groupGoalAr,
    required this.groupGoalEng,
  });

  final int? id;
  final String? groupGoalAr;
  final String? groupGoalEng;

  factory GroupGoalDetails.fromJson(Map<String, dynamic> json) {
    return GroupGoalDetails(
      id: json["id"],
      groupGoalAr: json["group_goal_ar"],
      groupGoalEng: json["group_goal_eng"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_goal_ar": groupGoalAr,
        "group_goal_eng": groupGoalEng,
      };

  @override
  String toString() {
    return "$id, $groupGoalAr, $groupGoalEng, ";
  }
}

class GroupStatusDetails {
  GroupStatusDetails({
    required this.id,
    required this.statusNameAr,
    required this.statusNameEn,
  });

  final int? id;
  final String? statusNameAr;
  final String? statusNameEn;

  factory GroupStatusDetails.fromJson(Map<String, dynamic> json) {
    return GroupStatusDetails(
      id: json["id"],
      statusNameAr: json["status_name_ar"],
      statusNameEn: json["status_name_en"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "status_name_ar": statusNameAr,
        "status_name_en": statusNameEn,
      };

  @override
  String toString() {
    return "$id, $statusNameAr, $statusNameEn, ";
  }
}

class JuzaGroup {
  JuzaGroup({
    required this.id,
    required this.juzaId,
    required this.groupId,
    required this.juza,
  });

  final int? id;
  final int? juzaId;
  final int? groupId;
  final JuzaGroupDetails? juza;

  factory JuzaGroup.fromJson(Map<String, dynamic> json) {
    return JuzaGroup(
      id: json["id"],
      juzaId: json["juzaId"],
      groupId: json["groupId"],
      juza:
          json["Juza"] == null ? null : JuzaGroupDetails.fromJson(json["Juza"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "juzaId": juzaId,
        "groupId": groupId,
        "Juza": juza?.toJson(),
      };

  @override
  String toString() {
    return "$id, $juzaId, $groupId, $juza, ";
  }
}

class JuzaGroupDetails {
  JuzaGroupDetails({
    required this.id,
    required this.arabicPart,
    required this.englishPart,
  });

  final int? id;
  final String? arabicPart;
  final String? englishPart;

  factory JuzaGroupDetails.fromJson(Map<String, dynamic> json) {
    return JuzaGroupDetails(
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

class LanguageGroupDetails {
  LanguageGroupDetails({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
    required this.groupLanguage,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GroupLanguage? groupLanguage;

  factory LanguageGroupDetails.fromJson(Map<String, dynamic> json) {
    return LanguageGroupDetails(
      id: json["id"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      groupLanguage: json["GroupLanguage"] == null
          ? null
          : GroupLanguage.fromJson(json["GroupLanguage"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "GroupLanguage": groupLanguage?.toJson(),
      };

  @override
  String toString() {
    return "$id, $nameAr, $nameEn, $createdAt, $updatedAt, $groupLanguage, ";
  }
}

class GroupLanguage {
  GroupLanguage({
    required this.id,
    required this.groupId,
    required this.languageId,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? groupId;
  final int? languageId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GroupLanguage.fromJson(Map<String, dynamic> json) {
    return GroupLanguage(
      id: json["id"],
      groupId: json["group_id"],
      languageId: json["language_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "language_id": languageId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $groupId, $languageId, $createdAt, $updatedAt, ";
  }
}

class ParticipantLevelGroupDetails {
  ParticipantLevelGroupDetails({
    required this.id,
    required this.participantLevelEn,
    required this.participantLevelAr,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? participantLevelEn;
  final String? participantLevelAr;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ParticipantLevelGroupDetails.fromJson(Map<String, dynamic> json) {
    return ParticipantLevelGroupDetails(
      id: json["id"],
      participantLevelEn: json["participant_level_en"],
      participantLevelAr: json["participant_level_ar"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "participant_level_en": participantLevelEn,
        "participant_level_ar": participantLevelAr,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $participantLevelEn, $participantLevelAr, $createdAt, $updatedAt, ";
  }
}

class SupervisorGroupDetails {
  SupervisorGroupDetails({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.phone,
    required this.city,
    required this.country,
    required this.genderId,
    required this.numberOfMemorizedParts,
    required this.numberOfMemorizedSurahs,
    required this.details,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  final int? id;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? phone;
  final String? city;
  final String? country;
  final int? genderId;
  final int? numberOfMemorizedParts;
  final int? numberOfMemorizedSurahs;
  final String? details;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;

  factory SupervisorGroupDetails.fromJson(Map<String, dynamic> json) {
    return SupervisorGroupDetails(
      id: json["id"],
      fullName: json["fullName"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      phone: json["phone"],
      city: json["city"],
      country: json["country"],
      genderId: json["gender_id"],
      numberOfMemorizedParts: json["numberOfMemorizedParts"],
      numberOfMemorizedSurahs: json["numberOfMemorizedSurahs"],
      details: json["details"],
      profileImage: json["profileImage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      userId: json["userId"],
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
        "numberOfMemorizedParts": numberOfMemorizedParts,
        "numberOfMemorizedSurahs": numberOfMemorizedSurahs,
        "details": details,
        "profileImage": profileImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };

  @override
  String toString() {
    return "$id, $fullName, $dateOfBirth, $phone, $city, $country, $genderId, $numberOfMemorizedParts, $numberOfMemorizedSurahs, $details, $profileImage, $createdAt, $updatedAt, $userId, ";
  }
}

class TeachingMethodGroupDetails {
  TeachingMethodGroupDetails({
    required this.id,
    required this.methodNameArabic,
    required this.methodNameEnglish,
    required this.descriptionArabic,
    required this.descriptionEnglish,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? methodNameArabic;
  final String? methodNameEnglish;
  final String? descriptionArabic;
  final String? descriptionEnglish;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TeachingMethodGroupDetails.fromJson(Map<String, dynamic> json) {
    return TeachingMethodGroupDetails(
      id: json["id"],
      methodNameArabic: json["methodNameArabic"],
      methodNameEnglish: json["methodNameEnglish"],
      descriptionArabic: json["descriptionArabic"],
      descriptionEnglish: json["descriptionEnglish"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "methodNameArabic": methodNameArabic,
        "methodNameEnglish": methodNameEnglish,
        "descriptionArabic": descriptionArabic,
        "descriptionEnglish": descriptionEnglish,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $methodNameArabic, $methodNameEnglish, $descriptionArabic, $descriptionEnglish, $isActive, $createdAt, $updatedAt, ";
  }
}
