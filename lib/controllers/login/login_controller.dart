import 'dart:convert';

import 'package:einspection/component/common_snackbar.dart';
import 'package:einspection/models/user_model.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var userId = '';
  var userIdController = TextEditingController();
  String? message;
  UserModel? userModel;

  final AuthService authService = AuthService();

  void _login() async {
    message = await authService.loginService(userId);
    _enterHome();
  }

  Future<void> _enterHome() async {
    if (message == '') {
      await Future.delayed(const Duration(seconds: 2));
      CommonSnackbar.successSnackbar('Success', 'Anda telah berhasil masuk');
      Get.offAllNamed(RouteName.home);
    } else {
      print('gagal');
    }
  }

  void emptyForm() {
    userId = userIdController.text;
    if (userId == '') {
      print("coba lagi");
    }
    _login();
  }

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('id')) {
      var data = jsonDecode(prefs.getString('id')!);
      userId = data['id'];
    }
  }
}
