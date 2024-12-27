class LanguagesResponseModel {
  LanguagesResponseModel({
    required this.success,
    required this.message,
    required this.languages,
  });

  final bool? success;
  final String? message;
  final List<Language> languages;

  factory LanguagesResponseModel.fromJson(Map<String, dynamic> json) {
    return LanguagesResponseModel(
      success: json["success"],
      message: json["message"],
      languages: json["languages"] == null
          ? []
          : List<Language>.from(
              json["languages"]!.map((x) => Language.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "languages": languages.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $languages, ";
  }
}

class Language {
  Language({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json["id"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $nameAr, $nameEn, $createdAt, $updatedAt, ";
  }
}
