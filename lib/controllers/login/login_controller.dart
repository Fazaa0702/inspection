import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var userId = '';
  var userIdController = TextEditingController();
  var user = ''.obs;
  String? message;

  final AuthService authService = AuthService();

  void login() async {
    if (userId != '') {
      message = await authService.loginService(userId);
      user.value = authService.user.toUpperCase();
      enterHome();
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'User not found');
    }
  }

  Future<void> enterHome() async {
    if (message == '') {
      await Future.delayed(const Duration(seconds: 2));
      CommonSnackbar.successSnackbar(
          'Success', 'Welcome to HSE Connect ${user.value}');
      Get.offAllNamed(RouteName.home);
      print('user: ${user}');
    }
  }

  void emptyForm() {
    userId = userIdController.text;
    if (userId == '') {
      CommonSnackbar.failedSnackbar('Failed', 'UserId cannot be empty');
      print("coba lagi");
    }
    login();
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(RouteName.login);
  }
}
