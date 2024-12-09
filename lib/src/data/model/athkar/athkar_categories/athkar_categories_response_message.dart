import 'package:moltqa_al_quran_frontend/src/data/model/athkar/athkar_categories/athkar_categories.dart';

class AthkarCategoriesResponseMessage {
  List<AthkarCategories>? athkars;

  AthkarCategoriesResponseMessage({this.athkars});

  AthkarCategoriesResponseMessage.fromJson(Map<String, dynamic> json) {
    if (json['athkars'] != null) {
      athkars = <AthkarCategories>[];
      json['athkars'].forEach((v) {
        athkars!.add(AthkarCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (athkars != null) {
      data['athkars'] = athkars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
