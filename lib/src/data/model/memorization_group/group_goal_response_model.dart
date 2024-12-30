class GroupGoalResponseModel {
  GroupGoalResponseModel({
    required this.success,
    required this.message,
    required this.groupGoals,
  });

  final bool? success;
  final String? message;
  final List<GroupGoal> groupGoals;

  factory GroupGoalResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupGoalResponseModel(
      success: json["success"],
      message: json["message"],
      groupGoals: json["groupGoals"] == null
          ? []
          : List<GroupGoal>.from(
              json["groupGoals"]!.map((x) => GroupGoal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupGoals": groupGoals.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupGoals, ";
  }
}

class GroupGoal {
  GroupGoal({
    required this.id,
    required this.groupGoalAr,
    required this.groupGoalEng,
  });

  final int? id;
  final String? groupGoalAr;
  final String? groupGoalEng;

  factory GroupGoal.fromJson(Map<String, dynamic> json) {
    return GroupGoal(
      id: json["id"],
      groupGoalAr: json["group_goal_ar"],
      groupGoalEng: json["group_goal_eng"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_goal_ar": groupGoalAr,
        "group_goal_eng": groupGoalEng,
      };

  @override
  String toString() {
    return "$id, $groupGoalAr, $groupGoalEng, ";
  }
}
