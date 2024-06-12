import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

class PasswordRegisterController extends GetxController {
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var newPassword = '';
  var confirmPassword = '';
  var isLoading = false.obs;

  var isNewPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;
  var newPasswordWarning = false.obs;
  var warningText = ''.obs;

  var newPasswordValidate = [].obs;

  var authService = AuthService();

  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }

  List<dynamic> passwordValidate(String password) {
    if (password.length < 10) {
      return [false, "Password must contains at least 10 characters long"];
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return [false, "Password must contains uppercase alphabet letter"];
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return [false, "Password must contains lowercase alphabet letter"];
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return [false, "Password must contains number"];
    }
    if (!password.contains(
        RegExp(r'[!\"#\$%&\\(\)\*\+,-./:;<=>\?@\[\\\]\^_`\{\|\}~]'))) {
      return [false, "Password must contains special character"];
    }
    if (password.contains(RegExp(r"'"))) {
      return [false, "Password cannot contains ' character"];
    }
    return [true, "Password is valid"];
  }

  void registerPassword(String userId) async {
    newPassword = newPasswordController.text;
    confirmPassword = confirmPasswordController.text;
    if (confirmPassword == newPassword) {
      if (newPassword == '' || confirmPassword == '') {
        CommonSnackbar.failedSnackbar(
            'Failed', 'All form field must be filled');
      }
      if (newPassword != '' && confirmPassword != '') {
        await authService.changePassword(userId, confirmPassword);
        CommonSnackbar.successSnackbar('Success', 'Password has been changed');
        print(userId);
        print(confirmPassword);
        // Get.toNamed(RouteName.login);
      }
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'Invalid Password');
    }
  }
}
