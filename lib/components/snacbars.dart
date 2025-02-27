import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessSnackbar extends GetxController {
  void showSuccessSnackbar() {
    Get.snackbar(
      "Success",
      "Swagat Hai Champion! 🎉",
      snackPosition: SnackPosition.TOP,
      boxShadows: [BoxShadow(color: Color(0xFF56BB41), blurRadius: 8)],
      colorText: Colors.white,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 3),
        borderRadius: 20,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
      overlayBlur: 4,
      icon: Icon(Icons.check_circle, color: Colors.white, size: 30),
      shouldIconPulse: true,
      );
  }
}

class ErrorSnackbar extends GetxController {
  void showSuccessSnackbar() {
    Get.snackbar(
      "Error",
      'Check kr Kya Galat Kiya hai 🥲',
      snackPosition: SnackPosition.TOP,
      boxShadows: [BoxShadow(color: Color(0xFFE84E4E), blurRadius: 8)],
      colorText: Colors.white,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      duration: Duration(seconds: 3),
      borderRadius: 20,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(15),
      overlayBlur: 4,
      icon: Icon(Icons.error, color: Colors.white, size: 30),
      shouldIconPulse: true,
    );
  }
}
