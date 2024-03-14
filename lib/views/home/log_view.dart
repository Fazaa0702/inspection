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
        return const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF47B347),
          ),
        );
      } else {
        return SingleChildScrollView(
          child: PaginatedDataTable(
              rowsPerPage: 7,
              columns: const [
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Inspection')),
                DataColumn(label: Text('Ispector')),
                DataColumn(label: Text('BU')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Activity')),
              ],
              source: LogData(homeController.log)),
        );
      }
    });
  }
}
