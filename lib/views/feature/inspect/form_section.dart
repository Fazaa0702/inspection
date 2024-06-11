import 'dart:convert';
import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/feature/inspect/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:einspection/global_var.dart';

class FormSection extends StatefulWidget {
  final int departmentId;
  final int inspectionId;
  final String? itemId;
  const FormSection({
    super.key,
    required this.departmentId,
    required this.inspectionId,
    this.itemId,
  });

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final FormController formController = Get.put(FormController());
  final _formKey = GlobalKey<FormState>();
  late QuestionAnswerModel currentAnswer;

  var image = '';
  var description = '';
  var recommendation = '';
  var isSelected = true;

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
                    child: CommonButton(
                        text: 'Submit',
                        onPressed: () {
                          print('itemiddddd: ${widget.itemId}');
                          if (_formKey.currentState!.validate()) {
                            CommonDialog().confirmDialog(
                                'Confirm',
                                'Are you sure ?',
                                'The data you entered will be sent on the web',
                                () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              var dataUser = prefs.getString("user").toString();
                              Map<String, dynamic> userData =
                                  json.decode(dataUser);
                              List<Map<String, dynamic>> answersMapList =
                                  formController.answers
                                      .map((obj) => obj.toJson())
                                      .toList();

                              String jsonDataQuestionanswers =
                                  jsonEncode(answersMapList);
                              var itemData = json.decode(a);
                              print(
                                  'Pengecekannnnn: ${itemData["jumlahPengecekan"]}');
                              print("data user : ${userData['id']}");
                              print(
                                  "ini value dept n inspect : ${widget.departmentId}, ${widget.inspectionId}");
                              late AnswerModel answerModel = AnswerModel(
                                  userId: userData['id'],
                                  departmentId: widget.departmentId.toInt(),
                                  inspectionId: widget.inspectionId.toInt(),
                                  questionAnswers: jsonDataQuestionanswers,
                                  picItemId: itemData["picItemId"] ?? '',
                                  itemId: widget.itemId);
                              formController.submitAnswerCondition(answerModel);
                              print(
                                  'Answers: ${jsonEncode(formController.answers)}');
                              print('piccc: ${itemData["picItemId"]}');
                              CommonSnackbar.successSnackbar(
                                  'Success', 'The answer has been sent');
                              Get.offAllNamed(RouteName.home);
                            });
                          } else {
                            CommonSnackbar.failedSnackbar(
                                'Gagal', 'Semua pertanyaan harus terjawab');
                          }
                        }))
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
      case "Lokasi Penempatan Item":
        initValue = itemData["location"];
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        formController.inputAnswerCondition(
            formController.answers, currentAnswer);
        break;
      case "Tanggal Terakhir Pengecekan":
        initValue = itemData["lastInspection"] ?? '';
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        formController.inputAnswerCondition(
            formController.answers, currentAnswer);
        break;
      case "Nomor Item":
        initValue = itemData["number"] ?? "0";
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        formController.inputAnswerCondition(
            formController.answers, currentAnswer);
        break;
      case "Model/Type Item":
        initValue = itemData["modelOrType"] ?? "0";
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        formController.inputAnswerCondition(
            formController.answers, currentAnswer);
        break;
      case "Jumlah Pengecekan":
        initValue = (itemData["jumlahPengecekan"] ?? 0).toString();
        currentAnswer = QuestionAnswerModel(
          questionId: question.id,
          answerText: initValue,
        );
        formController.inputAnswerCondition(
            formController.answers, currentAnswer);
        break;
    }

    switch (questionType) {
      case 'Text':
        return CommonFormField(
          initValue: initValue,
          question: questionText,
          readOnly: (initValue == itemData["location"] ||
                  questionText == 'Tanggal Terakhir Pengecekan' ||
                  initValue == itemData["number"] ||
                  initValue == itemData["modelOrType"] ||
                  initValue == itemData["jumlahPengecekan"] ||
                  initValue.isNotEmpty)
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

            formController.inputAnswerCondition(
                formController.answers, currentAnswer);
            print("answers : ${formController.answers[0].answerText}");
          },
        );

      case 'Option Condition':
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 7,
                  blurStyle: BlurStyle.outer)
            ], borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 3),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      questionText,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                Column(
                  children: formController.option.map((optionCondition) {
                    return buildRadio(questionId, optionCondition, null);
                  }).toList(),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
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
              value: option.condition,
              groupValue: formController.selectedValue[questionId]?.value,
              onChanged: (value) {
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
                formController.inputAnswerCondition(
                    formController.answers, currentAnswer);
                _formKey.currentState!.validate();
              },
            ),
            Text(
              option.condition,
              softWrap: true,
              maxLines: 3,
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
                  formController.inputAnswerCondition(
                      formController.answers, currentAnswer);
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
                  formController.inputAnswerCondition(
                      formController.answers, currentAnswer);
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
                  formController.inputAnswerCondition(
                      formController.answers, currentAnswer);
                },
              ),
            ],
          ),
      ],
    );
  }
}
