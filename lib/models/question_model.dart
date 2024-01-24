import 'dart:convert';

QuestionModel questionModelFromJson(String str) =>
    QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  String id;
  String questionText;
  String questionType;
  int orderNumber;
  int inspectionId;

  QuestionModel({
    required this.id,
    required this.questionText,
    required this.questionType,
    required this.orderNumber,
    required this.inspectionId,
  });
  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
      id: json["id"],
      questionText: json["questionText"],
      questionType: json["questionType"],
      orderNumber: json["orderNumber"],
      inspectionId: json["inspectionId"]);

  get questionId => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "questionText": questionText,
        "questionType": questionType,
        "orderNumber": orderNumber,
        "inspectionId": inspectionId,
      };
}
