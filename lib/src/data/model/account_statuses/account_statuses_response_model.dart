class AccountStatusesResponseModel {
  AccountStatusesResponseModel({
    required this.success,
    required this.message,
    required this.accountStatuses,
  });

  final bool? success;
  final String? message;
  final List<AccountStatus> accountStatuses;

  factory AccountStatusesResponseModel.fromJson(Map<String, dynamic> json) {
    return AccountStatusesResponseModel(
      success: json["success"],
      message: json["message"],
      accountStatuses: json["accountStatuses"] == null
          ? []
          : List<AccountStatus>.from(
              json["accountStatuses"]!.map((x) => AccountStatus.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "accountStatuses": accountStatuses.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $accountStatuses, ";
  }
}

class AccountStatus {
  AccountStatus({
    required this.id,
    required this.englishName,
    required this.arabicName,
  });

  final int? id;
  final String? englishName;
  final String? arabicName;

  factory AccountStatus.fromJson(Map<String, dynamic> json) {
    return AccountStatus(
      id: json["id"],
      englishName: json["englishName"],
      arabicName: json["arabicName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "englishName": englishName,
        "arabicName": arabicName,
      };

  @override
  String toString() {
    return "$id, $englishName, $arabicName, ";
  }
}
