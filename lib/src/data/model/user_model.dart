class UserModel {
  String id;
  String email;
  String password;
  String fullName;
  DateTime birthdate;
  String phone;
  String city;
  String country;
  String gender;
  String role;
  dynamic profileImage;

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.birthdate,
    required this.phone,
    required this.city,
    required this.country,
    required this.gender,
    required this.role,
    this.profileImage,
  });

  // Factory method to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      password: json['password'],
      fullName: json['fullName'],
      birthdate: DateTime.parse(json['birthdate']),
      phone: json['phone'],
      city: json['city'],
      country: json['country'],
      gender: json['gender'],
      role: json['role'],
      profileImage: json['profileImage'],
    );
  }

  // Method to convert a User object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'password': password,
      'fullName': fullName,
      'birthdate': birthdate.toIso8601String(),
      'phone': phone,
      'city': city,
      'country': country,
      'gender': gender,
      'role': role,
      'profileImage': profileImage,
    };
  }
}
