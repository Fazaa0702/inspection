import 'package:einspection/export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 90,
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/login1.png',
                        width: Get.width,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    )),
                    const Padding(
                        padding: EdgeInsets.only(
                      top: 10,
                    )),
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0, bottom: 3),
                      child: Text(
                        'User Id',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: TextFormField(
                        enableSuggestions: false,
                        controller: controller.userIdController,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins'),
                        maxLines: 1,
                        cursorColor: const Color(0xFF47B347),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: const BorderSide(
                                    color: Color(0xFF47B347)))),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    CommonButton(
                        text: 'Login',
                        onPressed: () async => controller.emptyForm())
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
