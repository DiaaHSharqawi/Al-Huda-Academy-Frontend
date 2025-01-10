class GroupStatusResponseModel {
  GroupStatusResponseModel({
    required this.success,
    required this.message,
    required this.groupStatus,
  });

  final bool? success;
  final String? message;
  final List<GroupStatus> groupStatus;

  factory GroupStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupStatusResponseModel(
      success: json["success"],
      message: json["message"],
      groupStatus: json["groupStatus"] == null
          ? []
          : List<GroupStatus>.from(
              json["groupStatus"]!.map((x) => GroupStatus.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupStatus": groupStatus.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupStatus, ";
  }
}

class GroupStatus {
  GroupStatus({
    required this.id,
    required this.statusNameAr,
    required this.statusNameEn,
  });

  final int? id;
  final String? statusNameAr;
  final String? statusNameEn;

  factory GroupStatus.fromJson(Map<String, dynamic> json) {
    return GroupStatus(
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
