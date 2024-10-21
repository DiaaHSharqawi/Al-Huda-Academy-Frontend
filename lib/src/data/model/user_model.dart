class UserModel {
  final String id;
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String profileImage;
  final String accessToken;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
    required this.accessToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImage: json['profileImage']['secure_url'],
      accessToken: json['accessToken'],
    );
  }
}
