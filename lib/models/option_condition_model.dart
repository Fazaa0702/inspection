import 'dart:convert';

OptionConditionModel optionConditionModelFromJson(String str) =>
    OptionConditionModel.fromJson(json.decode(str));

String optionConditionModelToJson(OptionConditionModel data) =>
    json.encode(data.toJson());

class OptionConditionModel {
  String id;
  String condition;
  int inspectionId;
  bool? isNeedNcr;

  OptionConditionModel({
    required this.id,
    required this.condition,
    required this.inspectionId,
    this.isNeedNcr,
  });
  factory OptionConditionModel.fromJson(Map<String, dynamic> json) =>
      OptionConditionModel(
        id: json["id"] ?? '',
        condition: json["condition"] ?? '',
        inspectionId: json["inspectionId"] ?? 0,
        isNeedNcr: json["isNeedNcr"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "condition": condition,
        "inspectionId": inspectionId,
        "isNeedNcr": isNeedNcr,
      };
}
