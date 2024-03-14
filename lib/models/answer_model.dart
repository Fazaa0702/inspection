import 'dart:convert';

AnswerModel answerModelFromJson(String str) =>
    AnswerModel.fromJson(json.decode(str));

String answerModelToJson(AnswerModel data) => json.encode(data.toJson());

class AnswerModel {
  String userId;
  int departmentId;
  int inspectionId;
  String questionAnswers;
  String picItemId;
  String? itemId;

  AnswerModel(
      {required this.userId,
      required this.departmentId,
      required this.inspectionId,
      required this.questionAnswers,
      required this.picItemId,
      this.itemId});
  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        userId: json["userId"],
        departmentId: json["departmentId"],
        inspectionId: json["inspectionId"],
        questionAnswers: json["questionAnswers"],
        picItemId: json["picItemId"] ?? "",
        itemId: json["itemId"] ?? "",
      );

  get questionId => null;

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "DepartmentId": departmentId,
        "InspectionId": inspectionId,
        "QuestionAnswers": questionAnswers,
        "picItemId": picItemId,
        "ItemId": itemId,
      };
}
