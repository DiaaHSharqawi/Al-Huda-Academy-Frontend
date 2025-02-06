class GroupContentResponseModel {
  GroupContentResponseModel({
    required this.success,
    required this.message,
    required this.groupContent,
  });

  final bool? success;
  final String? message;
  final List<GroupContent> groupContent;

  factory GroupContentResponseModel.fromJson(Map<String, dynamic> json) {
    return GroupContentResponseModel(
      success: json["success"],
      message: json["message"],
      groupContent: json["groupContent"] == null
          ? []
          : List<GroupContent>.from(
              json["groupContent"]!.map((x) => GroupContent.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupContent": groupContent.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupContent, ";
  }
}

class GroupContent {
  GroupContent({
    required this.id,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    required this.startAyah,
    required this.endAyah,
  });

  final int? id;
  final String? name;
  final String? englishName;
  final String? englishNameTranslation;
  final int? numberOfAyahs;
  final String? revelationType;
  final int? startAyah;
  final int? endAyah;

  factory GroupContent.fromJson(Map<String, dynamic> json) {
    return GroupContent(
      id: json["id"],
      name: json["name"],
      englishName: json["englishName"],
      englishNameTranslation: json["englishNameTranslation"],
      numberOfAyahs: json["numberOfAyahs"],
      revelationType: json["revelationType"],
      startAyah: json["start_ayah"],
      endAyah: json["end_ayah"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationType,
        "start_ayah": startAyah,
        "end_ayah": endAyah,
      };

  @override
  String toString() {
    return "$id, $name, $englishName, $englishNameTranslation, $numberOfAyahs, $revelationType, $startAyah, $endAyah, ";
  }
}
