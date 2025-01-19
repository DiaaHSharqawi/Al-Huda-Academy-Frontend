class GroupPlanResponseModel {
  GroupPlanResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupPlan,
    required this.groupPlanMetaData,
  });

  final bool? success;
  final String? message;
  final List<GroupPlan> groupPlan;
  final GroupPlanMetaData? groupPlanMetaData;
  final int? statusCode;

  factory GroupPlanResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupPlanResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupPlan: json["groupPlan"] == null
          ? []
          : List<GroupPlan>.from(
              json["groupPlan"]!.map((x) => GroupPlan.fromJson(x))),
      groupPlanMetaData: json["groupPlanMetaData"] == null
          ? null
          : GroupPlanMetaData.fromJson(json["groupPlanMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupPlan": groupPlan.map((x) => x.toJson()).toList(),
        "groupPlanMetaData": groupPlanMetaData?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $groupPlan, $groupPlanMetaData, ";
  }
}

class GroupPlan {
  GroupPlan({
    required this.id,
    required this.groupId,
    required this.weekNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final int? groupId;
  final int? weekNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory GroupPlan.fromJson(Map<String, dynamic> json) {
    return GroupPlan(
      id: json["id"],
      groupId: json["groupId"],
      weekNumber: json["weekNumber"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "groupId": groupId,
        "weekNumber": weekNumber,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $groupId, $weekNumber, $createdAt, $updatedAt, ";
  }
}

class GroupPlanMetaData {
  GroupPlanMetaData({
    required this.totalNumberOfGroupPlan,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  final int? totalNumberOfGroupPlan;
  final int? totalPages;
  final int? page;
  final int? limit;

  factory GroupPlanMetaData.fromJson(Map<String, dynamic> json) {
    return GroupPlanMetaData(
      totalNumberOfGroupPlan: json["totalNumberOfGroupPlan"],
      totalPages: json["totalPages"],
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalNumberOfGroupPlan": totalNumberOfGroupPlan,
        "totalPages": totalPages,
        "page": page,
        "limit": limit,
      };

  @override
  String toString() {
    return "$totalNumberOfGroupPlan, $totalPages, $page, $limit, ";
  }
}
