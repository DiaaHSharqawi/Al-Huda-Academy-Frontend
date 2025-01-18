class AdminRequestsForCreatingGroupsResponseModel {
  AdminRequestsForCreatingGroupsResponseModel({
    required this.success,
    required this.requestsForCreatingGroupsModels,
    required this.metaData,
    required this.statusCode,
  });

  final bool? success;
  final List<RequestsForCreatingGroup> requestsForCreatingGroupsModels;
  final AdminRequestsForCreatingGroupsMetaData? metaData;
  final int? statusCode;

  factory AdminRequestsForCreatingGroupsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return AdminRequestsForCreatingGroupsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      requestsForCreatingGroupsModels: json["requestsForCreatingGroups"] == null
          ? []
          : List<RequestsForCreatingGroup>.from(
              json["requestsForCreatingGroups"]!
                  .map((x) => RequestsForCreatingGroup.fromJson(x))),
      metaData: json["metaData"] == null
          ? null
          : AdminRequestsForCreatingGroupsMetaData.fromJson(json["metaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "requestsForCreatingGroups":
            requestsForCreatingGroupsModels.map((x) => x.toJson()).toList(),
        "metaData": metaData?.toJson(),
      };

  @override
  String toString() {
    return "$success, $requestsForCreatingGroupsModels, $metaData, ";
  }
}

class AdminRequestsForCreatingGroupsMetaData {
  AdminRequestsForCreatingGroupsMetaData({
    required this.totalNumberOfRequestsForCreatingGroups,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  final int? totalNumberOfRequestsForCreatingGroups;
  final int? totalPages;
  final int? page;
  final int? limit;

  factory AdminRequestsForCreatingGroupsMetaData.fromJson(
      Map<String, dynamic> json) {
    return AdminRequestsForCreatingGroupsMetaData(
      totalNumberOfRequestsForCreatingGroups:
          json["totalNumberOfRequestsForCreatingGroups"],
      totalPages: json["totalPages"],
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalNumberOfRequestsForCreatingGroups":
            totalNumberOfRequestsForCreatingGroups,
        "totalPages": totalPages,
        "page": page,
        "limit": limit,
      };

  @override
  String toString() {
    return "$totalNumberOfRequestsForCreatingGroups, $totalPages, $page, $limit, ";
  }
}

class RequestsForCreatingGroup {
  RequestsForCreatingGroup({
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
    required this.supervisor,
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
  final AdminRequestsForCreatingGroupsSupervisorDetails? supervisor;

  factory RequestsForCreatingGroup.fromJson(Map<String, dynamic> json) {
    return RequestsForCreatingGroup(
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
      supervisor: json["Supervisor"] == null
          ? null
          : AdminRequestsForCreatingGroupsSupervisorDetails.fromJson(
              json["Supervisor"]),
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
        "Supervisor": supervisor?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatusId, $groupGoalId, $genderId, $teachingMethodId, $createdAt, $supervisorId, $supervisor, ";
  }
}

class AdminRequestsForCreatingGroupsSupervisorDetails {
  AdminRequestsForCreatingGroupsSupervisorDetails({
    required this.id,
    required this.fullName,
    required this.dateOfBirth,
    required this.phone,
    required this.city,
    required this.country,
    required this.genderId,
    required this.numberOfMemorizedParts,
    required this.numberOfMemorizedSurahs,
    required this.details,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  final int? id;
  final String? fullName;
  final DateTime? dateOfBirth;
  final String? phone;
  final String? city;
  final String? country;
  final int? genderId;
  final int? numberOfMemorizedParts;
  final int? numberOfMemorizedSurahs;
  final String? details;
  final String? profileImage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? userId;

  factory AdminRequestsForCreatingGroupsSupervisorDetails.fromJson(
      Map<String, dynamic> json) {
    return AdminRequestsForCreatingGroupsSupervisorDetails(
      id: json["id"],
      fullName: json["fullName"],
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
      phone: json["phone"],
      city: json["city"],
      country: json["country"],
      genderId: json["gender_id"],
      numberOfMemorizedParts: json["numberOfMemorizedParts"],
      numberOfMemorizedSurahs: json["numberOfMemorizedSurahs"],
      details: json["details"],
      profileImage: json["profileImage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      userId: json["userId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "dateOfBirth": dateOfBirth?.toIso8601String(),
        "phone": phone,
        "city": city,
        "country": country,
        "gender_id": genderId,
        "numberOfMemorizedParts": numberOfMemorizedParts,
        "numberOfMemorizedSurahs": numberOfMemorizedSurahs,
        "details": details,
        "profileImage": profileImage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
      };

  @override
  String toString() {
    return "$id, $fullName, $dateOfBirth, $phone, $city, $country, $genderId, $numberOfMemorizedParts, $numberOfMemorizedSurahs, $details, $profileImage, $createdAt, $updatedAt, $userId, ";
  }
}
