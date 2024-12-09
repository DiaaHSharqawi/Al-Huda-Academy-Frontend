class AthkarCategories {
  String? athkarCategotyId;
  String? category;

  AthkarCategories({this.athkarCategotyId, this.category});

  AthkarCategories.fromJson(Map<String, dynamic> json) {
    athkarCategotyId = json['_id'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = athkarCategotyId;
    data['category'] = category;
    return data;
  }
}
