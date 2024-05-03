import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var userId = '';
  var userIdController = TextEditingController();
  String? message;

  final AuthService authService = AuthService();

  void _login() async {
    if (userId != '') {
      message = await authService.loginService(userId);
      _enterHome();
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'User not found');
      print("Tidak ada ID pengguna yang ditemukan");
    }
  }

  Future<void> _enterHome() async {
    if (message == '') {
      await Future.delayed(const Duration(seconds: 2));
      CommonSnackbar.successSnackbar('Success', 'Welcome to HSE Connect');
      Get.offAllNamed(RouteName.home);
    } 
  }

  void emptyForm() {
    userId = userIdController.text;
    if (userId == '') {
      CommonSnackbar.failedSnackbar('Failed', 'UserId cannot be empty');
      print("coba lagi");
    }
    _login();
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(RouteName.login);
  }
}
