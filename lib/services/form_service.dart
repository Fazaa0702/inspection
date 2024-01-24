import 'dart:convert';

import 'package:einspection/models/answer_model.dart';
import 'package:einspection/models/question_model.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class FormService {
  Future<List<QuestionModel>> getQuestions(int inspectionId) async {
    final response = await http.post(
      Uri.parse('${Constants.apiUrl}/api/inspection/question'),
      body: jsonEncode({'id': inspectionId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print("result: ${data}");
      return data.map((json) => QuestionModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }

  Future submitAnswerService(AnswerModel answer) async {
    final res = await http.post(
      Uri.parse('${Constants.apiUrl}/api/inspectionResult'),
      body: jsonEncode(answer.toJson()),
    );

    if (res.statusCode == 200) {
      print("result: ${res.body}");
      return 'Sukses';
    } else {
      throw Exception('Failed to submit answer');
    }
  }
}
