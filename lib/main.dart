import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:einspection/app_binding.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'routes/route.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
        snackBar: const SnackBar(
          content: Text('Tap again to exit !'),
        ),
        child: GetMaterialApp(
          title: 'E-Inspection',
          debugShowCheckedModeBanner: false,
          getPages: Routes.pages,
          initialRoute: RouteName.splashView,
          initialBinding: AppBinding(),
        ));
  }
}
