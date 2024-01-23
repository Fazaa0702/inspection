import 'package:einspection/controllers/feature/inspect/form_controller.dart';
import 'package:einspection/models/dept_model.dart';
import 'package:einspection/models/inspection_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormView extends GetView<FormController> {
  FormView({super.key});

  @override
  final FormController controller = Get.put(FormController());

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Inspeksi',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
          titleSpacing: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF47B347),
                  Color(0xFF7FCC1E)
                ], // Set your gradient colors
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25.0, bottom: 5),
                  child: Text(
                    'Departemen',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: Obx(
                    () => controller.dept.isEmpty
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField<DeptModel>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            value: controller.dept[0],
                            // onTap: () => controller.fetchDeptData(),
                            items: controller.dept.map((DeptModel dept) {
                              return DropdownMenuItem<DeptModel>(
                                value: dept,
                                child: Text(dept.name),
                              );
                            }).toList(),
                            onChanged: (DeptModel? newValue) {
                              controller.deptValue.value;
                            },
                          ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0, top: 15, bottom: 5),
                  child: Text(
                    'Inspeksi',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
                  child: Obx(
                    () => controller.inspect.isEmpty
                        ? const CircularProgressIndicator()
                        : DropdownButtonFormField<InspectionModel>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            value: controller.inspect[0],
                            // onTap: () => controller.fetchDeptData(),
                            items: controller.inspect
                                .map((InspectionModel inspect) {
                              return DropdownMenuItem<InspectionModel>(
                                value: inspect,
                                child: Text(inspect.name),
                              );
                            }).toList(),
                            onChanged: (InspectionModel? newValue) {
                              controller.inspectValue.value;
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
