class DetailWorkPermit {
  final String regNum;
  final String requestDate;
  final String jobName;
  final List<JobClassification> jobClassifications;
  final List<JobTool> jobTools;
  final List<SafetyEquipment> safetyEquipment;
  final List<HighRiskArea> highRiskArea;

  DetailWorkPermit({
    required this.regNum,
    required this.requestDate,
    required this.jobName,
    required this.jobClassifications,
    required this.jobTools,
    required this.safetyEquipment,
    required this.highRiskArea,
  });

  factory DetailWorkPermit.fromJson(Map<String, dynamic> json) =>
      DetailWorkPermit(
        regNum: json["regNum"],
        requestDate: json["requestDate"],
        jobName: json["jobName"],
        jobClassifications: List<JobClassification>.from(
            json["jobClassifications"]
                .map((x) => JobClassification.fromJson(x))),
        jobTools: List<JobTool>.from(
            json["jobTools"].map((x) => JobTool.fromJson(x))),
        safetyEquipment: List<SafetyEquipment>.from(
            json["safetyEquipment"].map((x) => SafetyEquipment.fromJson(x))),
        highRiskArea: List<HighRiskArea>.from(
            json["highRiskArea"].map((x) => HighRiskArea.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "regNum": regNum,
        "requestDate": requestDate,
        "jobName": jobName,
        "jobClassifications":
            List<dynamic>.from(jobClassifications.map((x) => x.toJson())),
        "jobTools": List<dynamic>.from(jobTools.map((x) => x.toJson())),
        "safetyEquipment":
            List<dynamic>.from(safetyEquipment.map((x) => x.toJson())),
        "highRiskArea": List<dynamic>.from(highRiskArea.map((x) => x.toJson())),
      };
}

class HighRiskArea {
  final int id;
  final String workPermitId;
  final String riskArea;
  final dynamic note;

  HighRiskArea({
    required this.id,
    required this.workPermitId,
    required this.riskArea,
    required this.note,
  });

  factory HighRiskArea.fromJson(Map<String, dynamic> json) => HighRiskArea(
        id: json["id"],
        workPermitId: json["workPermitId"],
        riskArea: json["riskArea"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workPermitId": workPermitId,
        "riskArea": riskArea,
        "note": note,
      };
}

class JobClassification {
  final int id;
  final String workPermitId;
  final String jobClassificationName;

  JobClassification({
    required this.id,
    required this.workPermitId,
    required this.jobClassificationName,
  });

  factory JobClassification.fromJson(Map<String, dynamic> json) =>
      JobClassification(
        id: json["id"] ?? 0,
        workPermitId: json["workPermitId"] ?? '',
        jobClassificationName: json["jobClassificationName"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workPermitId": workPermitId,
        "jobClassificationName": jobClassificationName,
      };
}

class JobTool {
  final int id;
  final String workPermitId;
  final String toolName;
  final String toolAmount;
  final String material;
  final String materialAmount;
  final String heavyEquipment;
  final String heavyEquipmentCapacity;
  final String heavyEquipmentAmount;

  JobTool({
    required this.id,
    required this.workPermitId,
    required this.toolName,
    required this.toolAmount,
    required this.material,
    required this.materialAmount,
    required this.heavyEquipment,
    required this.heavyEquipmentCapacity,
    required this.heavyEquipmentAmount,
  });

  factory JobTool.fromJson(Map<String, dynamic> json) => JobTool(
        id: json["id"] ?? 0,
        workPermitId: json["workPermitId"] ?? '',
        toolName: json["toolName"] ?? '',
        toolAmount: json["toolAmount"] ?? '',
        material: json["material"] ?? '',
        materialAmount: json["materialAmount"] ?? '',
        heavyEquipment: json["heavyEquipment"] ?? '',
        heavyEquipmentCapacity: json["heavyEquipmentCapacity"] ?? '',
        heavyEquipmentAmount: json["heavyEquipmentAmount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workPermitId": workPermitId,
        "toolName": toolName,
        "toolAmount": toolAmount,
        "material": material,
        "materialAmount": materialAmount,
        "heavyEquipment": heavyEquipment,
        "heavyEquipmentCapacity": heavyEquipmentCapacity,
        "heavyEquipmentAmount": heavyEquipmentAmount,
      };
}

class SafetyEquipment {
  final int id;
  final String workPermitId;
  final String equipmentName;
  final String type;
  final String note;

  SafetyEquipment({
    required this.id,
    required this.workPermitId,
    required this.equipmentName,
    required this.type,
    required this.note,
  });

  factory SafetyEquipment.fromJson(Map<String, dynamic> json) =>
      SafetyEquipment(
        id: json["id"] ?? 0,
        workPermitId: json["workPermitId"] ?? '',
        equipmentName: json["equipmentName"] ?? '',
        type: json["type"] ?? '',
        note: json["note"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workPermitId": workPermitId,
        "equipmentName": equipmentName,
        "type": type,
        "note": note,
      };
}
