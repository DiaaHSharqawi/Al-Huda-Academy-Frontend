import 'package:moltqa_al_quran_frontend/src/data/model/auth/register_response/register_response_data.dart';

class RegisterResponse {
  RegisterResponse({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.data,
  });
  final int statusCode;
  final bool? success;
  final String? message;
  final RegisterResponseData? data;

  factory RegisterResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return RegisterResponse(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : RegisterResponseData.fromJson(json["data"]),
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
