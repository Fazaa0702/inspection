import 'package:einspection/component/common_app_bar.dart';
import 'package:einspection/controllers/controller.dart';
import 'package:einspection/models/detail_work_permit_model.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailWorkPermitView extends StatelessWidget {
  final String workPermitId;
  DetailWorkPermitView({super.key, required this.workPermitId});

  final workPermitController = Get.put(WorkPermitController());

  @override
  Widget build(BuildContext context) {
    workPermitController.fetchDetailWorkPermit(workPermitId);
    return Scaffold(
      appBar: CommonAppBar(
          title: 'Work Permit Detail',
          backButton: () => Get.offAllNamed(RouteName.workPermit)),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.all(5)),
                const Text(
                  'IZIN MELAKUKAN PEKERJAAN (PMI/KONTRAKTOR)',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
                const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                    child: Text(
                      'PERMIT TO WORK (PMI/CONTRACTOR)',
                      style: TextStyle(
                          fontSize: 11,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'PT Panasonic Manufacturing Indonesia',
                    style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.all(8)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                workPermitController.detailWorkPermit.length,
                            itemBuilder: ((context, index) {
                              final detailWorkPermit =
                                  workPermitController.detailWorkPermit[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Nomor Registrasi : ${detailWorkPermit.regNum}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      'Tanggal Pengajuan : ${detailWorkPermit.requestDate}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      'Nama Pekerjaan : ${detailWorkPermit.jobName}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500)),
                                ],
                              );
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          color: Colors.black,
                          height: 50,
                          child: const Center(
                              child: Text(
                            'Klasifikasi Pekerjaan',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                workPermitController.jobClassification.length,
                            itemBuilder: ((context, index) {
                              final jobClassification =
                                  workPermitController.jobClassification[index];
                              return Text(
                                  '- ${jobClassification.jobClassificationName}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500));
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          color: Colors.black,
                          height: 50,
                          child: const Center(
                              child: Text(
                            'Peralatan Keselamatan',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                workPermitController.safetyEquipment.length,
                            itemBuilder: ((context, index) {
                              final safetyEquipment =
                                  workPermitController.safetyEquipment[index];
                              return Text(
                                  '- ${safetyEquipment.equipmentName}(${safetyEquipment.type})',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500));
                            })),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          color: Colors.black,
                          height: 50,
                          child: const Center(
                              child: Text(
                            'Dekat Area Berbahaya',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: workPermitController.highRiskArea.length,
                            itemBuilder: ((context, index) {
                              final highRiskArea =
                                  workPermitController.highRiskArea[index];
                              return Text('- ${highRiskArea.riskArea}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500));
                            })),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
