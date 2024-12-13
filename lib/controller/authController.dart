import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/utilities/diohandler.dart';

class Authcontroller extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Perform cleanup
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    log("emailController ${emailController.text}");
    log( "password ${passwordController.text}");
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
        Get.toNamed('/Signup');
      } else {
        Get.snackbar('Error', response['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error during login: $e');
      Get.snackbar('Error', 'Failed to connect. Please try again later.');
    }
  }
}
