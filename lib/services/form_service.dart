import 'dart:convert';
import 'dart:math';

import 'package:einspection/export.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class FormService {
  Future<List<QuestionModel>> getQuestions(int inspectionId) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.apiUrl}/api/inspection/question?inspectionId=$inspectionId'),
      // body: jsonEncode({'id': inspectionId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("result: $data");
      return data.map((json) => QuestionModel.fromJson(json)).toList();
    } else {
      CommonSnackbar.failedSnackbar('Failed', 'Not connected with server');
      return [];
    }
  }

  Future submitAnswerService(Map<String, dynamic> answer) async {
    var jsonData = jsonEncode({
      "UserId": answer["UserId"],
      "DepartmentId": answer["DepartmentId"],
      "InspectionId": answer["InspectionId"],
      "ItemId": answer["ItemId"],
      "QuestionAnswers": jsonDecode(answer['QuestionAnswers']),
    });
    final res = await http.post(
        Uri.parse('${Constants.apiUrl}/api/inspectionResult'),
        body: jsonData,
        headers: {'Content-Type': 'application/json'});

    print('resbody : ${res.body}');
    print("json data = ${jsonData}");
    if (res.statusCode == 200) {
      return 'Sukses';
    } else {
      print("errror : ${e}");
    }
  }
}
