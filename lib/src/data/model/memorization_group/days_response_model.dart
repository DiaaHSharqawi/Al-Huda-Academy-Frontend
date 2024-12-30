class DaysResponseModel {
  DaysResponseModel({
    required this.success,
    required this.message,
    required this.days,
  });

  final bool? success;
  final String? message;
  final List<Day> days;

  factory DaysResponseModel.fromJson(Map<String, dynamic> json) {
    return DaysResponseModel(
      success: json["success"],
      message: json["message"],
      days: json["days"] == null
          ? []
          : List<Day>.from(json["days"]!.map((x) => Day.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "days": days.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $days, ";
  }
}

class Day {
  Day({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });

  final int? id;
  final String? nameEn;
  final String? nameAr;

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      id: json["id"],
      nameEn: json["name_en"],
      nameAr: json["name_ar"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_en": nameEn,
        "name_ar": nameAr,
      };

  @override
  String toString() {
    return "$id, $nameEn, $nameAr, ";
  }
}
