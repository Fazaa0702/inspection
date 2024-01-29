import 'dart:convert';

import 'package:einspection/models/answer_model.dart';
import 'package:einspection/models/question_answer_model.dart';
import 'package:einspection/models/question_model.dart';
import 'package:einspection/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitFormController extends GetxController {
  var userId = '';

  final FormService _submitFormService = FormService();

  Future<void> submitAnswer(AnswerModel answerModel) async {
    //print("answer object : ${answerModel.toJson()}");

    try {
      bool success =
          await _submitFormService.submitAnswerService(answerModel.toJson());

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

  getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('id')) {
      var data = jsonDecode(prefs.getString('id')!);
      userId = data['id'];
    }
  }
}
