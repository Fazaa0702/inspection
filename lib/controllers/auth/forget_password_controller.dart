import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  var usernameController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  var username = '';
  var newPassword = '';
  var confirmPassword = '';

  var isNewPasswordVisible = true.obs;
  var isConfirmPasswordVisible = true.obs;

  var newPasswordValidate = [].obs;

 
}
