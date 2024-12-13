class UserInformation {
  String _id;
  String _email;
  String _fullName;
  Role _role;

  UserInformation(
      {required String email,
      required String fullName,
      required Role role,
      required String id})
      : _email = email,
        _fullName = fullName,
        _role = role,
        _id = id;

  Role get getRole => _role;
  set role(Role role) => _role = role;

  String get getEmail => _email;
  set email(String email) => _email = email;

  String get getFullName => _fullName;
  set fullName(String fullName) => _fullName = fullName;

  factory UserInformation.fromJson(Map<String, dynamic> json) {
    return UserInformation(
      id: json['id'].toString(),
      email: json['email'],
      fullName: json['fullName'],
      role: Role.fromJson(json['role']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'fullName': _fullName,
      'role': _role.toJson(),
      'email': _email,
    };
  }
}

class Role {
  late int _roleId;
  late String _roleName;

  int get getRoleId => _roleId;
  set roleId(int roleId) => _roleId = roleId;
  String get getRoleName => _roleName;
  set roleName(String roleName) => _roleName = roleName;

  Role({required int roleId, required String roleName})
      : _roleId = roleId,
        _roleName = roleName;

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['roleId'],
      roleName: json['roleName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': _roleId,
      'roleName': _roleName,
    };
  }
}
