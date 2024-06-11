import 'package:einspection/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnlockAccountController extends GetxController {
  var usernameController = TextEditingController();
  var username = '';
  var authService = AuthService();
  var isLoading = true.obs;

  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }

  void unlockAccount() async {
    isLoading.value = true;
    username = usernameController.text;
    print('usernameeee: $username');
    if (username != '') {
      await authService.unlockAccountService(username);
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
    } else {
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      CommonSnackbar.failedSnackbar('Failed', 'Username must filled');
    }
  }
}
