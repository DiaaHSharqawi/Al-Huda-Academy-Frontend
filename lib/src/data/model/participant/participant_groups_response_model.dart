class ParticipantGroupsResponseModel {
  ParticipantGroupsResponseModel({
    required this.statusCode,
    required this.message,
    required this.participantGroups,
    required this.participantGroupsMetaData,
  });

  final String? message;
  final List<ParticipantGroup> participantGroups;
  final ParticipantGroupsMetaData? participantGroupsMetaData;
  final int statusCode;

  factory ParticipantGroupsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return ParticipantGroupsResponseModel(
      statusCode: statusCode,
      message: json["message"],
      participantGroups: json["participantGroups"] == null
          ? []
          : List<ParticipantGroup>.from(json["participantGroups"]!
              .map((x) => ParticipantGroup.fromJson(x))),
      participantGroupsMetaData: json["participantGroupsMetaData"] == null
          ? null
          : ParticipantGroupsMetaData.fromJson(
              json["participantGroupsMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "participantGroups": participantGroups.map((x) => x.toJson()).toList(),
        "participantGroupsMetaData": participantGroupsMetaData?.toJson(),
      };

  @override
  String toString() {
    return "$message, $participantGroups, $participantGroupsMetaData, ";
  }
}

class ParticipantGroup {
  ParticipantGroup({
    required this.id,
    required this.groupId,
    required this.participantId,
    required this.createdAt,
    required this.updatedAt,
    required this.memorizationGroup,
  });

  final int? id;
  final int? groupId;
  final int? participantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final MemorizationGroup? memorizationGroup;

  factory ParticipantGroup.fromJson(Map<String, dynamic> json) {
    return ParticipantGroup(
      id: json["id"],
      groupId: json["group_id"],
      participantId: json["participant_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      memorizationGroup: json["MemorizationGroup"] == null
          ? null
          : MemorizationGroup.fromJson(json["MemorizationGroup"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "participant_id": participantId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "MemorizationGroup": memorizationGroup?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupId, $participantId, $createdAt, $updatedAt, $memorizationGroup, ";
  }
}

class MemorizationGroup {
  MemorizationGroup({
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

  factory MemorizationGroup.fromJson(Map<String, dynamic> json) {
    return MemorizationGroup(
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
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatusId, $groupGoalId, $genderId, $groupCompletionRateId, $teachingMethodId, $createdAt, $supervisorId, ";
  }
}

class ParticipantGroupsMetaData {
  ParticipantGroupsMetaData({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalRecords;

  factory ParticipantGroupsMetaData.fromJson(Map<String, dynamic> json) {
    return ParticipantGroupsMetaData(
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
