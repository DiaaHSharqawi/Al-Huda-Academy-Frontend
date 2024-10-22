class UserModel {
  final String? id;
  final String? profileImage;
  final String? userName;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? birthdate;
  final String? phone;
  final String? city;
  final String? country;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.profileImage,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.phone,
    required this.city,
    required this.country,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      profileImage: (json['profileImage']?['secure_url']) as String? ?? '',
      userName: json['userName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      birthdate: json['birthdate'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      city: json['city'] as String? ?? '',
      country: json['country'] as String? ?? '',
      role: json['role'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }
}
