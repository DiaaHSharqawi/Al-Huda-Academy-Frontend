class ParticipantLevelResponseModel {
  ParticipantLevelResponseModel({
    required this.success,
    required this.message,
    required this.participantLevels,
  });

  final bool? success;
  final String? message;
  final List<ParticipantLevel> participantLevels;

  factory ParticipantLevelResponseModel.fromJson(Map<String, dynamic> json) {
    return ParticipantLevelResponseModel(
      success: json["success"],
      message: json["message"],
      participantLevels: json["participantLevels"] == null
          ? []
          : List<ParticipantLevel>.from(json["participantLevels"]!
              .map((x) => ParticipantLevel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "participantLevels": participantLevels.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $participantLevels, ";
  }
}

class ParticipantLevel {
  ParticipantLevel({
    required this.id,
    required this.participantLevelEn,
    required this.participantLevelAr,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? participantLevelEn;
  final String? participantLevelAr;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory ParticipantLevel.fromJson(Map<String, dynamic> json) {
    return ParticipantLevel(
      id: json["id"],
      participantLevelEn: json["participant_level_en"],
      participantLevelAr: json["participant_level_ar"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "participant_level_en": participantLevelEn,
        "participant_level_ar": participantLevelAr,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $participantLevelEn, $participantLevelAr, $createdAt, $updatedAt, ";
  }
}
