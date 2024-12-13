import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/controller/shareResourcesController.dart';
import 'package:resource_plus/utilities/diohandler.dart';

class Appcontroller extends GetxController {
  TextEditingController searchController = TextEditingController();
  // Observables for state management
  var isLoading = false.obs;
  var medicalSearch = <Map<String, dynamic>>[].obs; // list of items
  var medicalSearchDetails =
      <Map<String, dynamic>>[].obs; // list of medical search details
  var filteredMedicalSearch =
      <Map<String, dynamic>>[].obs; //  list of selected items
  var selectedItems = <Map<String, dynamic>>[].obs; //
  var isSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicalSearch();
    isLoading.value = false;
    isSuccess.value = false;
    triggerAPI();
  }

  ///////////////////////////
  void triggerAPI() async {
    final body = {
      "Token": "",
      "Prokey": "",
      "Tags": [
        {"T": "Act", "V": "ANY"},
        {"T": "Obj", "V": "CONTENTS"},
        {"T": "c10", "V": "5"}
      ]
    }; // Replace with your actual body data
    final response = await DioHandler.readMedical(body: body);
    if (response["error"] == null) {
      print("API Response: $response");
    } else {
      print("Error: ${response["error"]}");
    }
  }

  ///////////////////////////////////////
  // signup

 // {"T": "Obj", "V": "SIGNUP"},
 // {"T": "c1", "V": "emailadress"},
 // {"T": "c2", "V": "phone"},
 // {"T": "c3", "V": "lastname"},
 // {"T": "c4", "V": "firstname"},
 // {"T": "c5", "V": "password"},


 // otp

 // {"T": "obj", "V": "OTP"},
 // {"T": "c1", "V": "emailsdress"},

 // login 

 // {"T": "obj", "V": "SIGNIN"},
 // {"T": "c1", "V": "emailadress"},
 // {"T": "c2", "V": "password"},


  
  ///


  Future<void> fetchMedicalSearch() async {
    try {
      isLoading.value = true; // Start loading
      // "IsCrossRequest": true,
      var body = {
        "Token": "",
        "Prokey": "",
        "Tags": [
          {"T": "Act", "V": "ANY"},
          {"T": "Obj", "V": "CONTENTS"},
          {"T": "c10", "V": "5"}
        ]
      };

      // Call the API and get the response
      var response = await DioHandler.readMedical(body: body);

      // Check if the response is valid
      if (response['Status'] == 1) {
        var data = response['DTable'];
        log("Response data: $data");

        // Validate and update `medicalSearch`
        if (data != null && data.isNotEmpty) {
          medicalSearch
              .assignAll(List<Map<String, dynamic>>.from(data[0] ?? []));
          filteredMedicalSearch.assignAll(medicalSearch);

          // Log IDs for debugging
          for (var item in medicalSearch) {
            log("Item ID: ${item['id']}");
          }
        } else {
          Get.snackbar('Error', 'Data is empty');
        }
      } else {
        Get.snackbar('Error', response['ErrorMsg'] ?? 'Unknown error');
      }
    } catch (e, stackTrace) {
      log('Exception: ${e.toString()}', stackTrace: stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

//===============================================================

  Future<void> fetchMedicalSearchDetails() async {
    // log('medical search map ${selectedItems}');
    try {
      var ids = selectedItems.map((item) => item['id']).toList();
      var formattedIds = ids.join(', ');

      // log('ids: $ids');
      // print('{"T": "c1", "V": "$ids"},');

      isLoading.value = true; // Start loading

      var body = {
        "Token": "",
        "Prokey": "",
        "Tags": [
          {"T": "Act", "V": "ANY"},
          {"T": "Obj", "V": "CONTENTS"},
          {"T": "c1", "V": formattedIds},
          {"T": "c10", "V": "9"}
        ]
      };

      // Call the API and get the response
      var response = await DioHandler.readMedical(body: body);

      // Check if the response is valid
      if (response['Status'] == 1) {
        var data = response['DTable'];
        // log("Response data: $data");

        // Validate and update `medicalSearch`
        if (data != null && data.isNotEmpty) {
          medicalSearchDetails
              .assignAll(List<Map<String, dynamic>>.from(data[0] ?? []));
          // filteredMedicalSearch.assignAll(medicalSearch);
          log("medicalSearchDetails $medicalSearchDetails");
          List<int> mids =
              medicalSearchDetails.map((entry) => entry["id"] as int).toList();
          log("medical search details ids $mids");

          // // Log IDs for debugging
          // for (var item in medicalSearch) {
          //   log("Item ID: ${item['id']}");
          // }
        } else {
          Get.snackbar('Error', 'Data is empty');
        }
      } else {
        Get.snackbar('Error', response['ErrorMsg'] ?? 'Unknown error');
      }
    } catch (e, stackTrace) {
      log('Exception: ${e.toString()}', stackTrace: stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  //==============================================================

  //=============================================================

  void removeMedicalSearchDetails(Map<String, dynamic> item) async {
    var ids = selectedItems.map((item) => item['id']).toList();
    var formattedIds = ids.join(', ');

    try {
      // Log the item to be removed
      log("Removing item with id: ${item['id']}");
      log("Removing item with id: ${item['nm']}");

      // Remove from selectedItems
      selectedItems.removeWhere((element) => element['id'] == item['id']);
      selectedItems.refresh();
      searchController.clear();

      // Remove from medicalSearchDetails
      medicalSearchDetails.removeWhere(
          (element) => element[formattedIds] == item[formattedIds]);
      medicalSearchDetails.refresh();

      // Log the updated lists for debugging
      log("selected items ------$selectedItems");
      log("selected medical search details-----------$medicalSearchDetails");
      log("Updated selectedItems: ${selectedItems.map((e) => e['id']).toList()}");
      log("Updated medicalSearchDetails: ${medicalSearchDetails.map((e) => e['id']).toList()}");
      log("medical search details id ----$ids");
      log("formatted id ----$formattedIds");

      if (selectedItems.isEmpty) {
        fetchMedicalSearch();
      }
    } catch (e) {
      log("Error removing item: $e");
    }
  }

  //==============================================================

  // send resources/////////////

  Future<void> sendResources() async {
    ShareResourcesController shareResourcesController =
        Get.put(ShareResourcesController());
    try {
// Extract and filter valid phone numbers
      List<String> phoneNumbers = shareResourcesController.allPhoneControllers
          .map((controller) => controller.text)
          .where((number) =>
              number.isNotEmpty && RegExp(r'^\d+$').hasMatch(number))
          .toList();
      var phoneNumbersExtracted = phoneNumbers.join(', ');
      // log('phoneNumbersExtracted=============$phoneNumbersExtracted');

      // log('Valid phone numbers: $phoneNumbers');
      isLoading.value = true; // Start loading
      var ids = medicalSearchDetails.map((item) => item['id']).toList();
      var medicalSearchDetailsid = ids.join(', ');
      var email = shareResourcesController.emailController.text;
      var notes = shareResourcesController.notesController.text;

      log('email........$email');
      log('notes........$notes');
      log('medical search ids........$medicalSearchDetailsid');
      log('phone numbers........$phoneNumbersExtracted');

      var body = {
        "Token": "",
        "Prokey": "pNEvkmX3nJ7pWt7hADgrxKyCu5zjLdD+7NFtSZ8LeJ8=",
        "Tags": [
          {"T": "Act", "V": "ANY"},
          {"T": "Obj", "V": "CONTENTS"},
          {"T": "c1", "V": medicalSearchDetailsid},
          {"T": "c2", "V": phoneNumbersExtracted},
          {"T": "c3", "V": email},
          {"T": "c4", "V": notes},
          {"T": "c5", "V": "https://capc.swiftkode.com/"},
          {"T": "Sms", "V": "Y"},
          {"T": "c10", "V": "7"}
        ]
      };

      // Call the API and get the response
      var response = await DioHandler.readMedical(body: body);

      // Check if the response is valid
      if (response['Status'] == 1 || response['Status'] == -1) {
        log('success');
        log('response:$response');
        Get.snackbar('Send', 'Message Send Successfully');
      } else {
        Get.snackbar('Error', response['ErrorMsg'] ?? 'Unknown error');
      }
    } catch (e, stackTrace) {
      log('Exception: ${e.toString()}', stackTrace: stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false; // Stop loading
    }
  }

  //=================================================================

  void refreshData() {
    try {
      log("Refreshing data...");

      // Clear existing data
      medicalSearch.clear();
      medicalSearchDetails.clear();
      filteredMedicalSearch.clear();
      selectedItems.clear();

      // Reset observables
      isLoading.value = false;
      isSuccess.value = false;
      // Clear the search field
      searchController.clear();
      // Fetch data again
      fetchMedicalSearch();
    } catch (e, stackTrace) {
      log('Error during refresh: ${e.toString()}', stackTrace: stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred while refreshing');
    }
  }

  // ===============================================================
}
