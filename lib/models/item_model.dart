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
  String? lastInspection;
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
        departmentId: json["departmentId"] ?? 0,
        inspectionId: json["inspectionId"] ?? 0,
        number: json["number"] ?? "",
        modelOrType: json["modelOrType"] ?? "",
        lastInspection: json["lastInspection"] ?? '',
        location: json["location"] ?? "",
        picItemId: json["picItemId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": itemId,
        "name": itemName,
        "jumlahPengecekan": jumlahPengecekan,
        "number": number,
        "modelOrType": modelOrType,
        "inspectionId": inspectionId,
        "lastInspection": lastInspection,
        "location": location,
        "departmentId": departmentId,
        "picItemId": picItemId,
      };
}
