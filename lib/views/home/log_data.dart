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
    String formattedDateTime = DateFormat('dd-MM-yyyy').format(log.dateTime);

    return DataRow(cells: [
      // DataCell(Text(log.id)),
      DataCell(Text(formattedDateTime)),
      DataCell(Text(log.inspectionName)),
      DataCell(Text(log.inspectorName)),
      DataCell(Text(log.buName)),
      DataCell(Text(log.location)),
      DataCell(Text(log.pic)),
      DataCell(Text(log.itemName)),
      DataCell(Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          color:
              (log.activity == 'Submitted') ? Colors.green : Colors.amberAccent,
        ),
        padding: const EdgeInsets.all(8),
        width: 90,
        child: Text(
          log.activity,
          textAlign: TextAlign.center,
          style: TextStyle(
              color:
                  (log.activity == 'Submitted') ? Colors.white : Colors.black,
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
