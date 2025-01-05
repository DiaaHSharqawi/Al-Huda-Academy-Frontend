class QuranMemorizingAmountResponseModel {
  QuranMemorizingAmountResponseModel({
    required this.success,
    required this.message,
    required this.quranMemorizingAmount,
  });

  final bool? success;
  final String? message;
  final List<QuranMemorizingAmount> quranMemorizingAmount;

  factory QuranMemorizingAmountResponseModel.fromJson(
      Map<String, dynamic> json) {
    return QuranMemorizingAmountResponseModel(
      success: json["success"],
      message: json["message"],
      quranMemorizingAmount: json["quranMemorizingAmount"] == null
          ? []
          : List<QuranMemorizingAmount>.from(json["quranMemorizingAmount"]!
              .map((x) => QuranMemorizingAmount.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "quranMemorizingAmount":
            quranMemorizingAmount.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$success, $message, $quranMemorizingAmount, ";
  }
}

class QuranMemorizingAmount {
  QuranMemorizingAmount({
    required this.id,
    required this.amountArabic,
    required this.amountEnglish,
  });

  final int? id;
  final String? amountArabic;
  final String? amountEnglish;

  factory QuranMemorizingAmount.fromJson(Map<String, dynamic> json) {
    return QuranMemorizingAmount(
      id: json["id"],
      amountArabic: json["amountArabic"],
      amountEnglish: json["amountEnglish"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "amountArabic": amountArabic,
        "amountEnglish": amountEnglish,
      };

  @override
  String toString() {
    return "$id, $amountArabic, $amountEnglish, ";
  }
}
