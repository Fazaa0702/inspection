import 'dart:convert';

QuestionAnswerModel questionAnswerModelFromJson(String str) =>
    QuestionAnswerModel.fromJson(json.decode(str));

String questionAnswerModelToJson(QuestionAnswerModel data) =>
    json.encode(data.toJson());

class QuestionAnswerModel {
  String questionId;
  String answerText;
  String? imageBase64;
  String? description;
  String? recommendation;

  QuestionAnswerModel({
    required this.questionId,
    required this.answerText,
    this.imageBase64,
    this.description,
    this.recommendation,
  });
  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
          questionId: json["questionId"],
          answerText: json["answerText"],
          imageBase64: json["imageBase64"],
          description: json["description"],
          recommendation: json["recommendation"]);

  Map<String, dynamic> toJson() => {
        "QuestionID": questionId,
        "AnswerText": answerText,
        "Image": imageBase64,
        "Description": description,
        "Recommendation": recommendation,
      };
}
