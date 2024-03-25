import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/route_name.dart';

class WorkPermitView extends StatelessWidget {
  const WorkPermitView({super.key});

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
            child: Padding(padding: EdgeInsets.all(20)),
          )),
      ),
    );
  }
}