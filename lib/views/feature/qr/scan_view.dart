import 'package:einspection/controllers/feature/inspect/scan_controller.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanView extends GetView<ScanController> {
  const ScanView({super.key});

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
                    Get.offAllNamed(RouteName.inspection);
                  },
                  icon: const Icon(Icons.arrow_back)),
              const Text(
                'e-Inspection',
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
                padding: const EdgeInsets.only(
                    top: 150, bottom: 100, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/scanView1.png'),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    const Text(
                      'Scan a QR code from inspection item',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins'),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
