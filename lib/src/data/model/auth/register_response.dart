import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class RegisterResponse {
  final bool success;
  final String message;
  final UserModel? data;

  RegisterResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    debugPrint("RegisterResponse from json");
    debugPrint(json.toString());
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null && json['data']['user'] is Map<String, dynamic>
          ? UserModel.fromJson(json['data']['user'])
          : null,
    );
  }
}
