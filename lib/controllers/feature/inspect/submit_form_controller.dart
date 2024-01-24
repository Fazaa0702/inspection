import 'package:einspection/models/answer_model.dart';
import 'package:einspection/services/form_service.dart';
import 'package:get/get.dart';

class SubmitFormController extends GetxController {
  final FormService formService = FormService();

  // Future<void> submitAnswer(Map<String, dynamic> answer) async {
  //   try {
  //     await formService.submitAnswerService(answer);
  //   } catch (error) {
  //     print("Error submitting answer: $error");
  //   }
  // }
}
