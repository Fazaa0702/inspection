import 'package:get/get.dart';

import 'controllers/splash/splash_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
