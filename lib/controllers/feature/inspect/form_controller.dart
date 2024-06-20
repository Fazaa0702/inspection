import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:einspection/global_var.dart';
import '../../../constants.dart';
import 'package:einspection/export.dart';

class FormController extends GetxController {
  RxList<DeptModel> dept = <DeptModel>[].obs;
  RxList<InspectionModel> inspect = <InspectionModel>[].obs;
  RxList<ItemModel> item = <ItemModel>[].obs;
  RxList<OptionConditionModel> option = <OptionConditionModel>[].obs;
  List<QuestionAnswerModel> answers = [];

  final FormService _formService = FormService();
  final RxList<QuestionModel> questions = <QuestionModel>[].obs;

  var deptValue = 0.obs;
  var inspectValue = 0.obs;
  var userId = '';
  var isLoading = true.obs;
  var count = 0;
  final RxBool isFieldEmpty = true.obs;

  final RxMap<String, RxString> selectedValue = <String, RxString>{}.obs;

  @override
  void onInit() {
    fetchDeptData();
    super.onInit();
  }

  void setSelectedValue(String questionId, String value) {
    selectedValue[questionId] = value.obs;
  }

  Future<void> fetchDeptData() async {
    try {
      final res =
          await http.get(Uri.parse('${Constants.apiUrlHse}/api/department'));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        dept.assignAll(data.map((dept) => DeptModel.fromJson(dept)));
        print(res.body);
      } else {
        CommonSnackbar.failedSnackbar('Failed', 'Not connected with server');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchOptionConditions(int inspectionId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Constants.apiUrlHse}/api/inspection/option-conditions?inspectionId=$inspectionId'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        option.assignAll(responseData
            .map((option) => OptionConditionModel.fromJson(option)));
        print('ressssssssssssss: ${response.body}');
      } else {
        CommonSnackbar.failedSnackbar('Failed', 'Not connected with server');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      // CommonSnackbar.failedSnackbar('Error', 'An unexpected error occurred');
      print(e);
    }
  }

  Future<void> fetchInspectionData() async {
    try {
      final res =
          await http.get(Uri.parse('${Constants.apiUrlHse}/api/inspection'));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        inspect.assignAll(
            data.map((inspect) => InspectionModel.fromJson(inspect)));
        print(res.body);
      } else {
        print('gagal mendapatkan data');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchQuestionData(int inspectionId) async {
    try {
      final List<QuestionModel> result =
          await _formService.getQuestions(inspectionId);
      questions.assignAll(result);
      print('total pertanyaan: ${questions.length}');
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchItemData(int inspectionId, int departmentId) async {
    try {
      final res = await http.get(Uri.parse(
          '${Constants.apiUrlHse}/api/ApiItem/inspection?inspectionId=$inspectionId&departmentId=$departmentId'));
      if (res.statusCode == 200) {
        final List<dynamic> data = json.decode(res.body);
        a = res.body;
        print("ini data item = " + a);
        item.assignAll(data.map((item) => ItemModel.fromJson(item)));
        print('resssss: ${res.body}');
      } else {
        print('gagal mendapatkan data');
      }
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }

  Future<void> submitAnswerCondition(AnswerModel answerModel) async {
    try {
      print('aaaannnnssswwweeerrr: ${answerModel.toJson()}');
      await _formService.submitAnswerService(answerModel.toJson());
    } on SocketException {
      CommonSnackbar.failedSnackbar(
          'Error', 'Please check your internet connection');
    } catch (e) {
      print(e);
    }
  }

  void inputAnswerCondition(
      List<QuestionAnswerModel> answers, QuestionAnswerModel currentAnswer) {
    int index =
        answers.indexWhere((qa) => qa.questionId == currentAnswer.questionId);
    print("index : $index");
    if (index != -1) {
      answers[index] = currentAnswer;
    } else {
      answers.add(currentAnswer);
    }
    print('question: ${questions.length}');
  }

  void validateField(String value) {
    isFieldEmpty.value = value.isEmpty;
  }
}
