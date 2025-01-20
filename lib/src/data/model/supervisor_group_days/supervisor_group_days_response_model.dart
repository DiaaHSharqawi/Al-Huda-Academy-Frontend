class SupervisorGroupDaysResponseModel {
  SupervisorGroupDaysResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.supervisorGroupDays,
  });

  final bool? success;
  final String? message;
  final List<SupervisorGroupDay> supervisorGroupDays;
  final int statusCode;

  factory SupervisorGroupDaysResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SupervisorGroupDaysResponseModel(
      success: json["success"],
      statusCode: statusCode,
      message: json["message"],
      supervisorGroupDays: json["supervisorGroupDays"] == null
          ? []
          : List<SupervisorGroupDay>.from(json["supervisorGroupDays"]!
              .map((x) => SupervisorGroupDay.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "supervisorGroupDays":
            supervisorGroupDays.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $supervisorGroupDays, ";
  }
}

class SupervisorGroupDay {
  SupervisorGroupDay({
    required this.id,
    required this.dayId,
    required this.groupId,
  });

  final int? id;
  final int? dayId;
  final int? groupId;

  factory SupervisorGroupDay.fromJson(Map<String, dynamic> json) {
    return SupervisorGroupDay(
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
