class ResetPasswordResponse {
  final bool success;
  final String? message;
  final int? statusCode;

  ResetPasswordResponse({
    this.statusCode,
    required this.success,
    this.message,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      statusCode: json['statusCode'],
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
