import 'dart:convert';


ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  String itemId;
  String itemName;
  int jumlahPengecekan;
  String number;
  String modelOrType;
  int inspectionId;
  DateTime? lastInspection;
  String location;
  int departmentId;
  String picItemId;

  ItemModel({
    required this.itemId,
    required this.itemName,
    required this.jumlahPengecekan,
    required this.number,
    required this.modelOrType,
    required this.inspectionId,
    this.lastInspection,
    required this.location,
    required this.departmentId,
    required this.picItemId,
  });
  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        itemId: json["id"] ?? "",
        itemName: json["name"] ?? "",
        jumlahPengecekan: json["jumlahPengecekan"] ?? 0,
        departmentId: json["departmentId"],
        inspectionId: json["inspectionId"],
        number: json["number"] ?? "",
        modelOrType: json["modelOrType"] ?? "",
        lastInspection: json["lastInspection"] != null
            ? DateTime.parse(json["lastInspection"])
            : null,
        location: json["location"] ?? "",
        picItemId: json["picItemId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": itemId,
        "name": itemName,
        "jumlahPegecekan": jumlahPengecekan,
        "number": number,
        "modelOrType": modelOrType,
        "inspectionId": inspectionId,
        "lastInspection": lastInspection?.toIso8601String(),
        "location": location,
        "departmentId": departmentId,
        "picItemId": picItemId,
      };
}
