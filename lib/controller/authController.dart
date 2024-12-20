import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resource_plus/utilities/diohandler.dart';
import 'package:resource_plus/utilities/sharedpreference.dart';

class Authcontroller extends GetxController {
  final DateTime now = DateTime.now();
  SharedPrefHelper sharedPrefHelper = SharedPrefHelper();

  String? token;
  String? message;

  Future<void> login(String email, String password) async {
    String formattedDate = DateFormat("MM/dd/yyyy").format(now);

    var body = {
      "Token": "notoken",
      "Action": "SIGNIN",
      "Mode": "MOBILE",
      "Lts": formattedDate,
      "BrowseInfo": "user agaent info",
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": password},
      ]
    };

    try {
      log("Sending request to API...");

      var response = await DioHandler.readMedical(body: body)
          .timeout(Duration(seconds: 60));

      log('Response: ${response.toString()}');

      if (response["Status"] == 1) {
        log("Message Response: ${response['Data'][0][0]['msg']}");
        var msg = response['Data'][0][0]['msg'];
        message = msg;

        Get.snackbar('Success', 'Successfully logged in');
        Get.offNamed('/OtpScreen', arguments: {
          "email": email,
          "message": msg,
        });
      } else {
        var errorMsg = response['ErrorMsg'] ?? 'Unknown error occurred';
        Get.snackbar('Error', errorMsg);
      }
    } on TimeoutException catch (e) {
      log('Timeout Exception: $e');
      Get.snackbar(
        'Error',
        'Request timed out. The server might be taking longer to respond.',
      );
    } on DioException catch (e) {
      log('DioException: ${e.response?.data ?? e.message}');
      Get.snackbar('Error', e.response?.data ?? 'Dio error occurred');
    } catch (e) {
      log('General Exception: $e');
      Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    }
  }

  Future<void> signUp(
      String email, String password, String fullname, String phone) async {
    String formattedDate = DateFormat("MM/dd/yyyy").format(now);

    var body = {
      "Token": "notoken",
      "Action": "SIGNUP",
      "Mode": "MOBILE",
      "Lts": formattedDate,
      "BrowseInfo": "user agaent info",
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": password},
        {"T": "c1", "V": fullname},
        {"T": "c2", "V": phone}
      ]
    };

    try {
      var response = await DioHandler.readMedical(body: body)
          .timeout(Duration(seconds: 30));
      if (response['Status'] == 1) {
        log("Message Response: ${response['Data'][0][0]['msg']}");
        var msg = response['Data'][0][0]['msg'];
        message = msg;
        log("SIGNUP Response:  ${response.toString()}");
        Get.snackbar('Success', 'Successfully Sign Up');

        Get.offNamed('/OtpScreen', arguments: {
          "email": email,
          "message": msg,
        });
      } else {
        Get.snackbar('Error', response['ErrorMsg'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error during sign up: $e');
      Get.snackbar('Error', 'Failed to connect. Please try again later.');
    }
  }

  Future<void> otpValidation(String email, String otp) async {
    String formattedDate = DateFormat("MM/dd/yyyy").format(now);

    var body = {
      "Token": "notoken",
      "Action": "OTP",
      "Mode": "MOBILE",
      "Lts": formattedDate,
      "BrowseInfo": "user agent info",
      "Tags": [
        {"T": "dk1", "V": email},
        {"T": "dk2", "V": otp},
      ]
    };

    try {
      var response = await DioHandler.readMedical(body: body)
          .timeout(Duration(seconds: 30));

      if (response['Status'] == 1) {
        log("OTP Response: ${response.toString()}");

        if (response['Data'].isNotEmpty && response['Data'][0].isNotEmpty) {
          String token = response['Data'][0][0]['tkn'];
          log("your token id is ----${token}");
          await sharedPrefHelper.saveToken(token);

          Get.snackbar('Success', 'OTP Validated');
          Get.offNamed('/');
        } else {
          Get.snackbar('Error', 'No token received.');
        }
      } else {
        Get.snackbar('Error', response['ErrorMsg'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      log('Error during Validation: $e');
      Get.snackbar('Error', 'Failed to connect. Please try again later.');
    }
  }

  Future<void> logout() async {
  try {
    // Remove user token or session data
    await sharedPrefHelper.removeToken();

    // Navigate to the Splash2 screen and clear navigation history
    Get.offAllNamed('/Splash2');

    // Show a success message to the user
    Get.snackbar(
      'Success', 
      'Logged out successfully',
      snackPosition: SnackPosition.TOP, 
    );
  } catch (e) {
    // Log the error for debugging
    log('Error during logout: $e');

    // Show an error message to the user
    Get.snackbar(
      'Error', 
      'Failed to logout. Please try again.',
      snackPosition: SnackPosition.BOTTOM, 
    );
  }
}
}