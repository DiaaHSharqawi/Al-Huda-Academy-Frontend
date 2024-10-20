import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:get/get.dart';

class AppTranslation extends Translations {
  static Map<String, Map<String, String>> translations = {};

  static Future<void> loadTranslations() async {
    try {
      String jsonContent = await rootBundle.loadString(
          'assets/translation.json'); // Updated path to match your asset declaration
      debugPrint("Raw JSON Content: $jsonContent"); // Debugging output

      Map<String, dynamic> jsonMap = jsonDecode(jsonContent);
      translations['en'] = _extractTranslations(jsonMap, 'en');
      translations['ar'] = _extractTranslations(jsonMap, 'ar');

      debugPrint('Loaded Translations (EN): ${translations['en']}');
      debugPrint('Loaded Translations (AR): ${translations['ar']}');
    } catch (e) {
      debugPrint("Error loading translations: $e");
    }
  }

  static Map<String, String> _extractTranslations(
      Map<String, dynamic> json, String lang) {
    Map<String, String> langMap = {};

    json.forEach((key, value) {
      if (value is Map) {
        value.forEach((subKey, subValue) {
          if (subValue is Map && subValue.containsKey(lang)) {
            // Create a key in the format 'parent_key.child_key'
            langMap['$key.$subKey'] = subValue[lang];
          }
        });
      }
    });

    return langMap;
  }

  @override
  Map<String, Map<String, String>> get keys => translations;
}
