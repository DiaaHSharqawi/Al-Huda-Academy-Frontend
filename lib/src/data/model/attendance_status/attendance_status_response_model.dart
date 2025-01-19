class AttendanceStatusResponseModel {
  AttendanceStatusResponseModel({
    required this.success,
    required this.message,
    required this.attendanceStatus,
  });

  final bool? success;
  final String? message;
  final List<AttendanceStatus> attendanceStatus;

  factory AttendanceStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return AttendanceStatusResponseModel(
      success: json["success"],
      message: json["message"],
      attendanceStatus: json["attendanceStatus"] == null
          ? []
          : List<AttendanceStatus>.from(json["attendanceStatus"]!
              .map((x) => AttendanceStatus.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "attendanceStatus": attendanceStatus.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $attendanceStatus, ";
  }
}

class AttendanceStatus {
  AttendanceStatus({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  final int? id;
  final String? nameAr;
  final String? nameEn;

  factory AttendanceStatus.fromJson(Map<String, dynamic> json) {
    return AttendanceStatus(
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
