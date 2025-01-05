class RoleResponseModel {
  RoleResponseModel({
    required this.success,
    required this.message,
    required this.roles,
  });

  final bool? success;
  final String? message;
  final List<Role> roles;

  factory RoleResponseModel.fromJson(Map<String, dynamic> json) {
    return RoleResponseModel(
      success: json["success"],
      message: json["message"],
      roles: json["roles"] == null
          ? []
          : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "roles": roles.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $roles, ";
  }
}

class Role {
  Role({
    required this.id,
    required this.roleName,
    required this.roleNameAr,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? roleName;
  final String? roleNameAr;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json["id"],
      roleName: json["roleName"],
      roleNameAr: json["roleNameAr"],
      isActive: json["isActive"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "roleName": roleName,
        "roleNameAr": roleNameAr,
        "isActive": isActive,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };

  @override
  String toString() {
    return "$id, $roleName, $roleNameAr, $isActive, $createdAt, $updatedAt, ";
  }
}
