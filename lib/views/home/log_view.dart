import 'package:einspection/export.dart';
import 'package:einspection/views/home/log_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogView extends StatelessWidget {
  LogView({super.key});

  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (homeController.isLoading.value) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(
              color: Color(0xFF47B347),
            ),
          ),
        );
      } else {
        return SingleChildScrollView(
          child: PaginatedDataTable(
              availableRowsPerPage: const [
                5,
                10,
                25,
              ],
              onRowsPerPageChanged: (int? rowsPerPage) {
                if (rowsPerPage != null) {
                  homeController.updateRowsPerPage(rowsPerPage);
                }
              },
              rowsPerPage: homeController.rowsPerPage.value,
              columns: const [
                DataColumn(label: Text('Id')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Inspection')),
                DataColumn(label: Text('Ispector')),
                DataColumn(label: Text('BU')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('PIC')),
                DataColumn(label: Text('Item')),
                DataColumn(label: Text('Activity')),
              ],
              source: LogData(homeController.log)),
        );
      }
    });
  }
}
