class EditGroupPlanDetailsResponseModel {
  EditGroupPlanDetailsResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;
  final int statusCode;

  factory EditGroupPlanDetailsResponseModel.fromJson(
    Map<String, dynamic> json,
    int statusCode,
  ) {
    return EditGroupPlanDetailsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };

  @override
  String toString() {
    return "$success, $message, ";
  }
}
