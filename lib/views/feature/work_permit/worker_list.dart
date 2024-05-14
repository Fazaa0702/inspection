import 'package:flutter/material.dart';
import 'package:einspection/export.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controllers/feature/work_permit/worker_controller.dart';
import '../../../routes/route_name.dart';

class WorkerList extends StatelessWidget {
  final String workPermitId;
  WorkerList({
    required this.workPermitId,
    super.key,
  });

  final workerController = Get.put(WorkerController());
  final workPermitController = Get.put(WorkPermitController());

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

    workPermitController.fetchDetailWorkPermit(workPermitId);
    workerController.fetchWorkerData(workPermitId);
    workerController.fetchActiveWorkerData(workPermitId, date);
    return Scaffold(
        appBar: CommonAppBar(
          title: 'Worker (ID: $workPermitId)',
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
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Text('Active Worker List',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () async {
                            final DateTime? pickedTime = await showDatePicker(
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDate:
                                  workerController.selectedDate.value ??
                                      DateTime.now(),
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedTime != null) {
                              workerController.pickDate(pickedTime);
                              date = DateFormat('yyyy-MM-dd')
                                  .format(pickedTime)
                                  .toString();
                              print('Date: $date');
                              print(date);
                              print(workPermitId);
                            }
                            workerController.fetchActiveWorkerData(
                                workPermitId, date);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xff89D3EA),
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(9),
                            child: const Icon(
                              Icons.calendar_today,
                              color: Color(0xFF000000),
                            ),
                          )),
                      const Padding(padding: EdgeInsets.only(left: 8)),
                      Obx(() => Text(
                            'Date: ${DateFormat('yyyy-MM-dd').format(workerController.selectedDate.value!)}',
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ))
                    ],
                  ),
                ),
                (workerController.workerPerDay.isEmpty)
                    ? const Center(
                        child: Text('No Active Worker'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: workerController.workerPerDay.length,
                            itemBuilder: ((context, index) {
                              final worker =
                                  workerController.workerPerDay[index];
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
                                        style: const TextStyle(
                                            fontFamily: 'Poppins')),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Id: ${worker.id}',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins'),
                                        ),
                                        Text(
                                          'Speciality: ${worker.inTime}',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins'),
                                        ),
                                        Text('Certification: ${worker.outTime}',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins')),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Text('Worker List',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                                  style:
                                      const TextStyle(fontFamily: 'Poppins')),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Id: ${worker.id}',
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  Text(
                                    'Speciality: ${worker.speciality}',
                                    style:
                                        const TextStyle(fontFamily: 'Poppins'),
                                  ),
                                  Text('Certification: ${worker.certification}',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins')),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                ),
              ],
            ),
          );
        }));
  }
}
