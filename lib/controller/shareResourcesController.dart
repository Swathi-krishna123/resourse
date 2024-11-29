import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShareResourcesController extends GetxController {
  // Controllers for static fields
  TextEditingController notesController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode notesFocusNode = FocusNode();
  FocusNode phone1FocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  // Reactive lists for dynamic phone fields
  var additionalPhoneControllers = <TextEditingController>[].obs;
  var additionalPhoneFocusNodes = <FocusNode>[].obs;

  // Combined list of all phone controllers (static + dynamic)
  var allPhoneControllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize the combined list with the static phone controller
    allPhoneControllers.add(phone1Controller);
  }

  // Add a new phone field
  void addPhoneField() {
    // Create new controllers and add them to respective lists
    var newController = TextEditingController();
    var newFocusNode = FocusNode();

    additionalPhoneControllers.add(newController);
    additionalPhoneFocusNodes.add(newFocusNode);

    // Update the combined list
    allPhoneControllers.add(newController);
  }

  // Remove a phone field
  void removePhoneField(int index) {
    // Dispose of the specific controllers and focus nodes
    additionalPhoneControllers[index].dispose();
    additionalPhoneFocusNodes[index].dispose();

    // Remove from the respective lists
    additionalPhoneControllers.removeAt(index);
    additionalPhoneFocusNodes.removeAt(index);

    // Update the combined list (start from the second item to skip phone1Controller)
    allPhoneControllers
        .removeAt(index + 1); // +1 because phone1Controller is at index 0
  }

  // Clear all fields and reset lists
  void clearAll() {
    // Clear static fields
    notesController.clear();
    phone1Controller.clear();
    emailController.clear();

    // Dispose and clear dynamic fields
    for (var controller in additionalPhoneControllers) {
      controller.dispose();
    }
    for (var focusNode in additionalPhoneFocusNodes) {
      focusNode.dispose();
    }

    additionalPhoneControllers.clear();
    additionalPhoneFocusNodes.clear();
    allPhoneControllers.clear();

    // Reinitialize the combined list with phone1Controller
    allPhoneControllers.add(phone1Controller);
  }

  @override
  void onClose() {
    // Dispose static controllers and focus nodes
    notesController.dispose();
    phone1Controller.dispose();
    emailController.dispose();
    notesFocusNode.dispose();
    phone1FocusNode.dispose();
    emailFocusNode.dispose();

    // Dispose dynamic controllers and focus nodes
    for (var controller in additionalPhoneControllers) {
      controller.dispose();
    }
    for (var focusNode in additionalPhoneFocusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}
