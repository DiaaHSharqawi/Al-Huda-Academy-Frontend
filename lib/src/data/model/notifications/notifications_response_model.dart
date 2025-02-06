class NotificationsResponseModel {
  NotificationsResponseModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.meta,
    required this.userNotifications,
  });

  final bool? success;
  final String? message;
  final Meta? meta;
  final List<UserNotification> userNotifications;
  final int statusCode;

  factory NotificationsResponseModel.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return NotificationsResponseModel(
      statusCode: statusCode,
      success: json["success"],
      message: json["message"],
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userNotifications: json["userNotifications"] == null
          ? []
          : List<UserNotification>.from(json["userNotifications"]!
              .map((x) => UserNotification.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "meta": meta?.toJson(),
        "userNotifications": userNotifications.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $meta, $userNotifications, ";
  }
}

class Meta {
  Meta({
    required this.totalPages,
    required this.page,
    required this.limit,
    required this.totalRecords,
  });

  final int? totalPages;
  final int? page;
  final int? limit;
  final int? totalRecords;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      totalPages: json["totalPages"],
      page: json["page"],
      limit: json["limit"],
      totalRecords: json["totalRecords"],
    );
  }

  Map<String, dynamic> toJson() => {
        "totalPages": totalPages,
        "page": page,
        "limit": limit,
        "totalRecords": totalRecords,
      };

  @override
  String toString() {
    return "$totalPages, $page, $limit, $totalRecords, ";
  }
}

class UserNotification {
  UserNotification({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.isRead,
    this.message,
  });

  final int? id;
  final String? title;
  final DateTime? createdAt;
  final bool? isRead;
  final String? message;

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      id: json["id"],
      title: json["title"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      isRead: json["isRead"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "createdAt": createdAt?.toIso8601String(),
        "isRead": isRead,
        "message": message,
      };

  @override
  String toString() {
    return "$id, $title, $createdAt, $isRead, ";
  }
}
