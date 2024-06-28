import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/register/password_register_view.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AuthService {
  var message = '';
  var loginCode;

  var userId = '';
  var user = '';
  // UserModel? userModel;

  Map<String, dynamic> createData(String username, String password) {
    var data = {"username": username, "password": password};
    return data;
  }

  Map<String, dynamic> requestChangePassword(
      String userId, String newPassword) {
    var request = {"userId": userId, "password": newPassword};
    return request;
  }

  Future<void> conditionalStatus(res) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (res.statusCode == 200) {
      var userModel = UserModel.fromJson(json.decode(res.body));
      loginCode = userModel.loginCode;
      userId = userModel.id;
      user = userModel.name;
      message = userModel.message;
      print(loginCode);
      print(userId);
      print(user);
      if (userModel.userLevelId == 2 ||
          userModel.userLevelId == 0 ||
          userModel.userLevelId == 6) {
        await prefs.setString('user', res.body);
        CommonSnackbar.successSnackbar(
            'Success', 'Welcome ${userModel.name} to HSE Connect', false);
        Get.toNamed(RouteName.home);
      }
    } else if (res.statusCode == 400) {
      var userModel = UserModel.fromJson(json.decode(res.body));
      loginCode = userModel.loginCode;
      userId = userModel.userId!;
      user = userModel.name;
      message = userModel.message;
      if (userModel.userLevelId == 2 ||
          userModel.userLevelId == 0 ||
          userModel.userLevelId == 6) {
        if (loginCode == 1) {
          CommonSnackbar.failedSnackbar('Failed',
              'Ups your account is locked, please reset your password');
        } else if (loginCode == 2) {
          Get.to(() => PasswordRegisterView(
                userId: userId,
                message: message,
              ));
          print('resssssssssssssss: ${res.body}');
          print('idddddddd:$message');
        }
      } else {
        CommonSnackbar.failedSnackbar(
            'Failed', 'Ups your account not have permission');
      }
    } else {
      CommonSnackbar.failedSnackbar(
          '${res.statusCode}', 'Ups invalid username or password');
    }
  }

  Future<void> loginService(String username, String password) async {
    try {
      var url = Uri.parse('${Constants.apiUrlHse}/api/loginApi');
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode(createData(username, password));

      var res = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      print('result : ${res.body}');
      print('body: $body');
      print('url: $url');

      conditionalStatus(res);
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } on http.ClientException catch (e) {
      print('client exception: $e');
    } on TimeoutException {
      CommonSnackbar.failedSnackbar(
          'Connection time out', 'Please check your internet connection');
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> changePasswordConditional(res) async {
    if (res.statusCode == 200) {
      CommonSnackbar.successSnackbar(
          'Success', 'Password has been changed', false);
      Get.offAllNamed(RouteName.login);
    } else if (res.statusCode == 400) {
      var userModel = UserModel.fromJson(json.decode(res.body));
      loginCode = userModel.loginCode;
      userId = userModel.userId!;
      user = userModel.name;
      message = userModel.message;
      if (loginCode == 4) {
        CommonSnackbar.failedSnackbar('Failed', message);
        Get.back();
      } else if (loginCode == 5) {
        CommonSnackbar.failedSnackbar('Failed', message);
        print('resssssssssssssss: ${res.body}');
        print('idddddddd:$message');
      }
    }
  }

  Future<void> changePassword(String userId, String password) async {
    try {
      var url =
          Uri.parse('${Constants.apiUrlHse}/api/loginApi/change-password');
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode(requestChangePassword(userId, password));
      var res = await http
          .post(url, body: body, headers: headers)
          .timeout(const Duration(seconds: 10));
      changePasswordConditional(res);
    } on http.ClientException catch (e) {
      print('client exception: $e');
    } on TimeoutException {
      CommonSnackbar.failedSnackbar(
          'Connection time out', 'Please check your internet connection');
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> unlockAccountConditional(res) async {
    if (res.statusCode == 200) {
      CommonSnackbar.successSnackbar(
          'Success', 'Please wait until admin reset your password', false);
      Get.offAllNamed(RouteName.login);
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'Username not found');
    }
  }

  Future<void> unlockAccountService(String username) async {
    try {
      var url = Uri.parse(
          '${Constants.apiUrlHse}/api/loginApi/request-unlock-account?username=$username');
      var res = await http.post(url).timeout(const Duration(seconds: 10));
      unlockAccountConditional(res);
    } on http.ClientException catch (e) {
      print('client exception: $e');
    } on TimeoutException {
      CommonSnackbar.failedSnackbar(
          'Connection time out', 'Please check your internet connection');
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
