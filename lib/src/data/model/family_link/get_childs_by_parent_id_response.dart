class GetChildsByUserIdResponse {
  GetChildsByUserIdResponse({
    required this.success,
    required this.message,
    required this.familyLink,
    required this.statusCode,
  });

  final bool? success;
  final String? message;
  final FamilyLink? familyLink;
  final int statusCode;

  factory GetChildsByUserIdResponse.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return GetChildsByUserIdResponse(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      familyLink: json["FamilyLink"] == null
          ? null
          : FamilyLink.fromJson(json["FamilyLink"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "FamilyLink": familyLink?.toJson(),
      };

  @override
  String toString() {
    return "$success, $message, $familyLink, ";
  }
}

class FamilyLink {
  FamilyLink({
    required this.id,
    required this.parentId,
    required this.children,
  });

  final String? id;
  final String? parentId;
  final List<Child> children;

  factory FamilyLink.fromJson(Map<String, dynamic> json) {
    return FamilyLink(
      id: json["_id"],
      parentId: json["parentId"],
      children: json["children"] == null
          ? []
          : List<Child>.from(json["children"]!.map((x) => Child.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "parentId": parentId,
        "children": children.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$id, $parentId, $children, ";
  }
}

class Child {
  Child({
    required this.childId,
    required this.id,
    required this.linkedAt,
  });

  final ChildId? childId;
  final String? id;
  final DateTime? linkedAt;

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      childId:
          json["childId"] == null ? null : ChildId.fromJson(json["childId"]),
      id: json["_id"],
      linkedAt: DateTime.tryParse(json["linkedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "childId": childId?.toJson(),
        "_id": id,
        "linkedAt": linkedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$childId, $id, $linkedAt, ";
  }
}

class ChildId {
  ChildId({
    required this.id,
    required this.email,
    required this.fullName,
  });

  final String? id;
  final String? email;
  final String? fullName;

  factory ChildId.fromJson(Map<String, dynamic> json) {
    return ChildId(
      id: json["_id"],
      email: json["email"],
      fullName: json["fullName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "fullName": fullName,
      };

  @override
  String toString() {
    return "$id, $email, $fullName, ";
  }
}
