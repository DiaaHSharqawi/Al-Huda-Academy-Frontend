import 'package:flutter/foundation.dart';

class GroupMemberFollowUpRecordsResponseModel {
  GroupMemberFollowUpRecordsResponseModel({
    required this.groupMemberFollowUpRecordsMetadata,
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupMemberFollowUpRecords,
  });

  final bool? success;
  final String? message;
  final GroupMemberFollowUpRecord? groupMemberFollowUpRecords;
  final int statusCode;
  final GroupMemberFollowUpRecordsMetadata? groupMemberFollowUpRecordsMetadata;

  factory GroupMemberFollowUpRecordsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    debugPrint('Parsing GroupMemberFollowUpRecordsResponseModel from JSON');
    return GroupMemberFollowUpRecordsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupMemberFollowUpRecordsMetadata:
          json["groupMemberFollowUpRecordsMetadata"] == null
              ? null
              : GroupMemberFollowUpRecordsMetadata.fromJson(
                  json["groupMemberFollowUpRecordsMetadata"]),
      groupMemberFollowUpRecords: json["groupMemberFollowUpRecords"] == null
          ? null
          : GroupMemberFollowUpRecord.fromJson(
              json["groupMemberFollowUpRecords"]),
    );
  }

  Map<String, dynamic> toJson() {
    debugPrint('Converting GroupMemberFollowUpRecordsResponseModel to JSON');
    return {
      "success": success,
      "message": message,
      "groupMemberFollowUpRecords": groupMemberFollowUpRecords?.toJson(),
    };
  }

  @override
  String toString() {
    return "$success, $message, $groupMemberFollowUpRecords, ";
  }
}

class GroupMemberFollowUpRecord {
  GroupMemberFollowUpRecord({
    required this.id,
    required this.groupMemberId,
    required this.groupPlanId,
    required this.gradeOfMemorization,
    required this.gradeOfReview,
    required this.attendanceStatusId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.attendanceStatus,
    required this.groupPlan,
  });

  final int? id;
  final int? groupMemberId;
  final int? groupPlanId;
  final double? gradeOfMemorization;
  final double? gradeOfReview;
  final int? attendanceStatusId;
  final dynamic note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GroupMemberFollowUpRecordsAttendanceStatus? attendanceStatus;
  final GroupPlan? groupPlan;

  factory GroupMemberFollowUpRecord.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing GroupMemberFollowUpRecord from JSON');
    debugPrint(json.toString());
    return GroupMemberFollowUpRecord(
      id: json["id"],
      groupMemberId: json["group_member_id"],
      groupPlanId: json["group_plan_id"],
      gradeOfMemorization: json["grade_of_memorization"]?.toDouble(),
      gradeOfReview: json["grade_of_review"]?.toDouble(),
      attendanceStatusId: json["attendance_status_id"],
      note: json["note"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      attendanceStatus: json["AttendanceStatus"] == null
          ? null
          : GroupMemberFollowUpRecordsAttendanceStatus.fromJson(
              json["AttendanceStatus"]),
      groupPlan: json["GroupPlan"] == null
          ? null
          : GroupPlan.fromJson(json["GroupPlan"]),
    );
  }

  Map<String, dynamic> toJson() {
    debugPrint('Converting GroupMemberFollowUpRecord to JSON');
    return {
      "id": id,
      "group_member_id": groupMemberId,
      "group_plan_id": groupPlanId,
      "grade_of_memorization": gradeOfMemorization,
      "grade_of_review": gradeOfReview,
      "attendance_status_id": attendanceStatusId,
      "note": note,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "AttendanceStatus": attendanceStatus?.toJson(),
      "GroupPlan": groupPlan?.toJson(),
    };
  }

  @override
  String toString() {
    return "$id, $groupMemberId, $groupPlanId, $gradeOfMemorization, $gradeOfReview, $attendanceStatusId, $note, $createdAt, $updatedAt, $attendanceStatus, $groupPlan, ";
  }
}

class GroupMemberFollowUpRecordsAttendanceStatus {
  GroupMemberFollowUpRecordsAttendanceStatus({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory GroupMemberFollowUpRecordsAttendanceStatus.fromJson(
      Map<String, dynamic> json) {
    debugPrint('Parsing AttendanceStatus from JSON');
    return GroupMemberFollowUpRecordsAttendanceStatus(
      id: json["id"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
    );
  }

  Map<String, dynamic> toJson() {
    debugPrint('Converting AttendanceStatus to JSON');
    return {
      "id": id,
      "name_ar": nameAr,
      "name_en": nameEn,
    };
  }

  @override
  String toString() {
    return "$id, $nameAr, $nameEn, ";
  }
}

class GroupPlan {
  GroupPlan({
    required this.id,
    required this.groupId,
    required this.dayDate,
    required this.groupPlanStatusId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.contentToMemorizes,
    required this.contentToReviews,
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

  factory GroupPlan.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing GroupPlan from JSON');
    return GroupPlan(
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
    );
  }

  Map<String, dynamic> toJson() {
    debugPrint('Converting GroupPlan to JSON');
    return {
      "id": id,
      "groupId": groupId,
      "dayDate": dayDate?.toIso8601String(),
      "group_plan_status_id": groupPlanStatusId,
      "note": note,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "ContentToMemorizes": contentToMemorizes.map((x) => x.toJson()).toList(),
      "ContentToReviews": contentToReviews.map((x) => x.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return "$id, $groupId, $dayDate, $groupPlanStatusId, $note, $createdAt, $updatedAt, $contentToMemorizes, $contentToReviews, ";
  }
}

class GroupMemberFollowUpRecordsMetadata {
  GroupMemberFollowUpRecordsMetadata({
    required this.totalFollowUpRecords,
    required this.totalGroupPlans,
    required this.dayDateToUse,
    required this.navigation,
  });

  final int? totalFollowUpRecords;
  final int? totalGroupPlans;
  final dynamic dayDateToUse;
  final Navigation? navigation;

  factory GroupMemberFollowUpRecordsMetadata.fromJson(
      Map<String, dynamic> json) {
    debugPrint('Parsing GroupMemberFollowUpRecordsMetadata from JSON');
    return GroupMemberFollowUpRecordsMetadata(
      totalFollowUpRecords: json["totalFollowUpRecords"],
      totalGroupPlans: json["totalGroupPlans"],
      dayDateToUse: DateTime.tryParse(json["dayDateToUse"] ?? ""),
      navigation: json["navigation"] == null
          ? null
          : Navigation.fromJson(json["navigation"]),
    );
  }

  Map<String, dynamic> toJson() {
    debugPrint('Converting GroupMemberFollowUpRecordsMetadata to JSON');
    return {
      "totalFollowUpRecords": totalFollowUpRecords,
      "totalGroupPlans": totalGroupPlans,
      "dayDateToUse":
          "${dayDateToUse?.year.toString().padLeft(4, '0')}-${dayDateToUse?.month.toString().padLeft(2, '0')}-${dayDateToUse?.day.toString().padLeft(2, '0')}",
      "navigation": navigation?.toJson(),
    };
  }

  @override
  String toString() {
    return "$totalFollowUpRecords, $totalGroupPlans, $dayDateToUse, $navigation, ";
  }
}

class Navigation {
  Navigation({
    required this.previous,
    required this.next,
  });

  final dynamic previous;
  final dynamic next;

  factory Navigation.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing Navigation from JSON');
    debugPrint('Previous ---> : ${json["previous"]}');
    debugPrint('Next ---> : ${json["next"]}');

    debugPrint('Previous ---> : ${DateTime.tryParse(json["previous"] ?? "")}');
    debugPrint('Next ---> : ${DateTime.tryParse(json["next"] ?? "")}');

    return Navigation(
      previous: DateTime.tryParse(json["previous"] ?? ""),
      next: DateTime.tryParse(json["next"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    debugPrint('Converting Navigation to JSON');
    return {
      "previous":
          "${previous?.year.toString().padLeft(4, '0')}-${previous?.month.toString().padLeft(2, '0')}-${previous?.day.toString().padLeft(2, '0')}",
      "next": next,
    };
  }

  @override
  String toString() {
    return "$previous, $next, ";
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
    debugPrint('Parsing ContentToMemorize from JSON');
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

  Map<String, dynamic> toJson() {
    debugPrint('Converting ContentToMemorize to JSON');
    return {
      "id": id,
      "groupPlanId": groupPlanId,
      "surahId": surahId,
      "startAyah": startAyah,
      "endAyah": endAyah,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "Surah": surah?.toJson(),
    };
  }

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
    debugPrint('Parsing ContentToReview from JSON');
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

  Map<String, dynamic> toJson() {
    debugPrint('Converting ContentToReview to JSON');
    return {
      "id": id,
      "groupPlanId": groupPlanId,
      "surahId": surahId,
      "startAyah": startAyah,
      "endAyah": endAyah,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "Surah": surah?.toJson(),
    };
  }

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
