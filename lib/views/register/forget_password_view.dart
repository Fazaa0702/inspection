import 'package:einspection/controllers/auth/forget_password_controller.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});

  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Color(0xFF47B347), Color(0xFF7FCC1E)]),
          ),
          height: Get.height,
          width: Get.width,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(75),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                            )
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 5, bottom: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            // Center(
                            //   child: Image.asset(
                            //     'assets/images/login1.png',
                            //     width: Get.width,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                                onTap: () => Get.offAllNamed(RouteName.login),
                                child: const Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios_new),
                                    Text(
                                      'Back to Login',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins'),
                                    ),
                                  ],
                                )),

                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                                child: Text(
                              'Forget Password',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            )),
                            const Padding(
                                padding: EdgeInsets.only(
                              top: 10,
                            )),
                            const Text(
                              'Username',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            SizedBox(
                              height: 45,
                              child: TextFormField(
                                enableSuggestions: false,
                                controller: controller.usernameController,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins'),
                                maxLines: 1,
                                cursorColor: const Color(0xFF47B347),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF47B347)))),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 15)),
                            const Text(
                              'New Password',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            SizedBox(
                                height: 45,
                                child: Obx(
                                  () => TextFormField(
                                    obscureText:
                                        controller.isNewPasswordVisible.value,
                                    enableInteractiveSelection: false,
                                    enableSuggestions: false,
                                    controller:
                                        controller.newPasswordController,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'),
                                    maxLines: 1,
                                    cursorColor: const Color(0xFF47B347),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () => controller
                                                .isNewPasswordVisible
                                                .toggle(),
                                            icon: Icon(controller
                                                    .isNewPasswordVisible.value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF47B347)))),
                                  ),
                                )),
                            const Padding(padding: EdgeInsets.only(top: 15)),
                            const Text(
                              'Confirm Password',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            SizedBox(
                                height: 45,
                                child: Obx(
                                  () => TextFormField(
                                    obscureText: controller
                                        .isConfirmPasswordVisible.value,
                                    enableInteractiveSelection: false,
                                    enableSuggestions: false,
                                    controller:
                                        controller.confirmPasswordController,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'),
                                    maxLines: 1,
                                    cursorColor: const Color(0xFF47B347),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () => controller
                                                .isConfirmPasswordVisible
                                                .toggle(),
                                            icon: Icon(controller
                                                    .isConfirmPasswordVisible
                                                    .value
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined)),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 15),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Color(0xFF47B347)))),
                                  ),
                                )),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            CommonButton(
                                text: 'Submit',
                                backgroundColor: Colors.black,
                                onPressed: () {}),
                            const Padding(padding: EdgeInsets.only(bottom: 20)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
