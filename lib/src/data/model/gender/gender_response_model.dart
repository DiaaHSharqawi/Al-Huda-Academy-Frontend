class GenderResponseModel {
  GenderResponseModel({
    required this.success,
    required this.message,
    required this.genders,
  });

  final bool? success;
  final String? message;
  final List<Gender> genders;

  factory GenderResponseModel.fromJson(Map<String, dynamic> json) {
    return GenderResponseModel(
      success: json["success"],
      message: json["message"],
      genders: json["genders"] == null
          ? []
          : List<Gender>.from(json["genders"]!.map((x) => Gender.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "genders": genders.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $genders, ";
  }
}

class Gender {
  Gender({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory Gender.fromJson(Map<String, dynamic> json) {
    return Gender(
      id: json["id"],
      nameAr: json["name_ar"],
      nameEn: json["name_en"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
      };

  @override
  String toString() {
    return "$id, $nameAr, $nameEn, ";
  }
}
