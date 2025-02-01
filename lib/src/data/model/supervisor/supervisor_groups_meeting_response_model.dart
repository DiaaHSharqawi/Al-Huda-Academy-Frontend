class SupervisorGroupsMeetingResponseModel {
  SupervisorGroupsMeetingResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.supervisorGroups,
    required this.supervisorGroupsMetaData,
  });

  final bool? success;
  final String? message;
  final List<SupervisorGroup> supervisorGroups;
  final SupervisorGroupsMetaData? supervisorGroupsMetaData;
  final int statusCode;

  factory SupervisorGroupsMeetingResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SupervisorGroupsMeetingResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      supervisorGroups: json["supervisorGroups"] == null
          ? []
          : List<SupervisorGroup>.from(json["supervisorGroups"]!
              .map((x) => SupervisorGroup.fromJson(x))),
      supervisorGroupsMetaData: json["supervisorGroupsMetaData"] == null
          ? null
          : SupervisorGroupsMetaData.fromJson(json["supervisorGroupsMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "supervisorGroups": supervisorGroups.map((x) => x.toJson()).toList(),
        "supervisorGroupsMetaData": supervisorGroupsMetaData?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $supervisorGroups, $supervisorGroupsMetaData, ";
  }
}

class SupervisorGroup {
  SupervisorGroup({
    required this.id,
    required this.groupName,
    required this.groupDescription,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.groupStatusId,
    required this.groupGoalId,
    required this.genderId,
    required this.groupCompletionRateId,
    required this.teachingMethodId,
    required this.createdAt,
    required this.supervisorId,
    required this.days,
    required this.groupPlans,
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
  final int? groupCompletionRateId;
  final int? teachingMethodId;
  final DateTime? createdAt;
  final int? supervisorId;
  final List<Day> days;
  final List<GroupPlan> groupPlans;

  factory SupervisorGroup.fromJson(Map<String, dynamic> json) {
    return SupervisorGroup(
      id: json["id"],
      groupName: json["group_name"],
      groupDescription: json["group_description"],
      capacity: json["capacity"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      groupStatusId: json["group_status_id"],
      groupGoalId: json["group_goal_id"],
      genderId: json["gender_id"],
      groupCompletionRateId: json["group_completion_rate_id"],
      teachingMethodId: json["teaching_method_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      supervisorId: json["supervisor_id"],
      days: json["Days"] == null
          ? []
          : List<Day>.from(json["Days"]!.map((x) => Day.fromJson(x))),
      groupPlans: json["GroupPlans"] == null
          ? []
          : List<GroupPlan>.from(
              json["GroupPlans"]!.map((x) => GroupPlan.fromJson(x))),
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
        "group_completion_rate_id": groupCompletionRateId,
        "teaching_method_id": teachingMethodId,
        "createdAt": createdAt?.toIso8601String(),
        "supervisor_id": supervisorId,
        "Days": days.map((x) => x.toJson()).toList(),
        "GroupPlans": groupPlans.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatusId, $groupGoalId, $genderId, $groupCompletionRateId, $teachingMethodId, $createdAt, $supervisorId, $days, $groupPlans, ";
  }
}

class Day {
  Day({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.dayMemorizationGroup,
  });

  final int? id;
  final String? nameEn;
  final String? nameAr;
  final DayMemorizationGroup? dayMemorizationGroup;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
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

class GroupPlan {
  GroupPlan({
    required this.id,
    required this.groupId,
    required this.dayDate,
    required this.groupPlanStatusId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? groupId;
  final DateTime? dayDate;
  final int? groupPlanStatusId;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GroupPlan.fromJson(Map<String, dynamic> json) {
    return GroupPlan(
      id: json["id"],
      groupId: json["groupId"],
      dayDate: DateTime.tryParse(json["dayDate"] ?? ""),
      groupPlanStatusId: json["group_plan_status_id"],
      note: json["note"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
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
      };

  @override
  String toString() {
    return "$id, $groupId, $dayDate, $groupPlanStatusId, $note, $createdAt, $updatedAt, ";
  }
}

class SupervisorGroupsMetaData {
  SupervisorGroupsMetaData({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    this.limit,
  });

  final int? limit;
  final int? currentPage;
  final int? totalPages;
  final int? totalRecords;

  set totalPages(int? value) {
    totalPages = value;
  }

  set totalRecords(int? value) {
    totalRecords = value;
  }

  set currentPage(int? value) {
    currentPage = value;
  }

  set limit(int? value) {
    limit = value;
  }

  get getTotalPages => totalPages;
  get getTotalRecords => totalRecords;
  get getCurrentPage => currentPage;
  get getLimit => limit;

  factory SupervisorGroupsMetaData.fromJson(Map<String, dynamic> json) {
    return SupervisorGroupsMetaData(
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
