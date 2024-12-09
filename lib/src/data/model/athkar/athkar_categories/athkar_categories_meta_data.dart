import 'package:flutter/material.dart';

class AthkarCategoriesMetaData {
  int totalAthkarsCategories;
  int totalPages;
  int currentPage;
  int limit;

  AthkarCategoriesMetaData({
    required this.totalAthkarsCategories,
    required this.totalPages,
    required this.currentPage,
    required this.limit,
  });

  factory AthkarCategoriesMetaData.fromJson(Map<String, dynamic> json) {
    debugPrint(
        "\n---------------->>>> AthkarCategoriesMetaData.fromJson: $json");
    return AthkarCategoriesMetaData(
      totalAthkarsCategories: json['totalAthkarsCategories'],
      totalPages: json['totalPages'],
      currentPage: (json['page']),
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAthkarsCategories': totalAthkarsCategories,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'limit': limit,
    };
  }
}
