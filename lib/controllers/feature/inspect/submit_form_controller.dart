import 'dart:convert';

import 'package:einspection/models/answer_model.dart';
import 'package:einspection/models/question_answer_model.dart';
import 'package:einspection/models/question_model.dart';
import 'package:einspection/services/form_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitFormController extends GetxController {
  final FormService _submitFormService = FormService();
}
