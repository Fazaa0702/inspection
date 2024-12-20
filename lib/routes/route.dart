import 'package:einspection/routes/route_name.dart';
import 'package:get/get.dart';

import '../views/home/home_view.dart';
import '../views/feature/inspect/form_view.dart';
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
      name: RouteName.home,
      page: () => HomeView(),
      // binding: HomeBinding()
    ),
    GetPage(
      name: RouteName.form,
      page: () => FormView(),
      // binding: InspectBinding()
    )
  ];
}
