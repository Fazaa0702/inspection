import 'dart:convert';

List<LogModel> logModelFromJson(String str) =>
    List<LogModel>.from(json.decode(str).map((x) => LogModel.fromJson(x)));

String logModelToJson(List<LogModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LogModel {
  final String id;
  final DateTime dateTime;
  final String inspectionName;
  final String inspectorName;
  final String buName;
  final String location;
  final String pic;
  final String itemName;
  final String activity;

  LogModel({
    required this.id,
    required this.dateTime,
    required this.inspectionName,
    required this.inspectorName,
    required this.buName,
    required this.location,
    required this.pic,
    required this.itemName,
    required this.activity,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
        id: json["id"],
        dateTime: DateTime.parse(json["dateTime"]),
        inspectionName: json["inspectionName"],
        inspectorName: json["inspectorName"],
        buName: json["buName"],
        location: json["location"],
        pic: json["pic"],
        itemName: json["itemName"],
        activity: json["activity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateTime":
            "${dateTime.year.toString().padLeft(4, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}",
        "inspectionName": inspectionName,
        "inspectorName": inspectorName,
        "buName": buName,
        "location": location,
        "pic": pic,
        "itemName": itemName,
        "activity": activity,
      };
}
