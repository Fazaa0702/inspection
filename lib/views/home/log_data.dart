import 'package:einspection/export.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class LogData extends DataTableSource {
  final List<LogModel> _logs;

  LogData(this._logs);

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
      DataCell(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color: (log.description == 'Submitted')
              ? Colors.green
              : Colors.amberAccent,
        ),
        padding: const EdgeInsets.all(8),
        width: 90,
        child: Text(
          log.description,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: (log.description == 'Submitted')
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.bold),
        ),
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _logs.length;

  @override
  int get selectedRowCount => 0;
}
