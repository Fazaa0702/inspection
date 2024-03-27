import 'package:get/get.dart';

class WorkPermitController extends GetxController {
  var selectedDate = Rx<DateTime?>(DateTime.now());

  void pickDate(DateTime? date) {
    selectedDate.value = date;
  }
}
