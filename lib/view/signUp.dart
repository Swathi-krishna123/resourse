import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController confirmpasswordContoller = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode confirmpasswordFocusNode = FocusNode();

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
              SvgPicture.asset('assets/svg/signup.svg',height: 70,),
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
                  hintText: 'Enter your phone number',
                  labelText: 'Phone',
                  onFocusChange: () => usernameFocusNode,
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
                  controller: usernameController,
                  focusNode: usernameFocusNode,
                  hintText: 'Enter your username',
                  labelText: 'Username',
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
                onFocusChange: () => confirmpasswordFocusNode,
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
                height: 15,
              ),
              Customwidgets().textFormField(
                controller: confirmpasswordContoller,
                focusNode: confirmpasswordFocusNode,
                hintText: 'Confirm your password',
                labelText: 'Confirm Password',
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
                height: 20,
              ),
              Customwidgets().customContainer(text: 'Sign Up'),
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
