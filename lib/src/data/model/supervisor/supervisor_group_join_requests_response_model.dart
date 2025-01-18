class SupervisorGroupJoinRequestsResponseModel {
  SupervisorGroupJoinRequestsResponseModel({
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupJoinRequests,
    required this.groupJoinRequestsMetaData,
  });

  final bool? success;
  final String? message;
  final List<SupervisorGroupJoinRequest> groupJoinRequests;
  final int statusCode;
  final GroupJoinRequestsMetaData? groupJoinRequestsMetaData;

  factory SupervisorGroupJoinRequestsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return SupervisorGroupJoinRequestsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupJoinRequests: json["groupJoinRequests"] == null
          ? []
          : List<SupervisorGroupJoinRequest>.from(
              json["groupJoinRequests"]!
                  .map((x) => SupervisorGroupJoinRequest.fromJson(x)),
            ),
      groupJoinRequestsMetaData: json["groupJoinRequestsMetaData"] == null
          ? null
          : GroupJoinRequestsMetaData.fromJson(
              json["groupJoinRequestsMetaData"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupJoinRequests": groupJoinRequests.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupJoinRequests, ";
  }
}

class SupervisorGroupJoinRequest {
  SupervisorGroupJoinRequest({
    required this.id,
    required this.groupId,
    required this.participantId,
    required this.joinRequestStatusId,
    required this.responseMessage,
    required this.createdAt,
    required this.updatedAt,
    required this.participant,
  });

  final int? id;
  final int? groupId;
  final int? participantId;
  final int? joinRequestStatusId;
  final String? responseMessage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SupervisorGroupJoinRequestParticipant? participant;

  factory SupervisorGroupJoinRequest.fromJson(Map<String, dynamic> json) {
    return SupervisorGroupJoinRequest(
      id: json["id"],
      groupId: json["group_id"],
      participantId: json["participant_id"],
      joinRequestStatusId: json["join_request_status_id"],
      responseMessage: json["responseMessage"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      participant: json["Participant"] == null
          ? null
          : SupervisorGroupJoinRequestParticipant.fromJson(json["Participant"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "participant_id": participantId,
        "join_request_status_id": joinRequestStatusId,
        "responseMessage": responseMessage,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Participant": participant?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupId, $participantId, $joinRequestStatusId, $responseMessage, $createdAt, $updatedAt, $participant, ";
  }
}

class SupervisorGroupJoinRequestParticipant {
  SupervisorGroupJoinRequestParticipant({
    required this.fullName,
    required this.profileImage,
    required this.quranMemorizingAmount,
    required this.dateOfBirth,
  });

  final String? fullName;
  final String? profileImage;
  final QuranMemorizingAmount? quranMemorizingAmount;
  final DateTime? dateOfBirth;

  factory SupervisorGroupJoinRequestParticipant.fromJson(
      Map<String, dynamic> json) {
    return SupervisorGroupJoinRequestParticipant(
      fullName: json["fullName"],
      profileImage: json["profileImage"],
      quranMemorizingAmount: json["QuranMemorizingAmount"] == null
          ? null
          : QuranMemorizingAmount.fromJson(json["QuranMemorizingAmount"]),
      dateOfBirth: DateTime.tryParse(json["dateOfBirth"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "profileImage": profileImage,
      };

  @override
  String toString() {
    return "$fullName, $profileImage, ";
  }
}

class QuranMemorizingAmount {
  QuranMemorizingAmount({
    required this.id,
    required this.amountArabic,
    required this.amountEnglish,
  });

  final int? id;
  final String? amountArabic;
  final String? amountEnglish;

  factory QuranMemorizingAmount.fromJson(Map<String, dynamic> json) {
    return QuranMemorizingAmount(
      id: json["id"],
      amountArabic: json["amountArabic"],
      amountEnglish: json["amountEnglish"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "amountArabic": amountArabic,
        "amountEnglish": amountEnglish,
      };

  @override
  String toString() {
    return "$id, $amountArabic, $amountEnglish, ";
  }
}

class GroupJoinRequestsMetaData {
  GroupJoinRequestsMetaData({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
  });

  final int currentPage;
  final int totalPages;
  final int totalRecords;

  factory GroupJoinRequestsMetaData.fromJson(Map<String, dynamic> json) {
    return GroupJoinRequestsMetaData(
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      totalRecords: json["totalRecords"],
    );
  }

  Map<String, dynamic> toJson() => {
        "currentPage": currentPage,
        "totalPages": totalPages,
        "totalRecords": totalRecords,
      };

  @override
  String toString() {
    return "$currentPage, $totalPages, $totalRecords";
  }
}
