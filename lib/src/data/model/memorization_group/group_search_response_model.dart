class GroupSearchResponseModel {
  GroupSearchResponseModel({
    required this.success,
    required this.message,
    required this.groupSearchModels,
    required this.metaData,
    required this.statusCode,
  });

  final bool? success;
  final String? message;
  final List<GroupSearchModel> groupSearchModels;
  final MetaData? metaData;
  final int? statusCode;

  factory GroupSearchResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupSearchResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupSearchModels: json["memorizationGroups"] == null
          ? []
          : List<GroupSearchModel>.from(json["memorizationGroups"]!
              .map((x) => GroupSearchModel.fromJson(x))),
      metaData:
          json["metaData"] == null ? null : MetaData.fromJson(json["metaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "memorizationGroups": groupSearchModels.map((x) => x.toJson()).toList(),
        "metaData": metaData?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $groupSearchModels, $metaData, ";
  }
}

class GroupSearchModel {
  GroupSearchModel({
    required this.id,
    required this.groupName,
    required this.groupDescription,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.groupStatusId,
    required this.groupGoalId,
    required this.genderId,
    required this.createdAt,
    required this.supervisorId,
    required this.teachingMethodId,
    required this.gender,
    required this.days,
    required this.groupStatus,
    required this.groupGoal,
    required this.languages,
    required this.quranMemorizingAmount,
    required this.groupCompletionRateId,
    required this.recommendedFlag,
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
  final DateTime? createdAt;
  final int? supervisorId;
  final int? teachingMethodId;
  final GroupSearchResponseGender? gender;
  final List<GroupSearchResponseDay> days;
  final GroupSearchResponseStatus? groupStatus;
  final GroupSearchResponseGoal? groupGoal;
  final List<GroupSearchResponseLanguage> languages;
  final QuranMemorizingAmount? quranMemorizingAmount;
  final int? groupCompletionRateId;
  final int? recommendedFlag;

  factory GroupSearchModel.fromJson(Map<String, dynamic> json) {
    return GroupSearchModel(
      id: json["id"],
      groupName: json["group_name"],
      groupDescription: json["group_description"],
      capacity: json["capacity"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      groupStatusId: json["group_status_id"],
      groupGoalId: json["group_goal_id"],
      genderId: json["gender_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      groupCompletionRateId: json["group_completion_rate_id"],
      supervisorId: json["supervisor_id"],
      teachingMethodId: json["teaching_method_id"],
      recommendedFlag: json["recommended_flag"],
      quranMemorizingAmount: json["QuranMemorizingAmount"] == null
          ? null
          : QuranMemorizingAmount.fromJson(json["QuranMemorizingAmount"]),
      gender: json["Gender"] == null
          ? null
          : GroupSearchResponseGender.fromJson(json["Gender"]),
      days: json["Days"] == null
          ? []
          : List<GroupSearchResponseDay>.from(
              json["Days"]!.map((x) => GroupSearchResponseDay.fromJson(x))),
      groupStatus: json["GroupStatus"] == null
          ? null
          : GroupSearchResponseStatus.fromJson(json["GroupStatus"]),
      groupGoal: json["GroupGoal"] == null
          ? null
          : GroupSearchResponseGoal.fromJson(json["GroupGoal"]),
      languages: json["Languages"] == null
          ? []
          : List<GroupSearchResponseLanguage>.from(json["Languages"]!
              .map((x) => GroupSearchResponseLanguage.fromJson(x))),
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
        "createdAt": createdAt?.toIso8601String(),
        "supervisor_id": supervisorId,
        "teaching_method_id": teachingMethodId,
        "Gender": gender?.toJson(),
        "Days": days.map((x) => x.toJson()).toList(),
        "GroupStatus": groupStatus?.toJson(),
        "GroupGoal": groupGoal?.toJson(),
        "Languages": languages.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatusId, $groupGoalId, $genderId, $createdAt, $supervisorId, $teachingMethodId, $gender, $days, $groupStatus, $groupGoal, $languages, ";
  }
}

class QuranMemorizingAmount {
  QuranMemorizingAmount({
    required this.id,
    required this.amountArabic,
    required this.amountEnglish,
  });

  final int? id;
  final String? amountArabic;
  final String? amountEnglish;

  factory QuranMemorizingAmount.fromJson(Map<String, dynamic> json) {
    return QuranMemorizingAmount(
      id: json["id"],
      amountArabic: json["amountArabic"],
      amountEnglish: json["amountEnglish"],
    );
  }
}

class GroupSearchResponseGender {
  GroupSearchResponseGender({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory GroupSearchResponseGender.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponseGender(
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

class GroupSearchResponseDay {
  GroupSearchResponseDay({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory GroupSearchResponseDay.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponseDay(
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

class GroupSearchResponseGoal {
  GroupSearchResponseGoal({
    required this.id,
    required this.groupGoalAr,
    required this.groupGoalEng,
    //  required this.createdAt,
    //  required this.updatedAt,
  });

  final int? id;
  final String? groupGoalAr;
  final String? groupGoalEng;
  // final DateTime? createdAt;
  //final DateTime? updatedAt;

  factory GroupSearchResponseGoal.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponseGoal(
      id: json["id"],
      groupGoalAr: json["group_goal_ar"],
      groupGoalEng: json["group_goal_eng"],
      // createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      // updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_goal_ar": groupGoalAr,
        "group_goal_eng": groupGoalEng,
        //"createdAt": createdAt?.toIso8601String(),
        //  "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $groupGoalAr, $groupGoalEng, ";
  }
}

class GroupSearchResponseStatus {
  GroupSearchResponseStatus({
    required this.id,
    required this.statusNameAr,
    required this.statusNameEn,
  });

  final int? id;
  final String? statusNameAr;
  final String? statusNameEn;

  factory GroupSearchResponseStatus.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponseStatus(
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

class GroupSearchResponseLanguage {
  GroupSearchResponseLanguage({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GroupSearchResponseLanguage.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponseLanguage(
      id: json["id"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $nameAr, $nameEn, $createdAt, $updatedAt, ";
  }
}

class MetaData {
  MetaData({
    required this.totalNumberOfMemorizationGroup,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  final int? totalNumberOfMemorizationGroup;
  final int? totalPages;
  final int? page;
  final int? limit;

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      totalNumberOfMemorizationGroup: json["totalNumberOfMemorizationGroup"],
      totalPages: json["totalPages"],
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalNumberOfMemorizationGroup": totalNumberOfMemorizationGroup,
        "totalPages": totalPages,
        "page": page,
        "limit": limit,
      };

  @override
  String toString() {
    return "$totalNumberOfMemorizationGroup, $totalPages, $page, $limit, ";
  }
}
