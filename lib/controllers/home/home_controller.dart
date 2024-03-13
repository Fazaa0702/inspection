import 'dart:convert';

import 'package:einspection/component/common_snackbar.dart';
import 'package:einspection/models/inspection_model.dart';
import 'package:einspection/models/log_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class HomeController extends GetxController {
  var log = <LogModel>[].obs;
  var inspectionName = <InspectionModel>[];
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchLogData();
    fetchInspectionName();
    super.onInit();
  }

  Future<void> fetchLogData() async {
    var res = await http.get(Uri.parse('${Constants.apiUrl}/api/ApiLog'));
    if (res.statusCode == 200) {
      final List<dynamic> response = json.decode(res.body);
      log.value = response.map((data) => LogModel.fromJson(data)).toList();
      print('resulttttt: ${res.body}');
      isLoading.value = !isLoading.value;
    } else {
      CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
    }
  }

  Future<void> fetchInspectionName() async {
    var res = await http.get(Uri.parse('${Constants.apiUrl}/api/inspection'));
    if (res.statusCode == 200) {
      final List<dynamic> response = json.decode(res.body);
      inspectionName =
          response.map((data) => InspectionModel.fromJson(data)).toList();
      print('inspectionName: $inspectionName');
      print('resBOdy: ${res.body}');
    } else {
      print('gagal');
    }
    return null;
  }

 
}
