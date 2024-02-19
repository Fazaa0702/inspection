import 'package:einspection/component/common_dialog.dart';
import 'package:einspection/controllers/feature/inspect/form_controller.dart';
import 'package:einspection/models/dept_model.dart';
import 'package:einspection/models/inspection_model.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/feature/inspect/form_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final FormController controller = Get.put(FormController());

  late int inspectionId = 0;
  late int departmentId = 0;

  @override
  void initState() {
    super.initState();
  }

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
                    CommonDialog().confirmDialog(
                        'Konfirmasi',
                        'Anda akan keluar dari form',
                        'Data yang anda inputkan akan terhapus', () {
                      Get.offAllNamed(RouteName.inspection);
                    });
                  },
                  icon: const Icon(Icons.arrow_back)),
              const Text(
                'Input Forms',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
          titleSpacing: 10,
          iconTheme: const IconThemeData(color: Colors.white),
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         Color(0xFF47B347),
          //         Color(0xFF7FCC1E)
          //       ], // Set your gradient colors
          //     ),
          //   ),
          // ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 5),
                  child: Obx(
                    () => controller.dept.isEmpty
                        ? const CircularProgressIndicator(
                            color: Color(0xFF47B347),
                          )
                        : DropdownButtonFormField<DeptModel>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(
                                      color: Color(0xFF47B347))),
                              hintText: 'Departemen',
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            items: controller.dept.map((DeptModel dept) {
                              return DropdownMenuItem<DeptModel>(
                                value: dept,
                                child: Text(dept.name),
                              );
                            }).toList(),
                            onChanged: (DeptModel? newValue) {
                              controller.deptValue.value;
                              (newValue != null)
                                  ? setState(() {
                                      departmentId = newValue.id;
                                    })
                                  : null;
                            },
                          ),
                  ),
                ),
                if (departmentId != 0)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Obx(
                      () => controller.inspect.isEmpty
                          ? const CircularProgressIndicator(
                              color: Color(0xFF47B347),
                            )
                          : DropdownButtonFormField<InspectionModel>(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF47B347))),
                                hintText: 'Inspeksi',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              // value: controller.inspect[0],
                              // onTap: () => controller.fetchDeptData(),
                              items: controller.inspect
                                  .map((InspectionModel inspect) {
                                return DropdownMenuItem<InspectionModel>(
                                  value: inspect,
                                  child: Text(inspect.name),
                                );
                              }).toList(),
                              onChanged: (InspectionModel? newValue) {
                                if (newValue != null) {
                                  controller.fetchQuestionData(newValue.id);
                                  setState(() {
                                    inspectionId = newValue.id;
                                  });
                                  print(newValue.id);
                                }
                              },
                            ),
                    ),
                  ),
                FormSection(
                    departmentId: departmentId, inspectionId: inspectionId),
              ],
            ),
          ),
        ));
  }
}
