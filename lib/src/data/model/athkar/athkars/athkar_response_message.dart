import 'package:flutter/material.dart';
import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkars/athkar.dart';

class AthkarResponseMessage {
  AthkarResponseMessage({
    this.categoryId,
    this.category,
    this.athkars,
  });

  final String? categoryId;
  final String? category;
  final List<Athkar>? athkars;

  factory AthkarResponseMessage.fromJson(Map<String, dynamic> json) {
    debugPrint("+-+-+-+-+-+-+");
    debugPrint("Message: $json");
    debugPrint("+-+-+-+-+-+-+");
    return AthkarResponseMessage(
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
