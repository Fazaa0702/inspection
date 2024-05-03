import 'package:flutter/material.dart';
import 'package:einspection/export.dart';
import 'package:get/get.dart';

import '../../../controllers/feature/work_permit/worker_controller.dart';
import '../../../routes/route_name.dart';

class WorkerView extends StatelessWidget {
  final String workPermitId;
  WorkerView({
    required this.workPermitId,
    super.key,
  });

  final workerController = Get.put(WorkerController());

  @override
  Widget build(BuildContext context) {
    workerController.fetchWorkerData(workPermitId);
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Worker(ID: $workPermitId)',
          backButton: () {
            Get.offAllNamed(RouteName.workPermit);
          },
        ),
        body: Obx(() {
          if (workerController.worker.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF47B347),
              ),
            );
          }
          print(workerController.worker);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
                itemCount: workerController.worker.length,
                itemBuilder: ((context, index) {
                  final worker = workerController.worker[index];
                  return InkWell(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 3,
                            blurRadius: 7,
                            blurStyle: BlurStyle.outer)
                      ], borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        title: Text(worker.name,
                            style: const TextStyle(fontFamily: 'Poppins')),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Id: ${worker.id}',
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                            Text(
                              'Speciality: ${worker.speciality}',
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                            Text('Certification: ${worker.certification}',
                                style: const TextStyle(fontFamily: 'Poppins')),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          );
        }));
  }
}
