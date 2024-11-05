import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/user_model.dart';

class RegisterResponse {
  bool? success;
  String? message;
  UserModel? user;
  String? accessToken;
  String? refreshToken;
  int? statusCode;

  RegisterResponse({
    this.success = false,
    this.message = '',
    this.user,
    this.accessToken,
    this.refreshToken,
    this.statusCode,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    debugPrint("RegisterResponse from json");
    debugPrint(json.toString());
    return RegisterResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      user: json['data'] != null && json['data']['user'] is Map<String, dynamic>
          ? UserModel.fromJson(json['data']['user'])
          : null,
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      statusCode: json['statusCode'],
    );
  }
}
