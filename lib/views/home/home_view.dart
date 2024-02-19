import 'package:einspection/component/common_dialog.dart';
import 'package:einspection/controllers/login/login_controller.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              IconButton(
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
                        color: Colors.black.withOpacity(0.2), // warna bayangan
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
                                      borderRadius: BorderRadius.circular(20)),
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
                                      borderRadius: BorderRadius.circular(20)),
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
                    child: Text('Inspection Log',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins')),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 25, right: 25, top: 20, bottom: 20),
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       height: Get.height * 0.20,
              //       decoration: BoxDecoration(boxShadow: [
              //         BoxShadow(
              //             color:
              //                 Colors.black.withOpacity(0.2), // warna bayangan
              //             spreadRadius: 3, // seberapa tersebar bayangan
              //             blurRadius: 7, // seberapa kabur bayangan
              //             blurStyle: BlurStyle.outer
              //             // offset: Offset(), // posisi bayangan (x, y)
              //             )
              //       ], borderRadius: BorderRadius.circular(10)),
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 20),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               height: Get.height * 0.12,
              //               width: Get.width * 0.20,
              //               // color: Colors.grey.withOpacity(0.17),
              //               child: Image.asset(
              //                 'assets/images/logo1.png',
              //                 fit: BoxFit.fill,
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'HSE Connect',
              //                     style: TextStyle(
              //                         color: Colors.black,
              //                         fontSize: 20,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w700),
              //                   ),
              //                   SizedBox(
              //                     width: Get.width * 0.6,
              //                     child: Text(
              //                       '"Prioritizing health preserves lives, while safeguarding the environment ensures a sustainable future for all."',
              //                       textAlign: TextAlign.start,
              //                       overflow: TextOverflow.ellipsis,
              //                       maxLines: 3,
              //                       softWrap: true,
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 12,
              //                           fontFamily: 'Poppins',
              //                           fontWeight: FontWeight.w300),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 25, right: 25, top: 20, bottom: 20),
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       height: Get.height * 0.20,
              //       decoration: BoxDecoration(boxShadow: [
              //         BoxShadow(
              //             color:
              //                 Colors.black.withOpacity(0.2), // warna bayangan
              //             spreadRadius: 3, // seberapa tersebar bayangan
              //             blurRadius: 7, // seberapa kabur bayangan
              //             blurStyle: BlurStyle.outer
              //             // offset: Offset(), // posisi bayangan (x, y)
              //             )
              //       ], borderRadius: BorderRadius.circular(10)),
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               height: Get.height * 0.12,
              //               width: Get.width * 0.20,
              //               // color: Colors.white,
              //               child: Image.asset(
              //                 'assets/images/homeButton2.png',
              //                 fit: BoxFit.fill,
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.only(left: 20),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'Work Permit',
              //                     style: TextStyle(
              //                         color: Colors.black,
              //                         fontSize: 20,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w700),
              //                   ),
              //                   SizedBox(
              //                     width: Get.width * 0.6,
              //                     child: Text(
              //                       '"Prioritizing health preserves lives, while safeguarding the environment ensures a sustainable future for all."',
              //                       textAlign: TextAlign.start,
              //                       overflow: TextOverflow.ellipsis,
              //                       maxLines: 3,
              //                       softWrap: true,
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 12,
              //                           fontFamily: 'Poppins',
              //                           fontWeight: FontWeight.w300),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(
              //       left: 25, right: 25, top: 20, bottom: 20),
              //   child: InkWell(
              //     onTap: () {},
              //     child: Container(
              //       height: Get.height * 0.20,
              //       decoration: BoxDecoration(boxShadow: [
              //         BoxShadow(
              //             color:
              //                 Colors.black.withOpacity(0.2), // warna bayangan
              //             spreadRadius: 3, // seberapa tersebar bayangan
              //             blurRadius: 7, // seberapa kabur bayangan
              //             blurStyle: BlurStyle.outer
              //             // offset: Offset(), // posisi bayangan (x, y)
              //             )
              //       ], borderRadius: BorderRadius.circular(10)),
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 20.0),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Container(
              //               height: 50,
              //               width: 50,
              //               // color: Colors.white,
              //               child: Image.asset(
              //                 'assets/images/splash1.png',
              //                 fit: BoxFit.fill,
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     'e-Inspection',
              //                     style: TextStyle(
              //                         color: Colors.black,
              //                         fontSize: 20,
              //                         fontFamily: 'Poppins',
              //                         fontWeight: FontWeight.w700),
              //                   ),
              //                   SizedBox(
              //                     width: Get.width * 0.6,
              //                     child: Text(
              //                       '"Prioritizing health preserves lives, while safeguarding the environment ensures a sustainable future for all."',
              //                       textAlign: TextAlign.start,
              //                       overflow: TextOverflow.ellipsis,
              //                       maxLines: 3,
              //                       softWrap: true,
              //                       style: TextStyle(
              //                           color: Colors.black,
              //                           fontSize: 12,
              //                           fontFamily: 'Poppins',
              //                           fontWeight: FontWeight.w300),
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
