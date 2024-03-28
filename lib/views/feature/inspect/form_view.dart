import 'dart:convert';

import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/feature/inspect/form_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:einspection/global_var.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  final FormController controller = Get.put(FormController());

  late int inspectionId = 0;
  late int departmentId = 0;
  late String itemId = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CommonAppBar(
            title: 'Input Forms',
            backButton: () {
              CommonDialog().confirmDialog(
                  'Confirm',
                  'Are you going to exit the form',
                  'The data you entered will be deleted', () {
                Get.offAllNamed(RouteName.inspection);
              });
            }),
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
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF47B347),
                            ),
                          )
                        : Center(
                            child: DropdownButtonFormField<DeptModel>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF47B347))),
                                hintText: 'Departments',
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
                                controller.item.clear();
                                controller.questions.clear();
                                controller.inspect.clear();
                                controller.fetchInspectionData();
                                controller.fetchItemData(
                                    inspectionId, departmentId);
                              },
                            ),
                          ),
                  ),
                ),
                if (departmentId != 0)
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Obx(
                      () => controller.inspect.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xFF47B347),
                              ),
                            )
                          : Center(
                              child: DropdownButtonFormField<InspectionModel>(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Color(0xFF47B347))),
                                  hintText: 'Inspections',
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      overflow: TextOverflow.clip),
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
                                    child: SizedBox(
                                      width: Get.width * 0.75,
                                      child: Text(
                                        inspect.name,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (InspectionModel? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      inspectionId = newValue.id;
                                    });
                                    print('insID: $inspectionId');
                                    print('DeptID: $departmentId');
                                    controller.questions.clear();
                                    controller.item.clear();
                                    controller.fetchItemData(
                                        inspectionId, departmentId);
                                  }
                                },
                              ),
                            ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Obx(
                    () => controller.item.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF47B347),
                            ),
                          )
                        : Center(
                            child: DropdownButtonFormField<ItemModel>(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                        color: Color(0xFF47B347))),
                                hintText: 'Items',
                                hintStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              // value: controller.inspect[0],
                              // onTap: () => controller.fetchDeptData(),
                              items: controller.item.map((ItemModel item) {
                                return DropdownMenuItem<ItemModel>(
                                  value: item,
                                  child: Text(item.itemName),
                                );
                              }).toList(),
                              onChanged: (ItemModel? newValue) {
                                CommonDialog().confirmDialog(
                                    'Confirm',
                                    'Is the selected data correct ?',
                                    'Changes can delete the data you have entered previously',
                                    () {
                                  if (newValue != null) {
                                    setState(() {
                                      a = jsonEncode(newValue);
                                      itemId = newValue.itemId;
                                    });
                                    controller.questions.clear();
                                    controller.fetchQuestionData(inspectionId);
                                    controller
                                        .fetchOptionConditions(inspectionId);
                                    print('itemID: $itemId');
                                    print('DeptID: $departmentId');
                                    print('InsID: $inspectionId');
                                    Get.back();
                                  }
                                });
                              },
                            ),
                          ),
                  ),
                ),
                FormSection(
                  departmentId: departmentId,
                  inspectionId: inspectionId,
                  itemId: itemId,
                ),
              ],
            ),
          ),
        ));
  }
}
