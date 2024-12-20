import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/authController.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({Key? key}) : super(key: key);
  final TextEditingController otpController = TextEditingController();
  final Authcontroller authcontroller = Get.put(Authcontroller());
  final _formkey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final String email = Get.arguments?['email'] ?? '';
    final String message = Get.arguments?['message'] ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Customwidgets().customAppbar(false, context,false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),

                Text(
                  'O T P Verification',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Appcolors.themeColor,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Appcolors.TextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: otpController,
                  maxLength: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    labelStyle: TextStyle(fontSize: 100),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Appcolors.themeColor.withOpacity(0.79)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Appcolors.themeColor.withOpacity(0.79)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: Appcolors.themeColor.withOpacity(0.79)),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 182, 48, 38)),
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                // // Resend OTP
                // Text(
                //   "Don't receive OTP code?",
                //   style: const TextStyle(
                //     color: Colors.grey,
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // const SizedBox(height: 10),
                // GestureDetector(
                //   onTap: () {
                //     // Add resend OTP logic here
                //   },
                //   child: Text(
                //     'Resend OTP',
                //     style: TextStyle(
                //       decoration: TextDecoration.underline,
                //       color: Appcolors.blackColor,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 14,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30),
                // Verify Button
                GestureDetector(
                  onTap: isLoading.value
                      ? null
                      : () async {
                          if (_formkey.currentState!.validate()) {
                            isLoading.value = true;
                            try {
                              await authcontroller.otpValidation(
                                  email, otpController.text);
                            } catch (e) {
                              log("SignUp Error: $e");
                            } finally {
                              isLoading.value = false;
                            }
                          }
                        },
                  child: isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Appcolors.themeColor),
                          ),
                        )
                      : Customwidgets()
                          .customContainer(text: 'Verify & Continue'),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
