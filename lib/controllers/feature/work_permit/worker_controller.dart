import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../export.dart';
import '../../../routes/route_name.dart';

class WorkerController extends GetxController {
  var worker = <WorkerModel>[].obs;
  var isLoadWorkerData = true.obs;

  void onInit() {
    super.onInit();
  }

  Future<void> fetchWorkerData(String workPermitId) async {
    try {
      var res = await http.get(Uri.parse(
          '${Constants.apiUrlHse}/api/work-permit/worker?workPermitId=$workPermitId'));
      if (res.statusCode == 200) {
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
}
