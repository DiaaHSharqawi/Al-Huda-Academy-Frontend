class GroupPlanDetailsResponseModel {
  GroupPlanDetailsResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupPlanDetails,
  });

  final bool? success;
  final String? message;
  final GroupPlanDetails? groupPlanDetails;
  final int statusCode;

  factory GroupPlanDetailsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupPlanDetailsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupPlanDetails: json["groupPlanDetails"] == null
          ? null
          : GroupPlanDetails.fromJson(json["groupPlanDetails"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupPlanDetails": groupPlanDetails?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $groupPlanDetails, ";
  }
}

class GroupPlanDetails {
  GroupPlanDetails({
    required this.id,
    required this.groupId,
    required this.dayDate,
    required this.groupPlanStatusId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.contentToMemorizes,
    required this.contentToReviews,
    required this.groupPlanStatus,
  });

  final int? id;
  final int? groupId;
  final DateTime? dayDate;
  final int? groupPlanStatusId;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ContentToMemorize> contentToMemorizes;
  final List<ContentToReview> contentToReviews;
  final GroupPlanStatus? groupPlanStatus;

  factory GroupPlanDetails.fromJson(Map<String, dynamic> json) {
    return GroupPlanDetails(
      id: json["id"],
      groupId: json["groupId"],
      dayDate: DateTime.tryParse(json["dayDate"] ?? ""),
      groupPlanStatusId: json["group_plan_status_id"],
      note: json["note"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      contentToMemorizes: json["ContentToMemorizes"] == null
          ? []
          : List<ContentToMemorize>.from(json["ContentToMemorizes"]!
              .map((x) => ContentToMemorize.fromJson(x))),
      contentToReviews: json["ContentToReviews"] == null
          ? []
          : List<ContentToReview>.from(json["ContentToReviews"]!
              .map((x) => ContentToReview.fromJson(x))),
      groupPlanStatus: json["GroupPlanStatus"] == null
          ? null
          : GroupPlanStatus.fromJson(json["GroupPlanStatus"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "dayDate":
            "${dayDate?.year.toString().padLeft(4, '0')}-${dayDate?.month.toString().padLeft(2, '0')}-${dayDate?.day.toString().padLeft(2, '0')}",
        "group_plan_status_id": groupPlanStatusId,
        "note": note,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "ContentToMemorizes":
            contentToMemorizes.map((x) => x.toJson()).toList(),
        "ContentToReviews": contentToReviews.map((x) => x.toJson()).toList(),
        "GroupPlanStatus": groupPlanStatus?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupId, $dayDate, $groupPlanStatusId, $note, $createdAt, $updatedAt, $contentToMemorizes, $contentToReviews, $groupPlanStatus, ";
  }
}

class ContentToMemorize {
  ContentToMemorize({
    required this.id,
    required this.groupPlanId,
    required this.surahId,
    required this.startAyah,
    required this.endAyah,
    required this.createdAt,
    required this.updatedAt,
    required this.surah,
  });

  final int? id;
  final int? groupPlanId;
  final int? surahId;
  final int? startAyah;
  final int? endAyah;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Surah? surah;

  factory ContentToMemorize.fromJson(Map<String, dynamic> json) {
    return ContentToMemorize(
      id: json["id"],
      groupPlanId: json["groupPlanId"],
      surahId: json["surahId"],
      startAyah: json["startAyah"],
      endAyah: json["endAyah"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      surah: json["Surah"] == null ? null : Surah.fromJson(json["Surah"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupPlanId": groupPlanId,
        "surahId": surahId,
        "startAyah": startAyah,
        "endAyah": endAyah,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Surah": surah?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupPlanId, $surahId, $startAyah, $endAyah, $createdAt, $updatedAt, $surah, ";
  }
}

class ContentToReview {
  ContentToReview({
    required this.id,
    required this.groupPlanId,
    required this.surahId,
    required this.startAyah,
    required this.endAyah,
    required this.createdAt,
    required this.updatedAt,
    required this.surah,
  });

  final int? id;
  final int? groupPlanId;
  final int? surahId;
  final int? startAyah;
  final int? endAyah;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Surah? surah;

  factory ContentToReview.fromJson(Map<String, dynamic> json) {
    return ContentToReview(
      id: json["id"],
      groupPlanId: json["groupPlanId"],
      surahId: json["surahId"],
      startAyah: json["startAyah"],
      endAyah: json["endAyah"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      surah: json["Surah"] == null ? null : Surah.fromJson(json["Surah"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupPlanId": groupPlanId,
        "surahId": surahId,
        "startAyah": startAyah,
        "endAyah": endAyah,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Surah": surah?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupPlanId, $surahId, $startAyah, $endAyah, $createdAt, $updatedAt, $surah, ";
  }
}

class Surah {
  Surah({
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

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
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

class GroupPlanStatus {
  GroupPlanStatus({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory GroupPlanStatus.fromJson(Map<String, dynamic> json) {
    return GroupPlanStatus(
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
