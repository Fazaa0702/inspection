import 'package:einspection/controllers/feature/inspect/form_controller.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  @override
  final FormController controller = Get.put(FormController());
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
                width: Get.width,
                height: Get.height * 0.4,
                color: const Color(0xFF7ACC7A),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 3),
                          child: Text(
                            'Selamat Datang',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            'Fazaa Hanifan Hidayatullah',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: SizedBox(
                        height: Get.height * 0.39,
                        width: Get.width * 0.39,
                        child: Image.asset('assets/images/home1.png'),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              const SizedBox(
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
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteName.form);
                      },
                      child: Container(
                        width: Get.width * 0.9,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xFF47B347), Color(0xFF7FCC1E)]),
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
                                'Input Manual',
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
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    const Text('Or',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Colors.grey)),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: Get.width * 0.9,
                        height: 100,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                colors: [Color(0xFF47B347), Color(0xFF7FCC1E)]),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  'assets/images/home3.png',
                                  width: 90,
                                )),
                            const Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text(
                                'Scan QR Code',
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
