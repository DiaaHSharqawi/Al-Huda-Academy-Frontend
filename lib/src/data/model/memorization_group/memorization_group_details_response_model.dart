class MemorizationGroupDetailsResponseModel {
  MemorizationGroupDetailsResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.memorizationGroup,
  });

  final bool? success;
  final String? message;
  final MemorizationGroupDetails? memorizationGroup;
  final int statusCode;

  factory MemorizationGroupDetailsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return MemorizationGroupDetailsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      memorizationGroup: json["memorizationGroup"] == null
          ? null
          : MemorizationGroupDetails.fromJson(json["memorizationGroup"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "memorizationGroup": memorizationGroup?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $memorizationGroup, ";
  }
}

class MemorizationGroupDetails {
  MemorizationGroupDetails({
    required this.id,
    required this.groupName,
    required this.groupDescription,
    required this.capacity,
    required this.startTime,
    required this.endTime,
    required this.groupStatus,
    required this.groupGoal,
    required this.days,
    required this.participantsGender,
    required this.participantsLevel,
    required this.supervisorLanguages,
    required this.createdAt,
    required this.supervisorId,
    required this.teachingMethodId,
    required this.teachingMethod,
    required this.surahs,
    required this.juzas,
    required this.extracts,
    required this.supervisor,
  });

  final int? id;
  final String? groupName;
  final String? groupDescription;
  final int? capacity;
  final String? startTime;
  final String? endTime;
  final String? groupStatus;
  final String? groupGoal;
  final List<String> days;
  final String? participantsGender;
  final String? participantsLevel;
  final List<String> supervisorLanguages;
  final DateTime? createdAt;
  final int? supervisorId;
  final int? teachingMethodId;
  final TeachingMethod? teachingMethod;
  final List<Surah> surahs;
  final List<Juza> juzas;
  final List<Extract> extracts;
  final Supervisor? supervisor;

  factory MemorizationGroupDetails.fromJson(Map<String, dynamic> json) {
    return MemorizationGroupDetails(
      id: json["id"],
      supervisor: json["Supervisor"] == null
          ? null
          : Supervisor.fromJson(json["Supervisor"]),
      groupName: json["group_name"],
      groupDescription: json["group_description"],
      capacity: json["capacity"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      groupStatus: json["group_status"],
      groupGoal: json["group_goal"],
      days: json["days"] == null
          ? []
          : List<String>.from(json["days"]!.map((x) => x)),
      participantsGender: json["participants_gender"],
      participantsLevel: json["participants_level"],
      supervisorLanguages: json["supervisor_languages"] == null
          ? []
          : List<String>.from(json["supervisor_languages"]!.map((x) => x)),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      supervisorId: json["supervisor_id"],
      teachingMethodId: json["teaching_method_id"],
      teachingMethod: json["TeachingMethod"] == null
          ? null
          : TeachingMethod.fromJson(json["TeachingMethod"]),
      surahs: json["surahs"] == null
          ? []
          : List<Surah>.from(json["surahs"]!.map((x) => Surah.fromJson(x))),
      juzas: json["juzas"] == null
          ? []
          : List<Juza>.from(json["juzas"]!.map((x) => Juza.fromJson(x))),
      extracts: json["extracts"] == null
          ? []
          : List<Extract>.from(
              json["extracts"]!.map((x) => Extract.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupName,
        "group_description": groupDescription,
        "capacity": capacity,
        "start_time": startTime,
        "end_time": endTime,
        "group_status": groupStatus,
        "group_goal": groupGoal,
        "days": days.map((x) => x).toList(),
        "participants_gender": participantsGender,
        "participants_level": participantsLevel,
        "supervisor_languages": supervisorLanguages.map((x) => x).toList(),
        "createdAt": createdAt?.toIso8601String(),
        "supervisor_id": supervisorId,
        "teaching_method_id": teachingMethodId,
        "TeachingMethod": teachingMethod?.toJson(),
        "surahs": surahs.map((x) => x).toList(),
        "juzas": juzas.map((x) => x).toList(),
        "extracts": extracts.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $groupName, $groupDescription, $capacity, $startTime, $endTime, $groupStatus, $groupGoal, $days, $participantsGender, $participantsLevel, $supervisorLanguages, $createdAt, $supervisorId, $teachingMethodId, $teachingMethod, $surahs, $juzas, $extracts, ";
  }
}

class Surah {
  Surah({
    required this.id,
    required this.name,
    required this.englishName,
  });

  final int? id;
  final String? name;
  final String? englishName;

  factory Surah.fromJson(Map<String, dynamic> json) {
    return Surah(
      id: json["id"],
      name: json["name"],
      englishName: json["englishName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "englishName": englishName,
      };

  @override
  String toString() {
    return "$id, $name, $englishName, ";
  }
}

class Extract {
  Extract({
    required this.ayat,
    required this.surahId,
    required this.surahName,
    required this.surahEnglishName,
  });

  final String ayat;
  final int? surahId;
  final String? surahName;
  final String? surahEnglishName;

  factory Extract.fromJson(Map<String, dynamic> json) {
    return Extract(
      ayat: json["ayat"],
      surahId: json["surahId"],
      surahName: json["surahName"],
      surahEnglishName: json["surahEnglishName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ayat": ayat,
        "surahId": surahId,
        "surahName": surahName,
        "surahEnglishName": surahEnglishName,
      };

  @override
  String toString() {
    return "$ayat, $surahId, $surahName, $surahEnglishName, ";
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

class TeachingMethod {
  TeachingMethod({
    required this.id,
    required this.methodNameArabic,
    required this.methodNameEnglish,
  });

  final int? id;
  final String? methodNameArabic;
  final String? methodNameEnglish;

  factory TeachingMethod.fromJson(Map<String, dynamic> json) {
    return TeachingMethod(
      id: json["id"],
      methodNameArabic: json["methodNameArabic"],
      methodNameEnglish: json["methodNameEnglish"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "methodNameArabic": methodNameArabic,
        "methodNameEnglish": methodNameEnglish,
      };

  @override
  String toString() {
    return "$id, $methodNameArabic, $methodNameEnglish, ";
  }
}

class Supervisor {
  Supervisor({
    required this.id,
    required this.fullName,
  });

  final int? id;
  final String? fullName;

  factory Supervisor.fromJson(Map<String, dynamic> json) {
    return Supervisor(
      id: json["id"],
      fullName: json["fullName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
      };

  @override
  String toString() {
    return "$id, $fullName, ";
  }
}
