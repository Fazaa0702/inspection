import 'package:einspection/views/feature/work_permit/work_permit_log_data.dart';
import 'package:flutter/material.dart';
import 'package:einspection/export.dart';
import 'package:get/get.dart';

class WorkPermitLog extends StatelessWidget {
  WorkPermitLog({super.key});

  final workPermitController = Get.put(WorkPermitController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: workPermitController.searchFieldController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                ),
                onChanged: (String value) {
                  workPermitController.onKeywordChange(value);
                },
              ),
            ),
          ],
        ),
        const Padding(padding: EdgeInsets.all(10)),
        Obx(() {
          if (workPermitController.isLoadData.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF47B347),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: PaginatedDataTable(
                columns: const [
                  DataColumn(label: Text('No. Registrasi')),
                  DataColumn(label: Text('Tgl Pengajuan')),
                  DataColumn(label: Text('Nama Perusahaan')),
                  DataColumn(label: Text('Lokasi/BU')),
                  DataColumn(label: Text('Nama Pekerjaan')),
                  DataColumn(label: Text('Tanggal Mulai')),
                  DataColumn(label: Text('Tanggal Berakhir')),
                  DataColumn(label: Center(child: Text('Status'))),
                  DataColumn(label: Text('Worker')),
                ],
                source: WorkPermitLogData(workPermitController.workPermitLog),
              ),
            );
          }
        }),
      ],
    );
  }
}
