import 'dart:convert';

import 'package:einspection/models/question_answer_model.dart';

AnswerModel questionModelFromJson(String str) =>
    AnswerModel.fromJson(json.decode(str));

String questionModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
  String userId;
  int departmentId;
  int inspectionId;
  String questionAnswers;

  AnswerModel({
    required this.userId,
    required this.departmentId,
    required this.inspectionId,
    required this.questionAnswers,
  });
  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        userId: json["userId"],
        departmentId: json["departmentId"],
        inspectionId: json["inspectionId"],
        questionAnswers: json["questionAnswers"],
      );

  get questionId => null;

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "DepartmentId": departmentId,
        "InspectionId": inspectionId,
        "QuestionAnswers": questionAnswers,
      };
}
