import 'dart:convert';

import 'package:einspection/models/dept_model.dart';
import 'package:einspection/models/inspection_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FormController extends GetxController {
  RxList<DeptModel> dept = <DeptModel>[].obs;
  RxList<InspectionModel> inspect = <InspectionModel>[].obs;
  var deptValue = "".obs;
  var inspectValue = "".obs;

  @override
  void onInit() {
    fetchInspectionData();
    fetchDeptData();
    super.onInit();
  }

  Future<void> fetchDeptData() async {
    final res = await http.get(Uri.parse(
        'https://485a-103-159-203-219.ngrok-free.app/api/department'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      dept.assignAll(data.map((dept) => DeptModel.fromJson(dept)));
      print(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchInspectionData() async {
    final res = await http.get(Uri.parse(
        'https://485a-103-159-203-219.ngrok-free.app/api/inspection'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      inspect
          .assignAll(data.map((inspect) => InspectionModel.fromJson(inspect)));
      print(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
