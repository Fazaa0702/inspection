import 'dart:convert';
import 'dart:math';

import 'package:einspection/export.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import '../routes/route_name.dart';

class FormService {
  Future<List<QuestionModel>> getQuestions(int inspectionId) async {
    final response = await http.get(
      Uri.parse(
          '${Constants.apiUrlHse}/api/inspection/question?inspectionId=$inspectionId'),
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
      "picItemId": answer["picItemId"] ?? '',
      "QuestionAnswers": jsonDecode(answer['QuestionAnswers']),
    });
    final res = await http.post(
        Uri.parse('${Constants.apiUrlHse}/api/inspectionResult'),
        body: jsonData,
        headers: {'Content-Type': 'application/json'});

    print('resbody : ${res.body}');
    print("json data = ${jsonData}");
    print("answerrrrrrrrrsssssss: ${answer["picItemId"]}");
    print('statusCodeee = ${res.statusCode}');
    if (res.statusCode == 200) {
      CommonSnackbar.successSnackbar('Success', 'Your answer has been sent');
      print("sukses : oke");
    } else {
      CommonSnackbar.failedSnackbar('failed', 'Your answer cannot sent');
      print("errror : ${e}");
    }
  }
}
