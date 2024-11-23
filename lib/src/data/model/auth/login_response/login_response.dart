import 'package:moltqa_al_quran_frontend/src/data/model/auth/login_response/login_response_data.dart';

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.data,
    this.statusCode,
  });

  final bool? success;
  final String? message;
  final LoginResponseData? data;
  final int? statusCode;

  factory LoginResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return LoginResponse(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : LoginResponseData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $data, ";
  }
}
