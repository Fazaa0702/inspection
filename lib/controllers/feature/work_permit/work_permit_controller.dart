import 'dart:convert';

import 'package:einspection/models/active_worker_model.dart';
import 'package:get/get.dart';
import 'package:einspection/export.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class WorkPermitController extends GetxController {
  var selectedDate = Rx<DateTime?>(DateTime.now());
  var isLoadData = true.obs;
  var workPermitLog = <WorkPermitModel>[].obs;
  var activeWorker = <ActiveWorkerModel>[].obs;

  @override
  void onInit() {
    fetchWorkPermitData();
    super.onInit();
  }

  void pickDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> fetchWorkPermitData() async {
    var res =
        await http.get(Uri.parse('${Constants.apiUrlHse}/api/work-permit'));
    if (res.statusCode == 200) {
      final List<dynamic> response = json.decode(res.body);
      workPermitLog.value =
          response.map((data) => WorkPermitModel.fromJson(data)).toList();
      print('resulttttt: ${res.body}');
      isLoadData.value = !isLoadData.value;
    } else {
      CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
    }
  }

  Future<void> fetchActiveWorkerData(
      String workPermitId, String dateTime) async {
    var res = await http.get(Uri.parse(
        '${Constants.apiUrlIsc}/api/WorkPermit/ActiveWorker/$workPermitId/$dateTime'));
    if (res.statusCode == 200) {
      final List<dynamic> response = json.decode(res.body);
      activeWorker.value =
          response.map((data) => ActiveWorkerModel.fromJson(data)).toList();
      print('resulttttt: ${res.body}');
    } else {
      CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
    }
  }
}
