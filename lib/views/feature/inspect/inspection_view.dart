import 'package:einspection/export.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InspectionView extends StatelessWidget {
  InspectionView({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
          title: 'e-Inspection',
          backButton: () {
            Get.offAllNamed(RouteName.home);
          }),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 8, top: 8, bottom: 20),
                        child: SizedBox(
                          height: 25,
                          child: Text('Select Method',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins')),
                        ),
                      ),
                      Center(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(RouteName.form);
                              },
                              child: Container(
                                width: Get.width,
                                height: 100,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFF47B347),
                                      Color(0xFF7FCC1E)
                                    ]),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Image.asset(
                                          'assets/images/home2.png',
                                          width: 80,
                                        )),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 40),
                                      child: Text(
                                        'Input Forms',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // const Padding(padding: EdgeInsets.only(top: 20)),
                            // const Text('Or',
                            //     style: TextStyle(
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.w400,
                            //         fontFamily: 'Poppins',
                            //         color: Colors.grey)),
                            // const Padding(padding: EdgeInsets.only(top: 20)),
                            // InkWell(
                            //   onTap: () {
                            //     Get.toNamed(RouteName.scan);
                            //   },
                            //   child: Container(
                            //     width: Get.width,
                            //     height: 100,
                            //     decoration: BoxDecoration(
                            //         gradient: const LinearGradient(colors: [
                            //           Color(0xFF47B347),
                            //           Color(0xFF7FCC1E)
                            //         ]),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Padding(
                            //             padding: const EdgeInsets.only(left: 10),
                            //             child: Image.asset(
                            //               'assets/images/home3.png',
                            //               width: 90,
                            //             )),
                            //         const Padding(
                            //           padding: EdgeInsets.only(right: 30),
                            //           child: Text(
                            //             'Scan QR Code',
                            //             style: TextStyle(
                            //                 fontSize: 24,
                            //                 fontWeight: FontWeight.w600,
                            //                 fontFamily: 'Poppins',
                            //                 color: Colors.white),
                            //           ),
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
