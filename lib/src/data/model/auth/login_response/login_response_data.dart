class LoginResponseData {
  LoginResponseData({
    required this.accessToken,
    required this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };

  @override
  String toString() {
    return "$accessToken, $refreshToken, ";
  }
}
