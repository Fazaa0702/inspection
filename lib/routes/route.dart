import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/feature/qr/scan_view.dart';
import 'package:get/get.dart';

import '../views/feature/inspect/inspection_view.dart';
import '../views/feature/inspect/form_view.dart';
import '../views/feature/qr/scan_binding.dart';
import '../views/home/home_view.dart';
import '../views/login/login_binding.dart';
import '../views/login/login_view.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static final pages = [
    GetPage(name: RouteName.splashView, page: () => const SplashView()),
    GetPage(
        name: RouteName.login,
        page: () => const LoginView(),
        binding: LoginBinding()),
    GetPage(
      name: RouteName.inspection,
      page: () => InspectionView(),
      // binding: HomeBinding()
    ),
    GetPage(
      name: RouteName.home,
      page: () => HomeView(),
      // binding: HomeBinding()
    ),
    GetPage(
      name: RouteName.form,
      page: () => const FormView(),
      // binding: InspectBinding()
    ),
    GetPage(
      name: RouteName.scan,
      page: () => ScanView(),
      binding: ScanBinding(),
    )
  ];
}
