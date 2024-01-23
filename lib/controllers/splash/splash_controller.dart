import 'package:einspection/routes/route_name.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? user = prefs.getString('user');

    if (user != null) {
      Get.offAllNamed(RouteName.home);
    } else {
      Future.delayed(
          const Duration(seconds: 4), () => Get.offAllNamed(RouteName.login));
    }
  }
}
