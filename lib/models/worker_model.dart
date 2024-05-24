class WorkerModel {
  int id;
  String workPermitId;
  String name;
  String speciality;
  String certification;
  String nik;

  WorkerModel({
    required this.id,
    required this.workPermitId,
    required this.name,
    required this.speciality,
    required this.certification,
    required this.nik,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) => WorkerModel(
        id: json["id"] ?? 0,
        workPermitId: json["workPermitId"] ?? '',
        name: json["name"] ?? '',
        speciality: json["speciality"] ?? '-',
        certification: json["certification"] ?? '-',
        nik: json["nik"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workPermitId": workPermitId,
        "name": name,
        "speciality": speciality,
        "certification": certification,
        "nik": nik,
      };
}