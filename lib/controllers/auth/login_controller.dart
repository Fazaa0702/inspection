import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var username = '';
  var password = '';
  var isPasswordVisible = true.obs;
  var userIdController = TextEditingController();
  var passwordController = TextEditingController();
  var user = ''.obs;
  var isLoading = true.obs;
  String? message;

  final AuthService authService = AuthService();

  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }

  void login() async {
    if (username != '' && password != '') {
      await authService.loginService(username, password);
      user.value = authService.user.toUpperCase();
      enterHome();
    }
  }

  Future<void> enterHome() async {
    if (message == '') {
      isLoading.value = false;
      // CommonSnackbar.successSnackbar(
      //     'Success', 'Welcome to HSE Connect ${user.value}');
      // Get.offAllNamed(RouteName.home);
      // Get.to(() => PasswordRegisterView(username: username));
      print('user: $user');
    }
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
  }

  void emptyForm() async {
    username = userIdController.text;
    password = passwordController.text;
    print(password);
    if (username == '' && password == '') {
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      CommonSnackbar.failedSnackbar(
          'Failed', 'Username & Password cannot be empty');
      print("coba lagioioio");
    } else if (username == '') {
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      CommonSnackbar.failedSnackbar('Failed', 'Username cannot be empty');
      print("coba lagioioio");
    } else if (password == '') {
      await Future.delayed(const Duration(seconds: 1));
      isLoading.value = false;
      CommonSnackbar.failedSnackbar('Failed', 'Password cannot be empty');
    }
    login();
  }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(RouteName.login);
  }
}
