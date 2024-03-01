import 'dart:convert';
import 'dart:html';

import 'package:einspection/component/common_dialog.dart';
import 'package:einspection/component/common_form_field.dart';
import 'package:einspection/component/common_snackbar.dart';
import 'package:einspection/models/answer_model.dart';
import 'package:einspection/models/option_condition_model.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/feature/inspect/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:einspection/global_var.dart';
import '../../../controllers/feature/inspect/form_controller.dart';
import '../../../models/question_answer_model.dart';
import '../../../models/question_model.dart';

class FormSection extends StatefulWidget {
  final int departmentId;
  final int inspectionId;
  final String itemId;
  const FormSection({
    super.key,
    required this.departmentId,
    required this.inspectionId,
    required this.itemId,
  });

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final FormController formController = Get.put(FormController());
  final _formKey = GlobalKey<FormState>();
  late QuestionAnswerModel currentAnswer;
  List<QuestionAnswerModel> answers = [];

  var image = '';
  var description = '';
  var recommendation = '';

  final Map<String, TextEditingController> textControllers = {};
  final Map<String, TextEditingController> descriptionTextController = {};
  final Map<String, TextEditingController> recommendationTextController = {};
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
              if (widget.inspectionId != 0 &&
                  widget.departmentId != 0 &&
                  widget.itemId != '')
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('itemiddddd: ${widget.itemId}');
                        if (_formKey.currentState!.validate()) {
                          CommonDialog().confirmDialog(
                              'Konfirmasi',
                              'Apakah anda yakin ?',
                              'Data yang anda inputkan akan terkirim di web',
                              () async {
                            final SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            var dataUser = prefs.getString("user").toString();
                            Map<String, dynamic> userData =
                                json.decode(dataUser);
                            List<Map<String, dynamic>> answersMapList =
                                answers.map((obj) => obj.toJson()).toList();

                            // Convert the list of Map<String, dynamic> to a JSON string
                            String jsonDataQuestionanswers =
                                jsonEncode(answersMapList);
                            var itemData = json.decode(a);

                            print("data user : ${userData['id']}");
                            print(
                                "ini value dept n inspect : ${widget.departmentId}, ${widget.inspectionId}");
                            late AnswerModel answerModel = AnswerModel(
                                userId: userData['id'],
                                departmentId: widget.departmentId.toInt(),
                                inspectionId: widget.inspectionId.toInt(),
                                questionAnswers: jsonDataQuestionanswers,
                                picItemId: itemData["picItemId"],
                                itemId: widget.itemId);
                            formController.submitAnswerCondition(answerModel);
                            print('Answers: ${jsonEncode(answers)}');
                            CommonSnackbar.successSnackbar(
                                'Success', 'The answer has been sent');
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

    var initValue = "";

    var itemData = json.decode(a);
    switch (questionText) {
      case "Lokasi Penempatan":
        initValue = itemData["location"];
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        int index = answers
            .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
        print("index : $index");
        if (index != -1) {
          // Jika sudah ada, ganti data yang lama dengan yang baru
          answers[index] = currentAnswer;
        } else {
          // Jika belum ada, tambahkan data baru
          answers.add(currentAnswer);
        }
        break;
      case "Tanggal Terakhir Pengecekan":
        initValue =
            itemData["lastInspection"] ?? DateTime.now().toIso8601String();
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        int index = answers
            .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
        print("index : $index");
        if (index != -1) {
          // Jika sudah ada, ganti data yang lama dengan yang baru
          answers[index] = currentAnswer;
        } else {
          // Jika belum ada, tambahkan data baru
          answers.add(currentAnswer);
        }
        break;
      case "Nomor Apar":
        initValue = itemData["number"] ?? "0";
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        int index = answers
            .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
        print("index : $index");
        if (index != -1) {
          // Jika sudah ada, ganti data yang lama dengan yang baru
          answers[index] = currentAnswer;
        } else {
          // Jika belum ada, tambahkan data baru
          answers.add(currentAnswer);
        }
        break;
      case "Model/Type":
        initValue = itemData["modelOrType"] ?? "0";
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        int index = answers
            .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
        print("index : $index");
        if (index != -1) {
          // Jika sudah ada, ganti data yang lama dengan yang baru
          answers[index] = currentAnswer;
        } else {
          // Jika belum ada, tambahkan data baru
          answers.add(currentAnswer);
        }
        break;
      case "Jumlah Pengecekan":
        initValue = itemData["jumlahPengecekan"] ?? "0";
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        int index = answers
            .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
        print("index : $index");
        if (index != -1) {
          // Jika sudah ada, ganti data yang lama dengan yang baru
          answers[index] = currentAnswer;
        } else {
          // Jika belum ada, tambahkan data baru
          answers.add(currentAnswer);
        }
        break;
    }

    switch (questionType) {
      case 'Text':
        return CommonFormField(
          initValue: initValue,
          question: questionText,
          readOnly: (questionText == "Lokasi Penempatan" ||
                  questionText == 'Tanggal Terakhir Pengecekan' ||
                  questionText == 'Jumlah Pengecekan' ||
                  questionText == 'Nomor Apar' ||
                  questionText == 'Model/Type')
              ? true
              : false,
          controller: textControllers[questionId],
          onChanged: (value) {
            setState(() {
              currentAnswer = QuestionAnswerModel(
                questionId: question.id,
                answerText: value,
              );
            });
            int index = answers
                .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
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
              children: formController.option.map((optionCondition) {
                return buildRadio(questionId, optionCondition, null);
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget buildRadio(
      String questionId, OptionConditionModel option, String? imageBase64) {
    bool isSelected =
        formController.selectedValue[questionId]?.value == option.condition;

    return Column(
      children: [
        Row(
          children: [
            Radio(
              activeColor: const Color(0xFF47B347),
              value: option.condition, //required
              groupValue:
                  formController.selectedValue[questionId]?.value, //required
              onChanged: (value) {
                var cek = false;
                if (option.condition != '') {
                  cek = true;
                }
                print('cekkkkkkk: $cek');
                print(questionId);

                setState(() {
                  currentAnswer = QuestionAnswerModel(
                    questionId: questionId,
                    answerText: option.condition,
                  );
                });
                print("QID: $questionId");
                print('nilai: ${option.condition}');
                print("Cekkkk: $imageBase64");
                formController.setSelectedValue(questionId, value.toString());

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
              },
            ),
            Text(
              option.condition,
            ),
          ],
        ),
        if (isSelected && option.isNeedNcr == true)
          Column(
            children: [
              ImagePickerSection(
                initValue: imageBase64,
                textEditingController: textControllers[questionId],
                onImageSelected: (imageBase64) async {
                  image = imageBase64;
                  setState(() {
                    currentAnswer = QuestionAnswerModel(
                      questionId: questionId,
                      answerText: option.condition,
                      imageBase64: option.isNeedNcr == true ? image : '',
                    );
                  });
                  int index = answers.indexWhere(
                      (qa) => qa.questionId == currentAnswer.questionId);
                  if (index != -1) {
                    setState(() {
                      answers[index] = currentAnswer;
                    });
                  } else {
                    setState(() {
                      answers.add(currentAnswer);
                    });
                  }
                },
              ),
              const Padding(padding: EdgeInsets.only(top: 10)),
              CommonFormField(
                question: 'Description',
                readOnly: false,
                controller: descriptionTextController[questionId],
                onChanged: (value) {
                  description = value;
                  setState(() {
                    currentAnswer = QuestionAnswerModel(
                      questionId: questionId,
                      answerText: option.condition,
                      imageBase64: image,
                      description: option.isNeedNcr == true ? description : '',
                    );
                  });
                  int index = answers.indexWhere(
                      (qa) => qa.questionId == currentAnswer.questionId);
                  if (index != -1) {
                    setState(() {
                      answers[index] = currentAnswer;
                    });
                  } else {
                    setState(() {
                      answers.add(currentAnswer);
                    });
                  }
                },
              ),
              CommonFormField(
                question: 'Recommendation',
                readOnly: false,
                controller: recommendationTextController[questionId],
                onChanged: (value) {
                  recommendation = value;
                  setState(() {
                    currentAnswer = QuestionAnswerModel(
                      questionId: questionId,
                      answerText: option.condition,
                      imageBase64: image,
                      description: description,
                      recommendation:
                          option.isNeedNcr == true ? recommendation : '',
                    );
                  });
                  int index = answers.indexWhere(
                      (qa) => qa.questionId == currentAnswer.questionId);
                  if (index != -1) {
                    setState(() {
                      answers[index] = currentAnswer;
                    });
                  } else {
                    setState(() {
                      answers.add(currentAnswer);
                    });
                  }
                },
              ),
            ],
          ),
      ],
    );
  }
}
