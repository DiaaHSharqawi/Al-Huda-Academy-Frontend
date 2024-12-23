class JuzaResponse {
  JuzaResponse({
    required this.success,
    required this.message,
    required this.juzas,
  });

  final bool? success;
  final String? message;
  final List<Juza> juzas;

  factory JuzaResponse.fromJson(Map<String, dynamic> json) {
    return JuzaResponse(
      success: json["success"],
      message: json["message"],
      juzas: json["juzas"] == null
          ? []
          : List<Juza>.from(json["juzas"]!.map((x) => Juza.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "Juzas": juzas.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $juzas, ";
  }
}

class Juza {
  Juza({
    required this.id,
    required this.arabicPart,
    required this.englishPart,
  });

  final int? id;
  final String? arabicPart;
  final String? englishPart;

  factory Juza.fromJson(Map<String, dynamic> json) {
    return Juza(
      id: json["id"],
      arabicPart: json["arabic_part"],
      englishPart: json["english_part"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "arabic_part": arabicPart,
        "english_part": englishPart,
      };

  @override
  String toString() {
    return "$id, $arabicPart, $englishPart, ";
  }
}
