class TeachingMethodsResponseModel {
  TeachingMethodsResponseModel({
    required this.success,
    required this.message,
    required this.teachingMethods,
  });

  final bool? success;
  final String? message;
  final List<TeachingMethod> teachingMethods;

  factory TeachingMethodsResponseModel.fromJson(Map<String, dynamic> json) {
    return TeachingMethodsResponseModel(
      success: json["success"],
      message: json["message"],
      teachingMethods: json["teachingMethods"] == null
          ? []
          : List<TeachingMethod>.from(
              json["teachingMethods"]!.map((x) => TeachingMethod.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "teachingMethods": teachingMethods.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $teachingMethods, ";
  }
}

class TeachingMethod {
  TeachingMethod({
    required this.id,
    required this.methodNameArabic,
    required this.methodNameEnglish,
    required this.descriptionArabic,
    required this.descriptionEnglish,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? methodNameArabic;
  final String? methodNameEnglish;
  final String? descriptionArabic;
  final String? descriptionEnglish;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TeachingMethod.fromJson(Map<String, dynamic> json) {
    return TeachingMethod(
      id: json["id"],
      methodNameArabic: json["methodNameArabic"],
      methodNameEnglish: json["methodNameEnglish"],
      descriptionArabic: json["descriptionArabic"],
      descriptionEnglish: json["descriptionEnglish"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "methodNameArabic": methodNameArabic,
        "methodNameEnglish": methodNameEnglish,
        "descriptionArabic": descriptionArabic,
        "descriptionEnglish": descriptionEnglish,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $methodNameArabic, $methodNameEnglish, $descriptionArabic, $descriptionEnglish, $isActive, $createdAt, $updatedAt, ";
  }
}
