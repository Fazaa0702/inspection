import 'dart:convert';
import 'dart:io';

import 'package:einspection/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class HomeController extends GetxController {
  var log = <LogModel>[].obs;
  var inspectionName = <InspectionModel>[];
  var isLoading = true.obs;
  var rowsPerPage = 10.obs;

  @override
  void onInit() {
    fetchLogData();
    super.onInit();
  }

  @override
  Future<void> refresh() async {
    isLoading.value = true;
    fetchLogData();
  }

  void updateRowsPerPage(int newRowsPerPage) {
    rowsPerPage.value = newRowsPerPage;
  }

  Future<void> fetchLogData() async {
    try {
      var res = await http.get(Uri.parse('${Constants.apiUrlHse}/api/ApiLog'));
      if (res.statusCode == 200) {
        final List<dynamic> response = json.decode(res.body);
        log.value = response.map((data) => LogModel.fromJson(data)).toList();
        print('resulttttt: ${res.body}');
        isLoading.value = false;
      } else {
        CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      // CommonSnackbar.failedSnackbar('Error', 'An unexpected error occurred');
      print(e);
    }
  }
}
