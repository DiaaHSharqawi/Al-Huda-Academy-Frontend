import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CustomToast {
  final Toastification toastification;

  CustomToast(this.toastification);

  void show(String title, String description, ToastificationType type) {
    toastification.show(
      type: type,
      style: ToastificationStyle.flatColored,
      title: Text(title),
      description: Text(description),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      animationBuilder: (context, animation, alignment, child) {
        return ScaleTransition(scale: animation, child: child);
      },
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      dragToClose: true,
      showProgressBar: false,
    );
  }
}
