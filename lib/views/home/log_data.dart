import 'package:einspection/controllers/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/log_model.dart';

class LogData extends DataTableSource {
  final List<LogModel> _logs;
  final HomeController _logController;
  LogData(this._logs, this._logController);
  

  @override
  DataRow? getRow(int index) {
    if (index >= _logs.length) {
      return null;
    }
    final log = _logs[index];
    String formattedDateTime =
        DateFormat('dd-MM-yyyy HH:mm:ss').format(log.time);

    return DataRow(cells: [
      DataCell(Text(formattedDateTime)),
      DataCell(Text(log.inspectionId.toString())),
      DataCell(Text(log.userId)),
      DataCell(Text(log.departmentId.toString())),
      DataCell(Text(log.itemId)),
      DataCell(Text(log.description)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _logs.length;

  @override
  int get selectedRowCount => 0;
}
