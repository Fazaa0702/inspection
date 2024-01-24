import 'dart:convert';

import 'package:einspection/models/dept_model.dart';
import 'package:einspection/models/inspection_model.dart';
import 'package:einspection/models/question_model.dart';
import 'package:einspection/services/form_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class FormController extends GetxController {
  RxList<DeptModel> dept = <DeptModel>[].obs;
  RxList<InspectionModel> inspect = <InspectionModel>[].obs;
  final FormService _formService = FormService();
  final RxList<QuestionModel> questions = <QuestionModel>[].obs;
  RxMap<String, dynamic> formData = <String, dynamic>{}.obs;
  TextEditingController textController = TextEditingController();

  var deptValue = "".obs;
  var inspectValue = "".obs;
  var inspectionId = '';
  final RxMap<String, RxString> selectedValue = <String, RxString>{}.obs;
  RxMap textControllers = {}.obs;

  @override
  void onInit() {
    fetchInspectionData();
    fetchDeptData();
    super.onInit();
  }

  // void selity() {
  //   selectedValue.value = !selectedValue.value;
  // }

  void setSelectedValue(String questionId, String value) {
    selectedValue[questionId] = value.obs;
  }

  void setTextController(String questionId, TextEditingController controller) {
    textControllers[questionId] = controller.obs;
  }

  TextEditingController? getActualTextController(String questionId) {
    final rxController = textControllers[questionId];
    return rxController?.value;
  }

  Future<void> fetchDeptData() async {
    final res = await http.get(Uri.parse('${Constants.apiUrl}/api/department'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      dept.assignAll(data.map((dept) => DeptModel.fromJson(dept)));
      print(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchInspectionData() async {
    final res = await http.get(Uri.parse('${Constants.apiUrl}/api/inspection'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      inspect
          .assignAll(data.map((inspect) => InspectionModel.fromJson(inspect)));
      print(res.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> fetchQuestionData(int inspectionId) async {
    try {
      final List<QuestionModel> result =
          await _formService.getQuestions(inspectionId);
      questions.assignAll(result);
    } catch (e) {
      print('Error fetching questions: $e');
    }
  }
}
