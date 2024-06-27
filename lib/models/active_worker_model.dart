class ActiveWorkerModel {
  final List<WorkerActive> worker;

  ActiveWorkerModel({
    required this.worker,
  });

  factory ActiveWorkerModel.fromJson(Map<String, dynamic> json) =>
      ActiveWorkerModel(
          worker: List<WorkerActive>.from(
              json['worker'].map((x) => WorkerActive.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "worker": List<dynamic>.from(worker.map((x) => x.toJson())),
      };
}

class WorkerActive {
  final int id;
  final String regNum;
  final String name;
  final String inTime;
  final String outTime;

  WorkerActive({
    required this.id,
    required this.regNum,
    required this.name,
    required this.inTime,
    required this.outTime,
  });

  factory WorkerActive.fromJson(Map<String, dynamic> json) => WorkerActive(
        id: json["id"] ?? '',
        regNum: json["regNum"] ?? '',
        name: json["name"] ?? '',
        inTime: json["inTime"] ?? '',
        outTime: json["outTime"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regNum": regNum,
        "name": name,
        "inTime": inTime,
        "outTime": outTime,
      };
}
