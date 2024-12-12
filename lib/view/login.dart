import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/appcontroller.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';
import 'package:resource_plus/utilities/diohandler.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
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
                  controller: emailController,
                  focusNode: emailFocusNode,
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
                controller: passwordController,
                focusNode: passwordFocusNode,
                hintText: 'Enter your password',
                labelText: 'Password',
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
              GestureDetector(
                  onTap: () async {
                    Get.toNamed('/Signup');
                    var body = {
                      "Token": "",
                      "Prokey": "",
                      "Tags": [
                        {"T": "obj", "V": "LOGIN"},
                        {"T": "c1", "V": "swathi.gho@gmail.com"},
                        {"T": "c2", "V": "admin"},
                      ]
                    };
                    // Call the API and get the response
                    var response = await DioHandler.readMedical(body: body);
                    debugger;
                    // Check if the response is valid
                    if (response['st'] == 0) {
                      Get.snackbar('Error', 'message');
                    } else {
                      Get.offNamed('/');
                      Appcontroller().triggerAPI();
                    }
                  },
                  child: Customwidgets().customContainer(text: 'Log In')),
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
                    onTap: () {},
                    child: Text(
                      ' Sign Up',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Appcolors.TextColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
