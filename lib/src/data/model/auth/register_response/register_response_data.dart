class RegisterResponseData {
  RegisterResponseData({
    required this.accessToken,
    required this.refreshToken,
  });

  final String? accessToken;
  final String? refreshToken;

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) {
    return RegisterResponseData(
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
