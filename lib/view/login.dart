import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/authController.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final Authcontroller authcontroller = Get.put(Authcontroller());
  final _formkey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  RxBool isLoading = false.obs;

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
                  'assets/svg/logintext.svg',
                  height: 70,
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Text(
                    'Access your account and stay connected to \nessential resources.',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Appcolors.TextColor),
                  ),
                ),
                Customwidgets().textFormField(
                    controller: authcontroller.emailController,
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
                    onFocusChange: () => passwordFocusNode,
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
                  controller: authcontroller.passwordController,
                  focusNode: passwordFocusNode,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required field';
                    }
                    return null;
                  },
                  obsecureText: true,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset('assets/svg/passwordlock.svg'),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      'assets/svg/eyeclose.svg',
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      'Forgot Password?',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Appcolors.text2Color),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => GestureDetector(
                    onTap: isLoading.value
                        ? null // Disable tap when loading
                        : () async {
                            if (_formkey.currentState!.validate()) {
                              isLoading.value = true; // Start loading
                              try {
                                await authcontroller
                                    .login(); // Your async login function
                              } catch (e) {
                                log("Login Error: $e");
                              } finally {
                                isLoading.value = false; // Stop loading
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
                        : Customwidgets().customContainer(text: 'Log In'),
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
                      'Don’t have an account? ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Appcolors.text2Color),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/Signup');
                      },
                      child: Text(
                        ' Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Appcolors.themeColor,
                        ),
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
