import 'dart:convert';

import 'package:einspection/models/user_model.dart';

LogModel logModelFromJson(String str) => LogModel.fromJson(json.decode(str));

String logModelToJson(LogModel data) => json.encode(data.toJson());

class LogModel {
  String userId;
  DateTime? time;
  int departmentId;
  int inspectionId;
  String description;

  LogModel({
    required this.userId,
    this.time,
    required this.departmentId,
    required this.inspectionId,
    required this.description
  });
  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        userId: json["userId"],
        time: json["time"],
        departmentId: json["departmentId"],
        inspectionId: json["inspectionId"],
        description: json["description"]
      );

  Map<String, dynamic> toJson() => {
        "UserId": userId,
        "Time": time,
        "DepartmentId": departmentId,
        "InspectionId": inspectionId,
        "Description": description,
      };
}
