import 'package:einspection/export.dart';
import 'package:einspection/views/register/unlock_account_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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

                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                                child: Text(
                              'HSE Connect',
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
                                onChanged: (value) {
                                  controller.username = value;
                                },
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
                              'Password',
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
                                        controller.isPasswordVisible.value,
                                    enableInteractiveSelection: false,
                                    enableSuggestions: false,
                                    controller: controller.passwordController,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Poppins'),
                                    maxLines: 1,
                                    cursorColor: const Color(0xFF47B347),
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                            onPressed: () => controller
                                                .isPasswordVisible
                                                .toggle(),
                                            icon: Icon(controller
                                                    .isPasswordVisible.value
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
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 12.0),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: [
                            //       InkWell(
                            //           onTap: () {
                            //             Get.to(() => ForgetPasswordView());
                            //           },
                            //           child: const Text(
                            //             'Forgot Password ?',
                            //             textAlign: TextAlign.end,
                            //             style: TextStyle(
                            //                 fontSize: 12,
                            //                 color: Colors.blue,
                            //                 fontFamily: 'Poppins'),
                            //           )),
                            //     ],
                            //   ),
                            // ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Obx(
                              () => controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF47B347),
                                      ),
                                    )
                                  : CommonButton(
                                      text: 'Login',
                                      backgroundColor: Colors.black,
                                      onPressed: () {
                                        controller.isLoading.value = true;
                                        controller.emptyForm();
                                      }),
                            ),

                            // const Padding(padding: EdgeInsets.only(top: 5)),
                            const Padding(padding: EdgeInsets.only(top: 20)),

                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Your account is locked ?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(left: 5)),
                                  InkWell(
                                      onTap: () {
                                        Get.to(() => UnlockAccountView());
                                      },
                                      child: const Text(
                                        'unlocked here',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.blue,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(bottom: 10)),
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
