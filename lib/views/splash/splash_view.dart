import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: OrientationBuilder(
          builder: (context, orientation) {
            return SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: SizedBox(
                height: 300,
              )),
              SizedBox(
                height: 250,
                child: Image.asset(
                  'assets/images/logo1.png',
                ),
              ),
              const Expanded(child: SizedBox()),
              const Text(
                'Powered by',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(
                height: 15,
                child: Image.asset('assets/images/splash2.png'),
              ),
              const SizedBox(
                height: 10,
              )
            ],
                  ),
                );
          }
        ));
  }
}
