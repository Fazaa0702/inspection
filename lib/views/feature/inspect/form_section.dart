import 'dart:convert';

import 'package:einspection/component/common_dialog.dart';
import 'package:einspection/component/common_snackbar.dart';
import 'package:einspection/models/answer_model.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/feature/inspect/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/feature/inspect/form_controller.dart';
import '../../../models/question_answer_model.dart';
import '../../../models/question_model.dart';

class FormSection extends StatefulWidget {
  final int departmentId;
  final int inspectionId;
  const FormSection({
    super.key,
    required this.departmentId,
    required this.inspectionId,
  });

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final FormController formController = Get.put(FormController());
  // final Map<String, bool> idSentStatus = {};
  final _formKey = GlobalKey<FormState>();

  late QuestionAnswerModel currentAnswer;

  List<QuestionAnswerModel> answers = [];

  final Map<String, TextEditingController> textControllers = {};

  @override
  void initState() {
    super.initState();
    currentAnswer = QuestionAnswerModel(questionId: '', answerText: '');
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Form(
      key: _formKey,
      child: Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: [
              Obx(
                () => Column(
                  children: formController.questions
                      .map((question) => buildFormField(question))
                      .toList(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {

                      // ignore: unrelated_type_equality_checks
                      if (_formKey.currentState!.validate()) {
                        CommonDialog().confirmDialog(
                            'Konfirmasi',
                            'Apakah anda yakin ?',
                            'Data yang anda inputkan akan terkirim di web',
                            () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var dataUser = prefs.getString("user").toString();
                          Map<String, dynamic> userData = json.decode(dataUser);
                          List<Map<String, dynamic>> answersMapList =
                              answers.map((obj) => obj.toJson()).toList();

                          // Convert the list of Map<String, dynamic> to a JSON string
                          String json_data_questionAnswers =
                              jsonEncode(answersMapList);

                          print("data user : ${userData['id']}");
                          print(
                              "ini value dept n inspect : ${widget.departmentId}, ${widget.inspectionId}");
                          late AnswerModel answerModel = AnswerModel(
                              userId: userData['id'],
                              departmentId: widget.departmentId.toInt(),
                              inspectionId: widget.inspectionId.toInt(),
                              questionAnswers: json_data_questionAnswers);
                          formController.submitAnswerCondition(answerModel);
                          print('Answers: ${jsonEncode(answers)}');
                          Get.offAllNamed(RouteName.home);
                        });
                      } else {
                        CommonSnackbar.failedSnackbar(
                            'Gagal', 'Semua pertanyaan harus terjawab');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF47B347),
                        fixedSize: Size(Get.width, 40)),
                    child: const Text('Submit',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins')),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget buildFormField(QuestionModel question) {
    final questionText = question.questionText;
    final questionType = question.questionType;
    final questionId = question.id;

    switch (questionType) {
      case 'Text':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 3),
              child: Text(
                questionText,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ),
            TextFormField(
              maxLength: 100,
              controller: textControllers[questionId],
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter a value';
              //   }
              //   return null;
              // },
              onChanged: (value) {
                print("textController : ${textControllers[questionId]?.text}");
                setState(() {
                  currentAnswer = QuestionAnswerModel(
                    questionId: question.id,
                    answerText: value,
                  );
                });
                int index = answers.indexWhere(
                    (qa) => qa.questionId == currentAnswer.questionId);
                print("index : $index");
                if (index != -1) {
                  // Jika sudah ada, ganti data yang lama dengan yang baru
                  setState(() {
                    answers[index] = currentAnswer;
                  });
                } else {
                  // Jika belum ada, tambahkan data baru
                  setState(() {
                    answers.add(currentAnswer);
                  });
                }
                print("answers : ${answers[0].answerText}");
              },
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins'),
              // maxLines: null,
              cursorColor: const Color(0xFF47B347),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: Color(0xFF47B347)))),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
          ],
        );
      case 'Option Condition':
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, bottom: 3),
              child: Text(
                questionText,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ),
            Column(
              children: [
                buildRadio(questionId, 'Baik', currentAnswer.imageBase64),
                buildRadio(questionId, 'Tidak baik', currentAnswer.imageBase64),
                if (formController.selectedValue[questionId]?.value ==
                    'Tidak baik')
                  ImagePickerSection(
                    textEditingController: textControllers[questionId],
                    onImageSelected: (imageBase64) {
                      String nilai =
                          formController.selectedValue[questionId]?.value ?? '';
                      setState(() {
                        currentAnswer = QuestionAnswerModel(
                          questionId: questionId,
                          answerText: nilai,
                          imageBase64:
                              nilai == 'Tidak baik' ? imageBase64 : null,
                        );
                      });
                      int index = answers.indexWhere(
                          (qa) => qa.questionId == currentAnswer.questionId);
                      print("index : $index");
                      print(
                          "nilai : ${formController.selectedValue[questionId]?.value}");
                      if (index != -1) {
                        // Jika sudah ada, ganti data yang lama dengan yang baru
                        setState(() {
                          answers[index] = currentAnswer;
                        });
                      } else {
                        // Jika belum ada, tambahkan data baru
                        setState(() {
                          answers.add(currentAnswer);
                        });
                      }
                      print("QID: $questionId");
                      print('nilai: $nilai');
                      print("Cekkkk: $imageBase64");
                    },
                  ),
                buildRadio(
                    questionId, 'Tidak pakai', currentAnswer.imageBase64),
              ],
            ),
            const SizedBox(height: 20),
          ],
        );
      default:
        // Handle other question types as needed
        return const SizedBox.shrink();
    }
  }

  String? validateRadio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option';
    }
    return null;
  }

  Widget buildRadio(String questionId, String nilai, String? imageBase64) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xFF47B347),
          value: nilai,
          groupValue: formController.selectedValue[questionId]?.value,
          onChanged: (value) {
            print(questionId);

            setState(() {
              currentAnswer = QuestionAnswerModel(
                questionId: questionId,
                answerText: nilai,
              );
            });
            print("QID: $questionId");
            print('nilai: $nilai');
            print("Cekkkk: $imageBase64");
            formController.setSelectedValue(questionId, value.toString());

            int index = answers
                .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
            print("index : $index");
            print("nilai : ${formController.selectedValue[questionId]?.value}");
            if (index != -1) {
              // Jika sudah ada, ganti data yang lama dengan yang baru
              setState(() {
                answers[index] = currentAnswer;
              });
            } else {
              // Jika belum ada, tambahkan data baru
              setState(() {
                answers.add(currentAnswer);
              });
            }

            // setState(() {
            //   _isAllRadioSelected = answers
            //           .where((qa) => qa.questionId.startsWith('radio_'))
            //           .length ==
            //       formController.questions
            //           .where((q) => q.questionType == 'Option Condition')
            //           .length;
            // });
          },
        ),
        Text(
          nilai,
        ),
      ],
    );
  }
}
