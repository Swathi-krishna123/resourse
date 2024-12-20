import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resource_plus/controller/shareResourcesController.dart';
import 'package:resource_plus/utilities/diohandler.dart';
import 'package:resource_plus/utilities/sharedpreference.dart';

class Appcontroller extends GetxController {
  final DateTime now = DateTime.now();
  SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
  TextEditingController searchController = TextEditingController();

  var isLoading = false.obs;
  var isError = false.obs;
  var medicalSearch = <Map<String, dynamic>>[].obs;
  var medicalSearchDetails = <Map<String, dynamic>>[].obs;
  var filteredMedicalSearch = <Map<String, dynamic>>[].obs;
  var selectedItems = <Map<String, dynamic>>[].obs;
  var isSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicalSearch();

    isSuccess.value = false;
  }

  Future<void> fetchMedicalSearch() async {
    try {
      isLoading.value = true;
      String formattedDate = DateFormat("MM/dd/yyyy").format(now);

      String? token = await sharedPrefHelper.getToken();

      var body = {
        "Token": token,
        "Action": "CONTENT",
        "Mode": "MOBILE",
        "Lts": formattedDate,
        "BrowseInfo": "user agaent info",
      };

      int attempt = 0;
      int maxRetries = 10;
      bool success = false;

      while (!success) {
        attempt++;
        log("Attempt $attempt: Sending request to fetchMedicalSearch");
        var response = await DioHandler.readMedical(body: body);

        if (response['Status'] == 1) {
          var data = response['Data'];
          log("Response data: $data");

          if (data != null && data.isNotEmpty) {
            medicalSearch
                .assignAll(List<Map<String, dynamic>>.from(data[0] ?? []));
            filteredMedicalSearch.assignAll(medicalSearch);
            log("Data successfully fetched and assigned.");
            log("medial search:$medicalSearch");
          } else {
            isError.value = true;
            Get.snackbar('Error', 'Data is empty');
          }
          success = true;
        } else {
          isError.value = true;
          isLoading.value = false;

          log("Attempt $attempt failed. Status: ${response['Status']}, Error: ${response['ErrorMsg'] ?? 'Unknown error'}");

          if (attempt >= maxRetries) {
            Get.snackbar('Error', 'Failed after $maxRetries attempts');
            break;
          }

          await Future.delayed(Duration(seconds: attempt * 2));
        }
      }
    } catch (e, stackTrace) {
      isLoading.value = false;

      log('Exception: ${e.toString()}', stackTrace: stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMedicalSearchDetails() async {
    try {
      var ids = selectedItems.map((item) => item['id']).toList();
      var formattedIds = ids.join(', ');

      isLoading.value = true;
      String formattedDate = DateFormat("MM/dd/yyyy").format(now);
      String? token = await sharedPrefHelper.getToken();
      var body = {
        "Token": token,
        "Action": "CONTENT",
        "Mode": "MOBILE",
        "Lts": formattedDate,
        "BrowseInfo": "",
        "Tags": [
          {"T": "c1", "V": formattedIds},
          {"T": "c10", "V": "1"},
        ]
      };

      var response = await DioHandler.readMedical(body: body);

      if (response['Status'] == 1) {
        var data = response['Data'];

        if (data != null && data.isNotEmpty) {
          medicalSearchDetails
              .assignAll(List<Map<String, dynamic>>.from(data[0] ?? []));

          log("medicalSearchDetails $medicalSearchDetails");
          List<int> mids =
              medicalSearchDetails.map((entry) => entry["id"] as int).toList();
          log("medical search details ids $mids");
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
      isLoading.value = false;
    }
  }

  void removeMedicalSearchDetails(Map<String, dynamic> item) async {
    var ids = selectedItems.map((item) => item['id']).toList();
    var formattedIds = ids.join(', ');

    try {
      log("Removing item with id: ${item['id']}");
      log("Removing item with id: ${item['nm']}");

      selectedItems.removeWhere((element) => element['id'] == item['id']);
      selectedItems.refresh();
      searchController.clear();

      medicalSearchDetails.removeWhere(
          (element) => element[formattedIds] == item[formattedIds]);
      medicalSearchDetails.refresh();

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

  Future<void> sendResources() async {
    ShareResourcesController shareResourcesController =
        Get.put(ShareResourcesController());
    try {
      List<String> phoneNumbers = shareResourcesController.allPhoneControllers
          .map((controller) => controller.text)
          .where((number) =>
              number.isNotEmpty && RegExp(r'^\d+$').hasMatch(number))
          .toList();
      var phoneNumbersExtracted = phoneNumbers.join(', ');

      isLoading.value = true;
      var ids = medicalSearchDetails.map((item) => item['id']).toList();
      var medicalSearchDetailsid = ids.join(', ');
      var email = shareResourcesController.emailController.text;
      var notes = shareResourcesController.notesController.text;

      log('email........$email');
      log('notes........$notes');
      log('medical search ids........$medicalSearchDetailsid');
      log('phone numbers........$phoneNumbersExtracted');
      String formattedDate = DateFormat("MM/dd/yyyy").format(now);
      String? token = await sharedPrefHelper.getToken();
      var body = {
        "Token": token,
        "Action": "CONTENT",
        "Mode": "MOBILE",
        "Lts": formattedDate,
        "BrowseInfo": "",
        "Tags": [
          {"T": "c1", "V": medicalSearchDetailsid},
          {"T": "c2", "V": phoneNumbersExtracted},
          {"T": "c3", "V": email},
          {"T": "c4", "V": notes},
          {"T": "c10", "V": 2}
        ]
      };

      var response = await DioHandler.readMedical(body: body);

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
      isLoading.value = false;
    }
  }

  void refreshData() {
    try {
      log("Refreshing data...");

      medicalSearch.clear();
      medicalSearchDetails.clear();
      filteredMedicalSearch.clear();
      selectedItems.clear();

      isLoading.value = false;
      isSuccess.value = false;

      searchController.clear();

      fetchMedicalSearch();
    } catch (e, stackTrace) {
      log('Error during refresh: ${e.toString()}', stackTrace: stackTrace);
      Get.snackbar('Error', 'An unexpected error occurred while refreshing');
    }
  }
}
