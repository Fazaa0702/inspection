import 'package:einspection/views/feature/work_permit/detail_work_permit_view.dart';
import 'package:einspection/views/feature/work_permit/worker_list.dart';
import 'package:flutter/material.dart';
import 'package:einspection/export.dart';
import 'package:get/get.dart';

class WorkPermitLogData extends DataTableSource {
  // final workPermitController = Get.put(WorkPermitController());

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
          Get.to(() => DetailWorkPermitView(
              workPermitId: workPermitLog.registrationNumber));
        },
      ),
      DataCell(Text(workPermitLog.requestDate)),
      DataCell(Text(workPermitLog.companyName)),
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
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )),
      DataCell(Column(
        children: [
          IconButton(
              onPressed: () {
                Get.to(() =>
                    WorkerList(workPermitId: workPermitLog.registrationNumber));
              },
              icon: const Icon(
                Icons.people,
                color: Colors.blue,
              )),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _workPermitLog.length;

  @override
  int get selectedRowCount => _selectedCount;

  // List<WorkPermitModel> get filteredWorkPermitLog {
  //   final query = workPermitController.searchQuery.value.toLowerCase();
  //   return _workPermitLog.where((workPermit) {
  //     return workPermit.registrationNumber.toLowerCase().contains(query) ||
  //         workPermit.companyName.toLowerCase().contains(query) ||
  //         workPermit.location.toLowerCase().contains(query) ||
  //         workPermit.jobName.toLowerCase().contains(query) ||
  //         workPermit.startDate.toLowerCase().contains(query) ||
  //         workPermit.endDate.toLowerCase().contains(query) ||
  //         workPermit.status.toLowerCase().contains(query);
  //   }).toList();
  // }
}
