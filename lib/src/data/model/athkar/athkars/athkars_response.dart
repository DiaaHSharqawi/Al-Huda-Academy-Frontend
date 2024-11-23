import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkars/athkar_response_message.dart';

class AthkarResponse {
  AthkarResponse({
    this.responseMessage,
    required this.statusCode,
    required this.success,
    required this.message,
  });

  final bool? success;
  final AthkarResponseMessage? message;
  final int statusCode;
  final String? responseMessage;

  factory AthkarResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    debugPrint("+-+-+-+-+-+-+");
    debugPrint("AthkarResponse: $json");
    debugPrint("+-+-+-+-+-+-+");
    return AthkarResponse(
      statusCode: statusCode,
      success: json["success"],
      message: AthkarResponseMessage.fromJson(json["message"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, ";
  }
}
