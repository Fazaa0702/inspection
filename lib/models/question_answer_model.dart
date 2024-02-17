import 'dart:convert';

QuestionAnswerModel questionAnswerModelFromJson(String str) =>
    QuestionAnswerModel.fromJson(json.decode(str));

String questionAnswerModelToJson(QuestionAnswerModel data) =>
    json.encode(data.toJson());

class QuestionAnswerModel {
  String questionId;
  String answerText;
  String? imageBase64;

  QuestionAnswerModel({
    required this.questionId,
    required this.answerText,
    this.imageBase64,
  });
  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
          questionId: json["questionId"],
          answerText: json["answerText"],
          imageBase64: json["imageBase64"]);

  Map<String, dynamic> toJson() => {
        "QuestionID": questionId,
        "AnswerText": answerText,
        "imageBase64": imageBase64,
      };
}
