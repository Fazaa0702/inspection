import 'dart:convert';


LogModel logModelFromJson(String str) => LogModel.fromJson(json.decode(str));

String logModelToJson(LogModel data) => json.encode(data.toJson());

class LogModel {
  String id;
  String description;
  int departmentId;
  String itemId;
  String? picItemId;
  int inspectionId;
  String userId;
  DateTime time;

  LogModel(
      {required this.id,
      required this.description,
      required this.departmentId,
      required this.itemId,
      this.picItemId,
      required this.inspectionId,
      required this.userId,
      required this.time});

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        description: json["description"],
        departmentId: json["departmentId"],
        itemId: json["itemId"],
        picItemId: json["picItemId"],
        inspectionId: json["inspectionId"],
        userId: json["userId"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "departmentId": departmentId,
        "itemId": itemId,
        "picItemId": picItemId,
        "inspectionId": inspectionId,
        "userId": userId,
        "time": time,
      };
}
