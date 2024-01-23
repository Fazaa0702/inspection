import 'dart:convert';

InspectionModel inspectionModelFromJson(String str) =>
    InspectionModel.fromJson(json.decode(str));

String inspectionModelToJson(InspectionModel data) =>
    json.encode(data.toJson());

class InspectionModel {
  int id;
  String name;

  InspectionModel({
    required this.id,
    required this.name,
  });
  factory InspectionModel.fromJson(Map<String, dynamic> json) =>
      InspectionModel(
        id: json['id'],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
