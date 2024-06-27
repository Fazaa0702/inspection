import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';
import '../../../export.dart';
import '../../../models/active_worker_model.dart';

class WorkerController extends GetxController {
  var worker = <WorkerModel>[].obs;
  var originalWorker = <WorkerModel>[].obs;
  var isLoadWorkerData = true.obs;
  // var activeWorker = <ActiveWorkerModel>[].obs;
  var workerActive = <WorkerActive>[].obs;
  var selectedDate = Rx<DateTime?>(DateTime.now());
  var searchFieldController = TextEditingController();

  void pickDate(DateTime? date) {
    selectedDate.value = date;
  }

  void onKeywordChange(String value, String id) async {
    if (value == "") {
      isLoadWorkerData.value = true;
      fetchWorkerData(id);
    } else {
      isLoadWorkerData.value = true;
      worker.value = await searchworker(value);
    }
    update();
  }

  Future<List<WorkerModel>> searchworker(String keyword) async {
    List<WorkerModel> results = originalWorker.where((worker) {
      return worker.name.toLowerCase().contains(keyword.toLowerCase()) ||
          worker.id.toString().toLowerCase().contains(keyword.toLowerCase()) ||
          worker.nik.toLowerCase().contains(keyword.toLowerCase()) ||
          worker.certification.toLowerCase().contains(keyword.toLowerCase()) ||
          worker.speciality.toLowerCase().contains(keyword.toLowerCase());
    }).toList();
    isLoadWorkerData.value = false;
    return results;
  }

  Future<void> fetchWorkerData(String workPermitId) async {
    try {
      var res = await http.get(Uri.parse(
          '${Constants.apiUrlHse}/api/work-permit/worker?workPermitId=$workPermitId'));
      print('iscServer: ${Constants.apiUrlIsc}');
      if (res.statusCode == 200) {
        final List<dynamic> response = json.decode(res.body);
        worker.assignAll(
            response.map((data) => WorkerModel.fromJson(data)).toList());
        originalWorker.assignAll(
            response.map((data) => WorkerModel.fromJson(data)).toList());
        isLoadWorkerData.value = false;
      } else {
        CommonSnackbar.failedSnackbar('Gagal', 'Tidak dapat mengambil data');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchActiveWorkerData(
      String workPermitId, String dateTime) async {
    var encodeWorkPermitId = Uri.encodeComponent(workPermitId);
    print(encodeWorkPermitId);
    print('iki tanggal: $dateTime');
    print('');
    try {
      var res = await http.get(Uri.parse(
          'http://10.83.34.6:8091/api/WorkPermit/ActiveWorker/$encodeWorkPermitId/$dateTime'));
      if (res.statusCode == 200) {
        print(res.body);
        final List<dynamic> response = json.decode(res.body);
        print('ressss: $response');
        workerActive.value = response
            .map((json) => ActiveWorkerModel.fromJson(json).worker)
            .expand((worker) => worker)
            .toList();
        print('worker active $workerActive');
        // var workerPerDay = ActiveWorkerModel.fromJson(json.decode(res.body));
        // workerActive.value = workerPerDay.worker;

        print('active workerrr: ${workerActive}');
        print('');
      } else {
        print('${res.statusCode}');
        CommonSnackbar.failedSnackbar('Failed', 'Not connected with server');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print('errorrr $e');
    }
  }
}
