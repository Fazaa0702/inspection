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
                  color: const Color(0xFF32A632),
                  height: Get.height * 0.28,
                  width: Get.width,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 0, top: 8, bottom: 0),
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
                                Transform.rotate(
                                  angle: -3.14,
                                  child: IconButton(
                                    onPressed: () {
                                      CommonDialog().confirmDialog(
                                          'Confirm',
                                          'Are you sure ?',
                                          'you will be redirected to the login page',
                                          () {
                                        controller.logout();
                                      });
                                    },
                                    icon: const Icon(
                                      // textDirection: TextDirection.ltr,
                                      Icons.logout,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    'HSE Connect',
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
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 20, bottom: 5),
                  child: SizedBox(
                    height: 25,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Menu',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins')),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    height: Get.height * 0.25,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color:
                              Colors.black.withOpacity(0.2), // warna bayangan
                          spreadRadius: 3, // seberapa tersebar bayangan
                          blurRadius: 7, // seberapa kabur bayangan
                          blurStyle: BlurStyle.outer
                          // offset: Offset(), // posisi bayangan (x, y)
                          )
                    ], borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: const Color(0xFFD4F4FE)),
                                onPressed: () {
                                  Get.toNamed(RouteName.inspection);
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 100,
                                  child: Image.asset(
                                    'assets/images/homeButton1.png',
                                    // height: 125,
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'e-Inspection',
                                overflow: TextOverflow.visible,
                                // maxLines: 3,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: const Color(0xFFFDF0CC)),
                                onPressed: () {
                                  // Get.toNamed(RouteName.inspection);
                                },
                                child: SizedBox(
                                  width: 50,
                                  height: 100,
                                  child: Image.asset(
                                    'assets/images/homeButton2.png',
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Work Permit',
                                overflow: TextOverflow.visible,
                                // maxLines: 3,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
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
                ) 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
