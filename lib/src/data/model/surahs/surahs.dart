class SurahResponse {
  SurahResponse({
    required this.success,
    required this.message,
    required this.surahs,
  });

  final bool? success;
  final String? message;
  final List<Surah> surahs;

  factory SurahResponse.fromJson(Map<String, dynamic> json) {
    return SurahResponse(
      success: json["success"],
      message: json["message"],
      surahs: json["surahs"] == null
          ? []
          : List<Surah>.from(json["surahs"]!.map((x) => Surah.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "surahs": surahs.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $surahs, ";
  }
}

class Surah {
  Surah({
    required this.id,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  final int? id;
  final String? name;
  final String? englishName;
  final String? englishNameTranslation;
  final int? numberOfAyahs;
  final String? revelationType;

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json["id"],
      name: json["name"],
      englishName: json["englishName"],
      englishNameTranslation: json["englishNameTranslation"],
      numberOfAyahs: json["numberOfAyahs"],
      revelationType: json["revelationType"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationType,
      };

  @override
  String toString() {
    return "$id, $name, $englishName, $englishNameTranslation, $numberOfAyahs, $revelationType, ";
  }
}
