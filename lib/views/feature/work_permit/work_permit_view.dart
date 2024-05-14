import 'package:einspection/views/feature/work_permit/work_permit_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../export.dart';
import '../../../routes/route_name.dart';

class WorkPermitView extends StatelessWidget {
  WorkPermitView({super.key});

  final workPermitController = Get.put(WorkPermitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Work Permit',
        backButton: () {
          Get.offAllNamed(RouteName.home);
        },
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: WorkPermitLog(),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
