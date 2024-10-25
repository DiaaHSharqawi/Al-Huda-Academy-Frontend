class UserModel {
  String email;
  String password;
  String fullName;
  String phone;
  String city;
  String country;
  String age;
  String gender;
  String role;
  dynamic profileImage;

  UserModel({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phone,
    required this.city,
    required this.country,
    required this.gender,
    required this.role,
    required this.age,
    this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? 's',
      password: json['password'] ?? '',
      fullName: json['fullName'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      age: json['age'].toString(),
      profileImage: json['profileImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
      'phone': phone,
      'city': city,
      'country': country,
      'gender': gender,
      'role': role,
      'profileImage': profileImage,
      'age': age
    };
  }

  @override
  String toString() {
    return 'UserModel {'
        ' email: $email,'
        ' fullName: $fullName,'
        ' age: $age,'
        ' phone: $phone,'
        ' city: $city,'
        ' country: $country,'
        ' gender: $gender,'
        ' role: $role,'
        ' profileImage: $profileImage'
        ' }';
  }
}
