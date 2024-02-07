import 'dart:convert';

import 'package:einspection/models/dept_model.dart';
import 'package:einspection/models/inspection_model.dart';
import 'package:einspection/models/question_model.dart';
import 'package:einspection/services/form_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/common_snackbar.dart';
import '../../../constants.dart';
import '../../../models/answer_model.dart';
import '../../../models/question_answer_model.dart';

class FormController extends GetxController {
  RxList<DeptModel> dept = <DeptModel>[].obs;
  RxList<InspectionModel> inspect = <InspectionModel>[].obs;
  final FormService _formService = FormService();
  final RxList<QuestionModel> questions = <QuestionModel>[].obs;
  List<QuestionAnswerModel> answers = [];

  var deptValue = 0.obs;
  var inspectValue = 0.obs;
  var userId = '';
  // var isFieldEmpty = true.obs;
  final RxBool isFieldEmpty = true.obs;

  final RxMap<String, RxString> selectedValue = <String, RxString>{}.obs;
  // RxMap textControllers = {}.obs;

  @override
  void onInit() {
    fetchInspectionData();
    fetchDeptData();
    super.onInit();
  }

  void setSelectedValue(String questionId, String value) {
    selectedValue[questionId] = value.obs;
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
      // throw Exception('Failed to load data');
      print('gagal mendapatkan data');
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

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('id')) {
      var data = jsonDecode(prefs.getString('id')!);
      userId = data['id'];
    }
  }

  Future<void> submitAnswerCondition(AnswerModel answerModel) async {
    //print("answer object : ${answerModel.toJson()}");
    try {
      bool success =
          await _formService.submitAnswerService(answerModel.toJson());
      print("success value : ${success}");
      if (success) {
        print('Data terkirim ke database');
      } else {
        print('Gagal mengirim data ke database');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Metode untuk validasi dan mengatur status isFieldEmpty
  void validateField(String value) {
    isFieldEmpty.value = value.isEmpty;
  }

  // Future<void> submitAnswer(int departmentId, int inspectionId) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var dataUser = prefs.getString("user").toString();
  //   Map<String, dynamic> userData = json.decode(dataUser);
  //   List<Map<String, dynamic>> answersMapList =
  //       answers.map((obj) => obj.toJson()).toList();

  //   String jsonDataQuestionanswers = jsonEncode(answersMapList);
  //   AnswerModel answerModel = AnswerModel(
  //       userId: userData['id'],
  //       departmentId: departmentId,
  //       inspectionId: inspectionId,
  //       questionAnswers: jsonDataQuestionanswers);
  //   submitAnswerCondition(answerModel);
  //   print(jsonDataQuestionanswers);
  //   CommonSnackbar.successSnackbar('Success', 'Data anda telah tersimpan');
  // }
}
