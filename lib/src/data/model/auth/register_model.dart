import 'dart:typed_data';

class RegisterModel {
  String fullName;
  String email;
  String password;
  String phone;
  String city;
  String country;
  String gender;
  Uint8List? profileImage;
  String age;

  RegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
    required this.city,
    required this.country,
    required this.gender,
    required this.age,
    this.profileImage,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      city: json['city'],
      country: json['country'],
      gender: json['gender'],
      age: json['age'],
      profileImage: json['profileImage'] != null
          ? Uint8List.fromList(json['profileImage'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'city': city,
      'country': country,
      'gender': gender,
      'age': age,
      'profileImage': profileImage?.toList(),
    };
  }
}
