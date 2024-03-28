import 'dart:convert';

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

  final FormService _formService = FormService();
  final RxList<QuestionModel> questions = <QuestionModel>[].obs;

  List<QuestionAnswerModel> answers = [];

  var deptValue = 0.obs;
  var inspectValue = 0.obs;
  var userId = '';
  var isLoading = true.obs;
  // var isFieldEmpty = true.obs;
  final RxBool isFieldEmpty = true.obs;

  final RxMap<String, RxString> selectedValue = <String, RxString>{}.obs;
  // RxMap textControllers = {}.obs;

  @override
  void onInit() {
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
      CommonSnackbar.failedSnackbar('Failed', 'Not connected with server');
    }
  }

  Future<void> fetchOptionConditions(int inspectionId) async {
    final response = await http.get(Uri.parse(
        '${Constants.apiUrl}/api/inspection/option-conditions?inspectionId=$inspectionId'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      option.assignAll(
          responseData.map((option) => OptionConditionModel.fromJson(option)));
      print('ressssssssssssss: ${response.body}');
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'Not connected with server');
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

  Future<void> fetchItemData(int inspectionId, int departmentId) async {
    final res = await http.get(Uri.parse(
        '${Constants.apiUrl}/api/ApiItem/inspection?inspectionId=$inspectionId&departmentId=$departmentId'));
    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body);
      a = res.body;
      print("ini data item = " + a);
      item.assignAll(data.map((item) => ItemModel.fromJson(item)));
      print('resssss: ${res.body}');
    } else {
      print('gagal mendapatkan data');
    }
  }

  Future<void> submitAnswerCondition(AnswerModel answerModel) async {
    try {
      bool success =
          await _formService.submitAnswerService(answerModel.toJson());
      print("success value : $success");
      if (success) {
        print('Data terkirim ke database');
      } else {
        print('Gagal mengirim data ke database');
      }
    } catch (e) {
      print('Error: $e');
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
  }

  void validateField(String value) {
    isFieldEmpty.value = value.isEmpty;
  }
}
