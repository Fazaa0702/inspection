import 'dart:convert';

DeptModel deptModelFromJson(String str) => DeptModel.fromJson(json.decode(str));

String deptModelToJson(DeptModel data) => json.encode(data.toJson());

class DeptModel {
  int id;
  String name;

  DeptModel({
    required this.id,
    required this.name,
  });
  factory DeptModel.fromJson(Map<String, dynamic> json) => DeptModel(
        id: json['id'],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
