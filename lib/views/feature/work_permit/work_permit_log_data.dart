import 'package:einspection/views/feature/work_permit/worker_view.dart';
import 'package:flutter/material.dart';
import 'package:einspection/export.dart';
import 'package:get/get.dart';


class WorkPermitLogData extends DataTableSource {
  final List<WorkPermitModel> _workPermitLog;
  final int _selectedCount = 0;

  WorkPermitLogData(
    this._workPermitLog,
  );

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _workPermitLog.length) {
      return null;
    }
    final workPermitLog = _workPermitLog[index];

    return DataRow(cells: [
      DataCell(
        Text(
          workPermitLog.registrationNumber,
          style: const TextStyle(
            color: Colors.blue,
          ),
        ),
        onTap: () {
          Get.to(
              () => WorkerView(workPermitId: workPermitLog.registrationNumber));
        },
      ),
      DataCell(Text(workPermitLog.companyName)),
      DataCell(Text(workPermitLog.requestDate)),
      DataCell(Text(workPermitLog.location)),
      DataCell(Text(workPermitLog.jobName)),
      DataCell(Text(workPermitLog.startDate)),
      DataCell(Text(workPermitLog.endDate)),
      DataCell(Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90), color: Colors.green),
        padding: const EdgeInsets.all(8),
        width: 90,
        child: Text(
          workPermitLog.status,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )),
      DataCell(IconButton(
          onPressed: () {
            Get.to(() =>
                WorkerView(workPermitId: workPermitLog.registrationNumber));
          },
          icon: const Icon(
            Icons.info,
            color: Colors.blue,
          ))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _workPermitLog.length;

  @override
  int get selectedRowCount => _selectedCount;
}
