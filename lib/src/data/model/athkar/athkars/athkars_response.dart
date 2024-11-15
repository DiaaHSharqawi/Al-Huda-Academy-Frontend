import 'package:flutter/material.dart';

class AthkarResponse {
  AthkarResponse({
    this.responseMessage,
    required this.statusCode,
    required this.success,
    required this.message,
  });

  final bool? success;
  final Message? message;
  final int statusCode;
  final String? responseMessage;

  factory AthkarResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    debugPrint("+-+-+-+-+-+-+");
    debugPrint("AthkarResponse: $json");
    debugPrint("+-+-+-+-+-+-+");
    return AthkarResponse(
      statusCode: statusCode,
      success: json["success"],
      message: Message.fromJson(json["message"]),
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

class Message {
  Message({
    this.categoryId,
    this.category,
    this.athkars,
  });

  final String? categoryId;
  final String? category;
  final List<Athkar>? athkars;

  factory Message.fromJson(Map<String, dynamic> json) {
    debugPrint("+-+-+-+-+-+-+");
    debugPrint("Message: $json");
    debugPrint("+-+-+-+-+-+-+");
    return Message(
      categoryId: json["categoryId"],
      category: json["category"],
      athkars:
          List<Athkar>.from(json["athkars"].map((x) => Athkar.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "category": category,
        "athkars": athkars?.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$categoryId, $category, $athkars, ";
  }
}

class Athkar {
  Athkar({
    required this.id,
    required this.text,
    required this.count,
    required this.audio,
    required this.filename,
  });

  final int? id;
  final String? text;
  final int? count;
  final String? audio;
  final String? filename;

  factory Athkar.fromJson(Map<String, dynamic> json) {
    return Athkar(
      id: json["id"],
      text: json["text"],
      count: json["count"],
      audio: json["audio"],
      filename: json["filename"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "count": count,
        "audio": audio,
        "filename": filename,
      };

  @override
  String toString() {
    return "$id, $text, $count, $audio, $filename, ";
  }
}
