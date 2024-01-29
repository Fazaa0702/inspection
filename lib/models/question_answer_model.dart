import 'dart:convert';

QuestionAnswerModel questionAnswerModelFromJson(String str) =>
    QuestionAnswerModel.fromJson(json.decode(str));

String questionAnswerModelToJson(QuestionAnswerModel data) =>
    json.encode(data.toJson());

class QuestionAnswerModel {
  String questionId;
  String answerText;

  QuestionAnswerModel({
    required this.questionId,
    required this.answerText,
  });
  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        questionId: json["questionId"],
        answerText: json["answerText"],
      );

  get id => null;

  Map<String, dynamic> toJson() => {
        "QuestionID": questionId,
        "AnswerText": answerText,
      };
}
