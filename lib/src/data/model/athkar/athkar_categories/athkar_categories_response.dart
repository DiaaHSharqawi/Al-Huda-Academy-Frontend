import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkar_categories/athkar_categories_meta_data.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkar_categories/athkar_categories_response_message.dart';

class AthkarCategoriesResponse {
  int statusCode;
  bool? success;
  AthkarCategoriesResponseMessage? message;
  String? responseMessage;
  AthkarCategoriesMetaData? metaData;

  AthkarCategoriesResponse(
      {this.success,
      this.message,
      this.responseMessage,
      required this.statusCode,
      this.metaData});

  AthkarCategoriesResponse.fromJson(
      Map<String, dynamic> json, this.statusCode) {
    //  debugPrint("AthkarCategoriesResponse.fromJson: $json");
    // debugPrint("type of : ${json['message'].runtimeType})");
    success = json['success'];
    if (json['message'] != null) {
      if (json['message'] is String) {
        responseMessage = json['message'];
      } else if (json['message'] is Map<String, dynamic>) {
        debugPrint(
            "from jsonnnnnn AthkarCategoriesResponse.fromJson: ${json['message']}");
        message = AthkarCategoriesResponseMessage.fromJson(
            json['message'] as Map<String, dynamic>);
      }
    }
    if (json['metaData'] != null) {
      debugPrint("AthkarCategoriesResponse.fromJson: ${json['metaData']}");
      metaData = AthkarCategoriesMetaData.fromJson(json['metaData']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (message != null) {
      data['message'] = message!.toJson();
    } else if (responseMessage != null) {
      data['message'] = responseMessage;
    }
    if (metaData != null) {
      data['metaData'] = metaData!.toJson();
    }
    return data;
  }
}
