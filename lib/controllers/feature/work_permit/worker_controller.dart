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
  var activeWorker = <ActiveWorkerModel>[].obs;
  var workerPerDay = <WorkerActive>[].obs;
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
    print('iki tanggal: $dateTime');
    try {
      var res = await http.get(Uri.parse(
          'https://d472-103-159-203-219.ngrok-free.app/api/WorkPermit/ActiveWorker/$workPermitId/$dateTime'));
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
        CommonSnackbar.failedSnackbar('Tidak Terhubung Server',
            'Tidak dapat mengambil data active worker');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }
}
