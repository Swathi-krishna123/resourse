import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/utilities/diohandler.dart';
import 'package:resource_plus/view/signUp.dart';

class Authcontroller extends GetxController {
  //login
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
// signup
  final TextEditingController signupemailController = TextEditingController();
  final TextEditingController signuppasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController confirmpasswordContoller =
      TextEditingController();
  // Perform cleanup
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    signupemailController.dispose();
    signuppasswordController.dispose();
    phoneController.dispose();
    lastnameController.dispose();
    firstnameController.dispose();
    confirmpasswordContoller.dispose();
    super.onClose();
  }
// Login
  Future<void> login() async {
    log("emailController ${emailController.text}");
    log("password ${passwordController.text}");
    // Input validation
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Email and password cannot be empty.');
      return;
    }

    var body = {
      "Token": "",
      "Prokey": "",
      "Tags": [
        {"T": "obj", "V": "LOGINRP"},
        {"T": "c1", "V": emailController.text.trim()},
        {"T": "c2", "V": passwordController.text.trim()},
      ]
    };

    try {
      // Call the API and get the response
      var response = await DioHandler.readMedical(body: body)
          .timeout(Duration(seconds: 30)); // 30-second timeout
      print(response);
      if (response['st'] == 1) {
        log("API Response: $response");
        Get.snackbar('Success', 'Successfully logged in');
        // await Future.delayed(Duration(seconds: 2));
        Get.toNamed('/OtpScreen');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error during login: $e');
      Get.snackbar('Error', 'Failed to connect. Please try again later.');
    }
  }

  // signup
  Future<void> signUp() async {
    log("Lastname ${lastnameController.text}");
    log("Firstname ${firstnameController.text}");
    log("phonenumber ${phoneController.text}");
    log("emailController ${signupemailController.text}");
    log("password ${signuppasswordController.text}");

    var body = {
      "Token": "",
      "Prokey": "",
      "Tags": [
        {"T": "Obj", "V": "SIGNUP"},
        {"T": "c1", "V": signupemailController.text.trim()},
        {"T": "c2", "V": phoneController.text.trim()},
        {"T": "c3", "V": lastnameController.text.trim()},
        {"T": "c4", "V": firstnameController.text.trim()},
        {"T": "c5", "V": passwordController.text},
      ]
    };

    try {
      // Call the API and get the response
      var response = await DioHandler.readMedical(body: body)
          .timeout(Duration(seconds: 30)); // 30-second timeout
      print(response);
      if (response['st'] == 1) {
        log("API Response: $response");
        Get.snackbar('Success', 'Successfully Sign Up');
        // await Future.delayed(Duration(seconds: 2));
        Get.toNamed('/Login');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error during sign up: $e');
      Get.snackbar('Error', 'Failed to connect. Please try again later.');
    }
  }
}
