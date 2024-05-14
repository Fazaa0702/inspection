import 'package:double_tap_to_exit/double_tap_to_exit.dart';
import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:einspection/views/home/log_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final LoginController controller = Get.put(LoginController());
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DoubleTapToExit(
      snackBar: const SnackBar(
        content: Text('Tap again to exit !'),
      ),
      child: Scaffold(
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home_bg1.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: Get.height * 0.3,
                  width: Get.width,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 0, top: 15, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 0, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: InkWell(
                                    onTap: () {
                                      CommonDialog().confirmDialog(
                                          'Confirm',
                                          'Are you sure ?',
                                          'you will be redirected to the login page',
                                          () {
                                        controller.logout();
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(90)),
                                      width: 100,
                                      height: 40,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Transform.rotate(
                                              angle: -3.14,
                                              child: const Icon(
                                                Icons.logout_outlined,
                                                color: Colors.red,
                                              ),
                                            ),
                                            const Text(
                                              'Logout',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'HSE CONNECT',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.5,
                                  child: const Text(
                                    '"Prioritizing health preserves lives, while safeguarding the environment ensures a sustainable future for all."',
                                    textAlign: TextAlign.left,
                                    maxLines: 4,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                              width: Get.width * 0.4,
                              height: Get.height * 0.4,
                              child: Image.asset(
                                'assets/images/home1.png',
                                fit: BoxFit.fill,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    height: Get.height * 0.25,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 7,
                          blurStyle: BlurStyle.outer)
                    ], borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CommonFeatureButton(
                            buttonColor: const Color(0xFFD4F4FE),
                            onPressed: () {
                              Get.toNamed(RouteName.inspection);
                            },
                            image: 'assets/images/homeButton1.png',
                            text: 'e-Inspection'),
                        CommonFeatureButton(
                            buttonColor: const Color(0xFFFDF0CC),
                            onPressed: () {
                              Get.toNamed(RouteName.workPermit);
                            },
                            image: 'assets/images/homeButton2.png',
                            text: 'Work Permit'),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 10, bottom: 5),
                  child: SizedBox(
                    height: 30,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Inspection Log',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8, top: 10, bottom: 5, right: 8),
                  child: LogView(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
