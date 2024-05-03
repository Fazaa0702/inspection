class WorkPermitModel {
  final String registrationNumber;
  final String companyName;
  final String requestDate;
  final String location;
  final String jobName;
  final String startDate;
  final String endDate;
  final String status;

  WorkPermitModel({
    required this.registrationNumber,
    required this.companyName,
    required this.requestDate,
    required this.location,
    required this.jobName,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory WorkPermitModel.fromJson(Map<String, dynamic> json) =>
      WorkPermitModel(
        registrationNumber: json["registrationNumber"] ?? '-',
        companyName: json["companyName"] ?? '-',
        requestDate: json["requestDate"] ?? '-',
        location: json["location"] ?? '-',
        jobName: json["jobName"] ?? '-',
        startDate: json["startDate"] ?? '-',
        endDate: json["endDate"] ?? '-',
        status: json["status"] ?? '-',
      );

  Map<String, dynamic> toJson() => {
        "registrationNumber": registrationNumber,
        "companyName": companyName,
        "requestDate": requestDate,
        "location": location,
        "jobName": jobName,
        "startDate": startDate,
        "endDate": endDate,
        "status": status,
      };
}
