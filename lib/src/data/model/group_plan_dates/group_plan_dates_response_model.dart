class GroupPlanDatesResponseModel {
  GroupPlanDatesResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupPlanDates,
  });

  final bool? success;
  final String? message;
  final List<GroupPlanDate> groupPlanDates;
  final int statusCode;

  factory GroupPlanDatesResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupPlanDatesResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupPlanDates: json["groupPlanDates"] == null
          ? []
          : List<GroupPlanDate>.from(
              json["groupPlanDates"]!.map((x) => GroupPlanDate.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupPlanDates": groupPlanDates.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupPlanDates, ";
  }
}

class GroupPlanDate {
  GroupPlanDate({
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

  factory GroupPlanDate.fromJson(Map<String, dynamic> json) {
    return GroupPlanDate(
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
        "dayDate": dayDate != null
            ? "${dayDate?.year.toString().padLeft(4, '0')}-${dayDate?.month.toString().padLeft(2, '0')}-${dayDate?.day.toString().padLeft(2, '0')}"
            : null,
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
