import 'dart:convert';

import 'package:einspection/models/answer_model.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/feature/inspect/form_controller.dart';
import '../../../controllers/feature/inspect/submit_form_controller.dart';
import '../../../models/question_answer_model.dart';
import '../../../models/question_model.dart';

class FormSection extends StatefulWidget {
  final int departmentId;
  final int inspectionId;
  FormSection({
    super.key,
    required this.departmentId,
    required this.inspectionId,
  });

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final FormController controller = Get.put(FormController());
  final Map<String, bool> idSentStatus = {};

  final SubmitFormController submitFormController =
      Get.put(SubmitFormController());

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
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            Obx(
              () => Column(
                children: controller.questions
                    .map((question) => buildFormField(question))
                    .toList(),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var dataUser = prefs.getString("user").toString();
                    Map<String, dynamic> userData = json.decode(dataUser);
                    List<Map<String, dynamic>> answersMapList =
                        answers.map((obj) => obj.toJson()).toList();

                    // Convert the list of Map<String, dynamic> to a JSON string
                    String json_data_questionAnswers =
                        jsonEncode(answersMapList);
                    // setState(() {
                    //   answers.add(currentAnswer);
                    // });

                    // for (QuestionAnswerModel answer in answers) {
                    //   // setState(() {
                    //   //   answers.add(currentAnswer);
                    //   // });
                    //   print(
                    //       'Question ID: ${answer.questionId}, Answer: ${answer.answerText}');
                    // }
                    print("data user : ${userData['id']}");
                    print(
                        "ini value dept n inspect : ${widget.departmentId}, ${widget.inspectionId}");
                    late AnswerModel answerModel = new AnswerModel(
                        userId: userData['id'],
                        departmentId: widget.departmentId.toInt(),
                        inspectionId: widget.inspectionId.toInt(),
                        questionAnswers: json_data_questionAnswers);
                    submitFormController.submitAnswer(answerModel);
                    // Get.offAllNamed(RouteName.home);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF47B347),
                      fixedSize: const Size(500, 40)),
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
        ));
  }

  Widget buildFormField(QuestionModel question) {
    final questionText = question.questionText;
    final questionType = question.questionType;
    final questionId = question.id;
    if (!textControllers.containsKey(questionId)) {
      // Jika belum ada, buat controller baru
      textControllers[questionId] = TextEditingController();
    }

    switch (questionType) {
      case 'Text':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12.0, bottom: 3),
              child: Text(
                questionText,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ),
            SizedBox(
              height: 40,
              child: TextField(
                controller: textControllers[questionId],
                onChanged: (value) {
                  print(
                      "textController : ${textControllers[questionId]?.text}");
                  if (value == '') {
                    print(value);
                    print(questionId);
                  }
                  setState(() {
                    currentAnswer = QuestionAnswerModel(
                        questionId: question.id.toString(), answerText: value);
                  });
                  int index = answers.indexWhere(
                      (qa) => qa.questionId == currentAnswer.questionId);
                  print("index : ${index}");
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
                  print("answers : ${answers[0].questionId}");
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide:
                            const BorderSide(color: Color(0xFF47B347)))),
              ),
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
            buildRadio(questionId, 'bagus'),
            buildRadio(questionId, 'rusak'),
            SizedBox(height: 20),
          ],
        );
      default:
        // Handle other question types as needed
        return SizedBox.shrink();
    }
  }

  Widget buildRadio(String questionId, String nilai) {
    return Row(
      children: [
        Radio(
          activeColor: const Color(0xFF47B347),
          value: nilai,
          groupValue: controller.selectedValue[questionId]?.value,
          onChanged: (value) {
            print(questionId);
            // print(idSentStatus[questionId]);
            setState(() {
              currentAnswer = QuestionAnswerModel(
                questionId: questionId,
                answerText: nilai,
              );
            });
            controller.setSelectedValue(questionId, value.toString());

            int index = answers
                .indexWhere((qa) => qa.questionId == currentAnswer.questionId);
            print("index : ${index}");
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
            print("answers : ${answers[0].questionId}");
          },
        ),
        Text(nilai),
      ],
    );
  }
}
