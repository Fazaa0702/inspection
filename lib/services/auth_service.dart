import 'dart:convert';

import 'package:einspection/component/common_snackbar.dart';
import 'package:einspection/services/conditional_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/user_model.dart';

class AuthService {
  // String apiUrl = '';

  Map<String, dynamic> createData(String id) {
    var data = {
      'id': id,
    };
    return data;
  }

  Future<String> conditionalStatus(res) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var message = '';
    if (res.statusCode == 200) {
      var userModel = UserModel.fromJson(json.decode(res.body));
      if (userModel.userLevelId == 2) {
        await prefs.setString('user', res.body);
        return ConditionalService().authConditionalMessage(res, message);
      } else {
        CommonSnackbar.failedSnackbar(
            'Failed', "you don't have any permissions");
        print('userlevelllllll: ${userModel.userLevelId}');
        return 'Anda tidak memiliki akses untuk login';
      }
    } else {
      CommonSnackbar.failedSnackbar(
          'Failed', 'Server error, please try again later');
      return 'salah';
    }
  }

  Future<String> loginService(String id) async {
    try {
      var url = Uri.parse('${Constants.apiUrl}/api/loginApi');
      var headers = {'Content-Type': 'application/json'};
      var body = json.encode(createData(id));

      var res = await http.post(url, body: body, headers: headers);
      print('result : ${res.body}');

      return conditionalStatus(res);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return 'Inputan salah, silahkan coba kembali';
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }
}
