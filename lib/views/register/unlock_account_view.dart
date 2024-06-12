
import 'package:einspection/controllers/auth/unlock_account_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../export.dart';
import '../../routes/route_name.dart';

class UnlockAccountView extends StatelessWidget {
  UnlockAccountView({super.key});

  final controller = Get.put(UnlockAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(builder: (context, orientation) {
        return Container(
          decoration: const BoxDecoration(
            gradient: const LinearGradient(
                colors: [Color(0xFF47B347), Color(0xFF7FCC1E)]),
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
                              'Unlock Account',
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
                            const Padding(padding: EdgeInsets.only(top: 5)),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            Obx(
                              () => controller.isLoading.value
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: Color(0xFF47B347),
                                      ),
                                    )
                                  : CommonButton(
                                      text: 'Submit',
                                      backgroundColor: Colors.black,
                                      onPressed: () {
                                        controller.unlockAccount();
                                      }),
                            ),

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
