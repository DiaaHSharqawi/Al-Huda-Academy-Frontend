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
  final GroupSearchResponseMetaData? metaData;
  final int statusCode;

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
      metaData: json["metaData"] == null
          ? null
          : GroupSearchResponseMetaData.fromJson(json["metaData"]),
    );
  }

  get firstOrNull => null;

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
    required this.groupGoal,
    required this.participantsGender,
    required this.participantsLevel,
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  final int? id;
  final String? groupName;
  final String? groupGoal;
  final String? participantsGender;
  final String? participantsLevel;
  final List<String> days;
  final String? startTime;
  final String? endTime;

  factory GroupSearchModel.fromJson(Map<String, dynamic> json) {
    return GroupSearchModel(
      id: json["id"],
      groupName: json["group_name"],
      groupGoal: json["group_goal"],
      participantsGender: json["participants_gender"],
      participantsLevel: json["participants_level"],
      days: json["days"] == null
          ? []
          : List<String>.from(json["days"]!.map((x) => x)),
      startTime: json["start_time"],
      endTime: json["end_time"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "group_goal": groupGoal,
        "participants_gender": participantsGender,
        "participants_level": participantsLevel,
        "days": days.map((x) => x).toList(),
        "start_time": startTime,
        "end_time": endTime,
      };

  @override
  String toString() {
    return "$id, $groupName, $groupGoal, $participantsGender, $participantsLevel, $days, $startTime, $endTime, ";
  }
}

class GroupSearchResponseMetaData {
  GroupSearchResponseMetaData({
    required this.totalNumberOfMemorizationGroup,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  final int? totalNumberOfMemorizationGroup;
  final int? totalPages;
  final int? page;
  final int? limit;

  factory GroupSearchResponseMetaData.fromJson(Map<String, dynamic> json) {
    return GroupSearchResponseMetaData(
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
