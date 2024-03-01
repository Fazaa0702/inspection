import 'dart:convert';

import 'package:einspection/models/log_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class HomeController extends GetxController {
  var log = <LogModel>[].obs;

  Future<void> fetchLogData() async {
    try {
      var res = await http.get(Uri.parse('${Constants.apiUrl}/api/ApiLog'));
      if (res.statusCode == 200) {
        final List<dynamic> response = json.decode(res.body);
        log.value = response.map((data) => LogModel.fromJson(data)).toList();
      } else {
        print('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }
}
