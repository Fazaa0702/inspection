import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackbar {
  static failedSnackbar(String title, String message) {
    Get.closeAllSnackbars();
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  static successSnackbar(String title, String message) {
    // Get.closeAllSnackbars();
    return Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }
}
