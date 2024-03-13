import 'package:einspection/component/common_snackbar.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var userId = '';
  var userIdController = TextEditingController();
  String? message;
  // UserModel? userModel;

  final AuthService authService = AuthService();

  void _login() async {
    if (userId != '') {
      message = await authService.loginService(userId);
      _enterHome();
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'UserId not found');
      print("Tidak ada ID pengguna yang ditemukan");
    }
    // message = await authService.loginService(userId);
    // _enterHome();
  }

  Future<void> _enterHome() async {
    if (message == '') {
      await Future.delayed(const Duration(seconds: 2));
      CommonSnackbar.successSnackbar('Success', 'Welcome to HSE Connect');
      Get.offAllNamed(RouteName.home);
    } //else {
    //   CommonSnackbar.failedSnackbar(
    //       'Failed', 'Sorry you dont have any permissions');
    // }
  }

  void emptyForm() {
    userId = userIdController.text;
    if (userId == '') {
      CommonSnackbar.failedSnackbar('Failed', 'UserId cannot be empty');
      print("coba lagi");
    }
    _login();
  }

  // getUserId() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (prefs.containsKey('id')) {
  //     var data = jsonDecode(prefs.getString('id')!);
  //     userId = data['id'];
  //   }
  // }

  // Future<bool> isUserLevel2(UserModel userModel) async {
  //   // Pastikan user tidak null dan userLevelId = 2
  //   return userModel.userLevelId == 2;
  // }

  Future<void> logout() async {
    await authService.logout();
    Get.offAllNamed(RouteName.login);
  }
}
