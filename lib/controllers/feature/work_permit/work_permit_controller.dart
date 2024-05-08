import 'dart:convert';

import 'package:get/get.dart';
import 'package:einspection/export.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../models/detail_work_permit_model.dart';

class WorkPermitController extends GetxController {
  var selectedDate = Rx<DateTime?>(DateTime.now());
  var isLoadData = true.obs;
  var workPermitLog = <WorkPermitModel>[].obs;
  var detailWorkPermit = <DetailWorkPermit>[].obs;
  var jobClassification = <JobClassification>[].obs;
  var jobTools = <JobTool>[].obs;
  var safetyEquipment = <SafetyEquipment>[].obs;
  var highRiskArea = <HighRiskArea>[].obs;

  @override
  void onInit() {
    fetchWorkPermitData();
    super.onInit();
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

  Future<void> fetchDetailWorkPermit(String workPermitId) async {
    var res = await http.get(Uri.parse(
        '${Constants.apiUrlHse}/api/work-permit/detail?workPermitId=$workPermitId'));
    if (res.statusCode == 200) {
      final List<dynamic> response = json.decode(res.body);
      detailWorkPermit.value =
          response.map((json) => DetailWorkPermit.fromJson(json)).toList();
      jobClassification.value = response
          .map((json) => DetailWorkPermit.fromJson(json).jobClassifications)
          .expand((jobClassifications) => jobClassifications)
          .toList();
      jobTools.value = response
          .map((json) => DetailWorkPermit.fromJson(json).jobTools)
          .expand((jobTools) => jobTools)
          .toList();
      safetyEquipment.value = response
          .map((json) => DetailWorkPermit.fromJson(json).safetyEquipment)
          .expand((safetyEquipment) => safetyEquipment)
          .toList();
      highRiskArea.value = response
          .map((json) => DetailWorkPermit.fromJson(json).highRiskArea)
          .expand((highRiskArea) => highRiskArea)
          .toList();
      print(res.body);
      print(jobClassification);
    } else {
      CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
    }
  }
}
