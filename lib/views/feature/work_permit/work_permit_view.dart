import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../export.dart';
import '../../../routes/route_name.dart';

class WorkPermitView extends StatelessWidget {
  WorkPermitView({super.key});

  final workPermitController = Get.put(WorkPermitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: const Color(0xFF32A632),
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.offAllNamed(RouteName.home);
                },
                icon: const Icon(Icons.arrow_back)),
            const Text(
              'Work Permit',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
        titleSpacing: 10,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                        onTap: () async {
                          final DateTime? pickedTime = await showDatePicker(
                              initialEntryMode: DatePickerEntryMode.calendar,
                              initialDate:
                                  workPermitController.selectedDate.value ??
                                      DateTime.now(),
                              context: context,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());

                          if (pickedTime != null) {
                            workPermitController.pickDate(pickedTime);
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff89D3EA),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(9),
                          child: const Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                          ),
                        )),
                    const Padding(padding: EdgeInsets.only(left: 8)),
                    Obx(() => Text(
                          'Date: ${DateFormat('dd MMMM yyyy').format(workPermitController.selectedDate.value!)}',
                          style: const TextStyle(fontFamily: 'Poppins'),
                        ))
                  ],
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
