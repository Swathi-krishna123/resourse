import 'dart:developer';
import 'package:get/get.dart';
import 'package:resource_plus/utilities/diohandler.dart';

class Appcontroller extends GetxController {
  // Observables for state management
  var isLoading = false.obs;
  var medicalSearch = <Map<String, dynamic>>[].obs; // Strongly typed list
  var filteredMedicalSearch = <Map<String, dynamic>>[].obs;
  var selectedItems = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMedicalSearch();
  }

  Future<void> fetchMedicalSearch() async {
    try {
      isLoading.value = true; // Start loading

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
          medicalSearch.assignAll(List<Map<String, dynamic>>.from(data[0] ?? []));
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
}
