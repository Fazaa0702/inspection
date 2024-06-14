import 'package:einspection/controllers/auth/password_register_controller.dart';
import 'package:einspection/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';

class PasswordRegisterView extends StatelessWidget {
  final String userId;
  final String message;
  PasswordRegisterView(
      {super.key, required this.userId, required this.message});

  final controller = Get.put(PasswordRegisterController());

  @override
  Widget build(BuildContext context) {
    print('userrrrr idddddd: $userId');
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
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Center(
                            child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins'),
                        )),
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 75, right: 75, bottom: 75),
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
                              'Change Password',
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
                              'Notes !',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins'),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1. Password must contains Uppercase and lowercase alphabetic letters',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  '2. Password must contains numbers',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  '3. Password must contains special character',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  '4. Password must contains at least 10 characters long',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                                Text(
                                  '5. Passwords must different from at least 3 last passwords',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins'),
                                ),
                              ],
                            ),

                            const Padding(
                                padding: EdgeInsets.only(
                              top: 10,
                            )),
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
                                    enableSuggestions: false,
                                    controller:
                                        controller.newPasswordController,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'),
                                    maxLines: 1,
                                    cursorColor:
                                        controller.newPasswordWarning.value ==
                                                true
                                            ? const Color(0xFF47B347)
                                            : Colors.red,
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
                                            borderSide: BorderSide(
                                                color: controller
                                                            .newPasswordWarning
                                                            .value ==
                                                        true
                                                    ? const Color(0xFF47B347)
                                                    : Colors.red))),
                                    onChanged: (value) {
                                      value =
                                          controller.newPasswordController.text;
                                      if (value != '') {
                                        controller.newPasswordValidate.value =
                                            controller.passwordValidate(value);
                                        controller.newPasswordWarning.value =
                                            controller.newPasswordValidate[0];
                                        controller.warningText.value =
                                            controller.newPasswordValidate[1];
                                      }
                                    },
                                  ),
                                )),
                            // Obx(() => Text(
                            //       controller.warningText.value,
                            //       style: TextStyle(
                            //           color:
                            //               controller.newPasswordWarning.value ==
                            //                       true
                            //                   ? Color(0xFF47B347)
                            //                   : Colors.red),
                            //     )),
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
                                    // onChanged: (value) {
                                    //   value = controller
                                    //       .confirmPasswordController.text;
                                    //   if (value !=
                                    //       controller
                                    //           .newPasswordController.text) {
                                    //     controller.newPasswordWarning.value =
                                    //         false;
                                    //   }
                                    // },
                                    obscureText: controller
                                        .isConfirmPasswordVisible.value,
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
                                onPressed: () {
                                  if (controller.newPasswordController.text ==
                                      controller
                                          .confirmPasswordController.text) {
                                    CommonDialog().confirmDialog(
                                        'Confirm',
                                        'Are you sure to change your password ?',
                                        'Make sure your password is secure',
                                        () {
                                      controller.registerPassword(userId);
                                    });
                                  } else {
                                    CommonSnackbar.failedSnackbar(
                                        'Failed', 'Your new password invalid');
                                  }
                                }),
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
