import 'package:einspection/models/answer_model.dart';
import 'package:einspection/models/question_answer_model.dart';
import 'package:einspection/models/question_model.dart';
import 'package:einspection/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubmitFormController extends GetxController {
  final FormService formService = FormService();
  var answer = <QuestionAnswerModel>[];
  final Map<String, TextEditingController> textControllers = {};

  void addFormData(String questionId, String answerText) {
    answer.add;
  }
}
