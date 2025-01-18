class GroupMembersResponseModel {
  GroupMembersResponseModel({
    required this.groupMembersMetaData,
    required this.statusCode,
    required this.success,
    required this.message,
    required this.groupMembers,
  });

  final bool? success;
  final String? message;
  final List<GroupMember> groupMembers;
  final int statusCode;
  final GroupMembersMetaData? groupMembersMetaData;

  factory GroupMembersResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GroupMembersResponseModel(
      groupMembersMetaData: json["groupMembersMetaData"] == null
          ? null
          : GroupMembersMetaData.fromJson(json["groupMembersMetaData"]),
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      groupMembers: json["groupMembers"] == null
          ? []
          : List<GroupMember>.from(
              json["groupMembers"]!.map(
                (x) => GroupMember.fromJson(x),
              ),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groupMembership": groupMembers.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $groupMembers, ";
  }
}

class GroupMember {
  GroupMember({
    required this.id,
    required this.groupId,
    required this.participantId,
    required this.createdAt,
    required this.updatedAt,
    required this.participant,
  });

  final int? id;
  final int? groupId;
  final int? participantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Participant? participant;

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      id: json["id"],
      groupId: json["group_id"],
      participantId: json["participant_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      participant: json["Participant"] == null
          ? null
          : Participant.fromJson(json["Participant"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_id": groupId,
        "participant_id": participantId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "Participant": participant?.toJson(),
      };

  @override
  String toString() {
    return "$id, $groupId, $participantId, $createdAt, $updatedAt, $participant, ";
  }
}

class Participant {
  Participant({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  final int? id;
  final String? fullName;
  final String? profileImage;

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json["id"],
      fullName: json["fullName"],
      profileImage: json["profileImage"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
        "profileImage": profileImage,
      };

  @override
  String toString() {
    return "$id, $fullName, $profileImage, ";
  }
}

class GroupMembersMetaData {
  GroupMembersMetaData({
    required this.totalNumberOfRecords,
    required this.totalPages,
    required this.page,
    required this.limit,
  });

  final int? totalNumberOfRecords;
  final int? totalPages;
  final int? page;
  final int? limit;

  factory GroupMembersMetaData.fromJson(Map<String, dynamic> json) {
    return GroupMembersMetaData(
      totalNumberOfRecords: json["totalNumberOfRecords"],
      totalPages: json["totalPages"],
      page: json["page"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalNumberOfRecords": totalNumberOfRecords,
        "totalPages": totalPages,
        "page": page,
        "limit": limit,
      };

  @override
  String toString() {
    return "$totalNumberOfRecords, $totalPages, $page, $limit, ";
  }
}
