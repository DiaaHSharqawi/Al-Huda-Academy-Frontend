class GroupDashboardResponseModel {
  GroupDashboardResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupDashboard,
  });

  final bool? success;
  final String? message;
  final GroupDashboard? groupDashboard;
  final int statusCode;

  factory GroupDashboardResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupDashboardResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupDashboard: json["groupDashboard"] == null
          ? null
          : GroupDashboard.fromJson(json["groupDashboard"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupDashboard": groupDashboard?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $groupDashboard, ";
  }
}

class GroupDashboard {
  GroupDashboard({
    required this.groupPlans,
    required this.groupDetailsDashboard,
    required this.groupJoinRequestsDashboard,
  });

  final GroupDetailsDashboard? groupDetailsDashboard;
  final List<GroupJoinRequestsDashboard> groupJoinRequestsDashboard;
  final GroupPlansDashboard? groupPlans;

  factory GroupDashboard.fromJson(Map<String, dynamic> json) {
    return GroupDashboard(
      groupPlans: json["groupPlans"] == null
          ? null
          : GroupPlansDashboard.fromJson(json["groupPlans"]),
      groupDetailsDashboard: json["groupDetailsDashboard"] == null
          ? null
          : GroupDetailsDashboard.fromJson(json["groupDetailsDashboard"]),
      groupJoinRequestsDashboard: json["groupJoinRequestsDashboard"] == null
          ? []
          : List<GroupJoinRequestsDashboard>.from(
              json["groupJoinRequestsDashboard"]!
                  .map((x) => GroupJoinRequestsDashboard.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "groupDetailsDashboard": groupDetailsDashboard?.toJson(),
        "groupJoinRequestsDashboard":
            groupJoinRequestsDashboard.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$groupDetailsDashboard, $groupJoinRequestsDashboard, ";
  }
}

class GroupDetailsDashboard {
  GroupDetailsDashboard({
    required this.id,
    required this.groupName,
    required this.groupDescription,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.groupStatusId,
    required this.groupGoalId,
    required this.genderId,
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
  final int? teachingMethodId;
  final DateTime? createdAt;
  final int? supervisorId;

  factory GroupDetailsDashboard.fromJson(Map<String, dynamic> json) {
    return GroupDetailsDashboard(
      id: json["id"],
      groupName: json["group_name"],
      groupDescription: json["group_description"],
      capacity: json["capacity"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      groupStatusId: json["group_status_id"],
      groupGoalId: json["group_goal_id"],
      genderId: json["gender_id"],
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
        "teaching_method_id": teachingMethodId,
        "createdAt": createdAt?.toIso8601String(),
        "supervisor_id": supervisorId,
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatusId, $groupGoalId, $genderId, $teachingMethodId, $createdAt, $supervisorId, ";
  }
}

class GroupPlansDashboard {
  GroupPlansDashboard({
    required this.id,
    required this.groupId,
    required this.dayDate,
    required this.groupPlanStatusId,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.groupPlanStatus,
  });

  final int? id;
  final int? groupId;
  final DateTime? dayDate;
  final int? groupPlanStatusId;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final GroupPlanStatusDashboard? groupPlanStatus;

  factory GroupPlansDashboard.fromJson(Map<String, dynamic> json) {
    return GroupPlansDashboard(
      id: json["id"],
      groupId: json["groupId"],
      dayDate: DateTime.tryParse(json["dayDate"] ?? ""),
      groupPlanStatusId: json["group_plan_status_id"],
      note: json["note"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      groupPlanStatus: json["GroupPlanStatus"] == null
          ? null
          : GroupPlanStatusDashboard.fromJson(json["GroupPlanStatus"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "dayDate": dayDate != null
            ? "${dayDate?.year.toString().padLeft(4, '0')}-${dayDate?.month.toString().padLeft(2, '0')}-${dayDate?.day.toString().padLeft(2, '0')}"
            : null,
        "group_plan_status_id": groupPlanStatusId,
        "note": note,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "GroupPlanStatus": groupPlanStatus?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupId, $dayDate, $groupPlanStatusId, $note, $createdAt, $updatedAt, $groupPlanStatus, ";
  }
}

class GroupPlanStatusDashboard {
  GroupPlanStatusDashboard({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory GroupPlanStatusDashboard.fromJson(Map<String, dynamic> json) {
    return GroupPlanStatusDashboard(
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

class GroupJoinRequestsDashboard {
  GroupJoinRequestsDashboard({
    required this.id,
    required this.groupId,
    required this.participantId,
    required this.joinRequestStatusId,
    required this.responseMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.participant,
  });

  final int? id;
  final int? groupId;
  final int? participantId;
  final int? joinRequestStatusId;
  final String? responseMessage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ParticipantJoinRequestsDashboard? participant;

  factory GroupJoinRequestsDashboard.fromJson(Map<String, dynamic> json) {
    return GroupJoinRequestsDashboard(
      id: json["id"],
      groupId: json["group_id"],
      participantId: json["participant_id"],
      joinRequestStatusId: json["join_request_status_id"],
      responseMessage: json["responseMessage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      participant: json["Participant"] == null
          ? null
          : ParticipantJoinRequestsDashboard.fromJson(json["Participant"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "participant_id": participantId,
        "join_request_status_id": joinRequestStatusId,
        "responseMessage": responseMessage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Participant": participant?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupId, $participantId, $joinRequestStatusId, $responseMessage, $createdAt, $updatedAt, $participant, ";
  }
}

class ParticipantJoinRequestsDashboard {
  ParticipantJoinRequestsDashboard({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  final int? id;
  final String? fullName;
  final String? profileImage;

  factory ParticipantJoinRequestsDashboard.fromJson(Map<String, dynamic> json) {
    return ParticipantJoinRequestsDashboard(
      id: json["id"],
      fullName: json["fullName"],
      profileImage: json["profileImage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "profileImage": profileImage,
      };

  @override
  String toString() {
    return "$id, $fullName, $profileImage, ";
  }
}
