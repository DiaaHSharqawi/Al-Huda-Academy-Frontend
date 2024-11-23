class SendChildVerificationCodeFamilyLinkResponse {
  SendChildVerificationCodeFamilyLinkResponse({
    required this.statusCode,
    required this.success,
    required this.message,
  });

  final bool? success;
  final String? message;
  final int statusCode;

  factory SendChildVerificationCodeFamilyLinkResponse.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SendChildVerificationCodeFamilyLinkResponse(
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
