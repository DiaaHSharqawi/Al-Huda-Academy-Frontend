import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  static Future<Uint8List?> pickImage(ImageSource source) async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: source);

      if (file != null) {
        return await file.readAsBytes();
      }
      debugPrint("No image selected");
      return null;
    } catch (e) {
      debugPrint("Error picking image: $e");
      return null;
    }
  }
}
