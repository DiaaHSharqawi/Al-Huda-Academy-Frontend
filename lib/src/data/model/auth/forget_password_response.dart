class ForgetPasswordResponse {
  final String? message;
  final bool? success;
  final int statusCode;

  ForgetPasswordResponse({
    required this.statusCode,
    this.message,
    this.success,
  });
}
