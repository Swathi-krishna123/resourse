import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/controller/appcontroller.dart';

class ShareResourcesController extends GetxController {
  TextEditingController notesController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode notesFocusNode = FocusNode();
  FocusNode phone1FocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  var additionalPhoneControllers = <TextEditingController>[].obs;
  var additionalPhoneFocusNodes = <FocusNode>[].obs;

  var allPhoneControllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    Appcontroller appcontroller = Get.put(Appcontroller());
    super.onInit();
    allPhoneControllers.add(phone1Controller);
    appcontroller.isLoading.value = false;
    appcontroller.isSuccess.value = false;
  }

  void addPhoneField() {
    var newController = TextEditingController();
    var newFocusNode = FocusNode();

    additionalPhoneControllers.add(newController);
    additionalPhoneFocusNodes.add(newFocusNode);

    allPhoneControllers.add(newController);
  }

  void removePhoneField(int index) {
    additionalPhoneControllers[index].dispose();
    additionalPhoneFocusNodes[index].dispose();

    additionalPhoneControllers.removeAt(index);
    additionalPhoneFocusNodes.removeAt(index);

    allPhoneControllers.removeAt(index + 1);
  }

  void clearAll() {
    notesController.clear();
    phone1Controller.clear();
    emailController.clear();

    for (var controller in additionalPhoneControllers) {
      controller.dispose();
    }
    for (var focusNode in additionalPhoneFocusNodes) {
      focusNode.dispose();
    }

    additionalPhoneControllers.clear();
    additionalPhoneFocusNodes.clear();
    allPhoneControllers.clear();

    allPhoneControllers.add(phone1Controller);
  }

  @override
  void onClose() {
    notesController.dispose();
    phone1Controller.dispose();
    emailController.dispose();
    notesFocusNode.dispose();
    phone1FocusNode.dispose();
    emailFocusNode.dispose();

    for (var controller in additionalPhoneControllers) {
      controller.dispose();
    }
    for (var focusNode in additionalPhoneFocusNodes) {
      focusNode.dispose();
    }
    super.onClose();
  }
}
