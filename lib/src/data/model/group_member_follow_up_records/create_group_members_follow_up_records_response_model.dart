class CreateGroupMembersFollowUpRecordsResponseModel {
  CreateGroupMembersFollowUpRecordsResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;
  final int statusCode;

  factory CreateGroupMembersFollowUpRecordsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return CreateGroupMembersFollowUpRecordsResponseModel(
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
