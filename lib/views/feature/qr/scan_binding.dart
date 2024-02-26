import 'package:get/get.dart';

import '../../../controllers/feature/inspect/scan_controller.dart';

class ScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ScanController());
  }
}
