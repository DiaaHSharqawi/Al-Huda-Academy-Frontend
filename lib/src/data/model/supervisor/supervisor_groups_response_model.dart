class SupervisorGroupsResponseModel {
  SupervisorGroupsResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.supervisorGroupsList,
    required this.supervisorGroupsMetaData,
  });

  final bool? success;
  final String? message;
  final List<SupervisorGroup> supervisorGroupsList;
  final SupervisorGroupsMetaData? supervisorGroupsMetaData;
  final int? statusCode;

  factory SupervisorGroupsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SupervisorGroupsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      supervisorGroupsList: json["supervisorGroups"] == null
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
        "supervisorGroups":
            supervisorGroupsList.map((x) => x.toJson()).toList(),
        "supervisorGroupsMetaData": supervisorGroupsMetaData?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $supervisorGroupsList, $supervisorGroupsMetaData, ";
  }
}

class SupervisorGroup {
  SupervisorGroup({
    required this.id,
    required this.groupName,
    required this.groupDescription,
  });

  final int? id;
  final String? groupName;
  final String? groupDescription;

  factory SupervisorGroup.fromJson(Map<String, dynamic> json) {
    return SupervisorGroup(
      id: json["id"],
      groupName: json["group_name"],
      groupDescription: json["group_description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "group_description": groupDescription,
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, ";
  }
}

class SupervisorGroupsMetaData {
  SupervisorGroupsMetaData({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
  });

  final int? currentPage;
  final int? totalPages;
  final int? totalRecords;

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
