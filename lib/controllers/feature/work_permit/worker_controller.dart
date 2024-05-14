import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../export.dart';
import '../../../models/active_worker_model.dart';

class WorkerController extends GetxController {
  var worker = <WorkerModel>[].obs;
  var isLoadWorkerData = true.obs;
  var activeWorker = <ActiveWorkerModel>[].obs;
  var workerPerDay = <WorkerActive>[].obs;
  var selectedDate = Rx<DateTime?>(DateTime.now());

  @override
  void onInit() {
    super.onInit();
  }

  void pickDate(DateTime? date) {
    selectedDate.value = date;
  }

  Future<void> fetchWorkerData(String workPermitId) async {
    try {
      var res = await http.get(Uri.parse(
          '${Constants.apiUrlHse}/api/work-permit/worker?workPermitId=$workPermitId'));
      if (res.statusCode == 200) {
        // var workers = WorkerModel.fromJson(json.decode(res.body));
        final List<dynamic> response = json.decode(res.body);
        worker.assignAll(
            response.map((data) => WorkerModel.fromJson(data)).toList());
      } else {
        CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
      }
    } catch (e) {
      CommonSnackbar.failedSnackbar(
          'Error', 'Terjadi kesalahan saat mengambil data');
    }
  }

  Future<void> fetchActiveWorkerData(
      String workPermitId, String dateTime) async {
    print('iki tanggal: $dateTime');
    var res = await http.get(Uri.parse(
        'https://93cb-103-159-203-219.ngrok-free.app/api/WorkPermit/ActiveWorker/$workPermitId/$dateTime'));
    if (res.statusCode == 200) {
      final List<dynamic> response = json.decode(res.body);
      activeWorker.value =
          response.map((data) => ActiveWorkerModel.fromJson(data)).toList();
      workerPerDay.value = response
          .map((data) => ActiveWorkerModel.fromJson(data).worker)
          .expand((workerPerDay) => workerPerDay)
          .toList();
      print('active workerrr: ${res.body}');
      print('value = $workerPerDay');
    } else {
      print('${res.statusCode}');
      CommonSnackbar.failedSnackbar(
          'Tidak Terhubung Server', 'Tidak dapat mengambil data active worker');
    }
  }
}
