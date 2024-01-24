import 'dart:convert';

import 'package:einspection/models/question_answer_model.dart';

AnswerModel questionModelFromJson(String str) =>
    AnswerModel.fromJson(json.decode(str));

String questionModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
  String userId;
  String department;
  int inspectionId;
  List<QuestionAnswerModel> questionAnswers;

  AnswerModel({
    required this.userId,
    required this.department,
    required this.inspectionId,
    required this.questionAnswers,
  });
  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        userId: json["userId"],
        department: json["department"],
        inspectionId: json["inspectionId"],
        questionAnswers: json["questionAnswers"],
      );

  get questionId => null;

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "department": department,
        "inspectionId": inspectionId,
        "questionAnswers": questionAnswers,
      };
}
