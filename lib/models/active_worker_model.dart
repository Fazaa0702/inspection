class ActiveWorkerModel {
  final Description description;
  final List<Worker> worker;

  ActiveWorkerModel({
    required this.description,
    required this.worker,
  });

  factory ActiveWorkerModel.fromJson(Map<String, dynamic> json) =>
      ActiveWorkerModel(
          description: json["description"],
          worker:
              List<Worker>.from(json['worker'].map((x) => Worker.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "description": description.toJson(),
        "worker": List<dynamic>.from(worker.map((x) => x.toJson())),
      };
}

class Description {
  final String regNum;
  final String title;
  final String compName;
  final String location;
  final String start;
  final String end;

  Description({
    required this.regNum,
    required this.title,
    required this.compName,
    required this.location,
    required this.start,
    required this.end,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        regNum: json["regNum"],
        title: json["title"],
        compName: json["compName"],
        location: json["location"],
        start: json["start"],
        end: json["end"],
      );

  Map<String, dynamic> toJson() => {
        "regNum": regNum,
        "title": title,
        "compName": compName,
        "location": location,
        "start": start,
        "end": end,
      };
}

class Worker {
  final int id;
  final String regNum;
  final String name;
  final String inTime;
  final String outTime;

  Worker({
    required this.id,
    required this.regNum,
    required this.name,
    required this.inTime,
    required this.outTime,
  });

  factory Worker.fromJson(Map<String, dynamic> json) => Worker(
        id: json["id"],
        regNum: json["regNum"],
        name: json["name"],
        inTime: json["inTime"],
        outTime: json["outTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "regNum": regNum,
        "name": name,
        "inTime": inTime,
        "outTime": outTime,
      };
}
