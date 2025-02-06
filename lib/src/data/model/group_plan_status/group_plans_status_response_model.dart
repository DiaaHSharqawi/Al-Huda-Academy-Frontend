class GroupPlansStatusResponseModel {
  GroupPlansStatusResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupPlans,
  });

  final bool? success;
  final String? message;
  final List<GroupPlan> groupPlans;
  final int statusCode;

  factory GroupPlansStatusResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupPlansStatusResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupPlans: json["groupPlans"] == null
          ? []
          : List<GroupPlan>.from(
              json["groupPlans"]!.map((x) => GroupPlan.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupPlans": groupPlans.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupPlans, ";
  }
}

class GroupPlan {
  GroupPlan({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory GroupPlan.fromJson(Map<String, dynamic> json) {
    return GroupPlan(
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
