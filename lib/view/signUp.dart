import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/authController.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController confirmpasswordContoller =
      TextEditingController();

  final Authcontroller authcontroller = Get.put(Authcontroller());
  final _formkey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode lastnameFocusNode = FocusNode();
  FocusNode fullnameFocusNode = FocusNode();
  FocusNode confirmpasswordFocusNode = FocusNode();
  RxBool isLoading = false.obs;
  RxBool ispasswordvisible = false.obs;
  RxBool isConfirmpasswordvisible = false.obs;
  void toggleVisible() {
    ispasswordvisible.value = !ispasswordvisible.value;
  }

  void toggleConfirmVisible() {
    isConfirmpasswordvisible.value = !isConfirmpasswordvisible.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                SvgPicture.asset(
                  'assets/svg/signup.svg',
                  height: 70,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Text(
                    'Join us and access the resources you need to \nmake a difference.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Appcolors.TextColor),
                  ),
                ),
                Customwidgets().textFormField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    hintText: 'Enter your email address',
                    labelText: 'Email',
                    onFocusChange: () => phoneFocusNode,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Icon(
                        Icons.email_outlined,
                        color: Appcolors.hintColor,
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Customwidgets().textFormField(
                    controller: phoneController,
                    focusNode: phoneFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number is required";
                      }

                      // Ensure the value starts with a country code (1–4 digits)
                      if (!RegExp(r'^\d{1,4}\d{7,15}$').hasMatch(value)) {
                        return "Enter a valid phone number with country code";
                      }

                      // Check if the country code is valid (optional)
                      final validCountryCodes = [
                        "1", "91", "44", "86",
                        "20", // Add more as needed
                      ];
                      String countryCode = value.substring(
                          0,
                          value.length -
                              10); // Assuming last 10 digits are phone number
                      if (!validCountryCodes.contains(countryCode)) {
                        return "Invalid country code";
                      }

                      return null; // Valid input
                    },
                    hintText: 'Enter your phone number',
                    labelText: 'Phone',
                    onFocusChange: () => fullnameFocusNode,
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset("assets/svg/phone.svg"))),
                SizedBox(
                  height: 15,
                ),
                Customwidgets().textFormField(
                    controller: fullnameController,
                    focusNode: fullnameFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      }
                      return null;
                    },
                    hintText: 'Enter your Full Name',
                    labelText: 'Full Name',
                    onFocusChange: () => passwordFocusNode,
                    prefixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: SvgPicture.asset("assets/svg/user.svg"))),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Customwidgets().textFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    onFocusChange: () => confirmpasswordFocusNode,
                    hintText: 'Enter your password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      }
                      return null;
                    },
                    labelText: 'Password',
                    obscureText: !ispasswordvisible.value,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SvgPicture.asset('assets/svg/passwordlock.svg'),
                    ),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: IconButton(
                            onPressed: () {
                              toggleVisible();
                            },
                            icon: !ispasswordvisible.value
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Appcolors.hintColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: Appcolors.hintColor,
                                  ))),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Customwidgets().textFormField(
                    controller: confirmpasswordContoller,
                    focusNode: confirmpasswordFocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required field';
                      } else if (confirmpasswordContoller.text !=
                          passwordController.text) {
                        return "password do not math";
                      }
                      return null;
                    },
                    hintText: 'Confirm your password',
                    labelText: 'Confirm Password',
                    obscureText: !isConfirmpasswordvisible.value,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: SvgPicture.asset('assets/svg/passwordlock.svg'),
                    ),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.all(14),
                        child: IconButton(
                            onPressed: () {
                              toggleVisible();
                            },
                            icon: !isConfirmpasswordvisible.value
                                ? Icon(
                                    Icons.visibility_off,
                                    color: Appcolors.hintColor,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: Appcolors.hintColor,
                                  ))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: isLoading.value
                        ? null
                        : () async {
                            if (_formkey.currentState!.validate()) {
                              isLoading.value = true;
                              try {
                                await authcontroller.signUp(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    fullnameController.text.trim(),
                                    phoneController.text.trim());
                                // Get.offNamed('/OtpScreen', arguments: {"email": emailController.text.trim()});
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
                        : Customwidgets().customContainer(text: 'Sign Up'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Appcolors.text2Color),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/Login');
                      },
                      child: Text(
                        '  Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Appcolors.themeColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
