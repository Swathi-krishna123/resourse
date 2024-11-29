import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/appcontroller.dart';
import 'package:resource_plus/controller/shareResourcesController.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class ShareResources extends StatelessWidget {
  ShareResources({super.key});

  final ShareResourcesController controller =
      Get.put(ShareResourcesController());
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Appcontroller appcontroller = Get.put(Appcontroller());
    return Scaffold(
      appBar: Customwidgets().customAppbar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Content Share',
                    style: TextStyle(
                      color: Appcolors.TextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Recipient Information',
                    style: TextStyle(
                      color: Appcolors.hintColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(color: Appcolors.hintColor.withOpacity(0.44)),
                  const SizedBox(height: 10),
                  Customwidgets().contentsharefields(
                    hintText: 'Enter your notes',
                    labelText: 'Notes',
                    controller: controller.notesController,
                    focusNode: controller.notesFocusNode,
                  ),
                  const SizedBox(height: 10),
                  Customwidgets().contentsharefields(
                    hintText: '( 1 )  XXXXX XXXXX',
                    labelText: 'Phone 1',
                    controller: controller.phone1Controller,
                    focusNode: controller.phone1FocusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone number is required";
                      }

                      // Ensure the value starts with a country code (1–4 digits)
                      if (!RegExp(r'^\d{1,4}\d{7,15}$').hasMatch(value)) {
                        return "Enter a valid phone number with country code";
                      }

                      // Check if the country code is valid (optional)
                      final validCountryCodes = [
                        "1", "91", "44", "86", "20", // Add more as needed
                      ];
                      String countryCode = value.substring(
                          0,
                          value.length -
                              10); // Assuming last 10 digits are phone number
                      if (!validCountryCodes.contains(countryCode)) {
                        return "Invalid country code";
                      }

                      return null; // Valid input
                    },
                  ),
                  Obx(
                    () => Column(
                      children: List.generate(
                        controller.additionalPhoneControllers.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Customwidgets().contentsharefields(
                                    hintText: '( 1 )  XXXXX XXXXX',
                                    labelText: 'Phone ${index + 2}',
                                    controller: controller
                                        .additionalPhoneControllers[index],
                                    focusNode: controller
                                        .additionalPhoneFocusNodes[index],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Phone number is required";
                                      }

                                      // Ensure the value starts with a country code (1–4 digits)
                                      if (!RegExp(r'^\d{1,4}\d{7,15}$')
                                          .hasMatch(value)) {
                                        return "Enter a valid phone number with country code";
                                      }

                                      // Check if the country code is valid (optional)
                                      final validCountryCodes = [
                                        "1", "91", "44", "86",
                                        "20", // Add more as needed
                                      ];
                                      String countryCode = value.substring(
                                          0,
                                          value.length -
                                              10); // Assuming last 10 digits are phone number
                                      if (!validCountryCodes
                                          .contains(countryCode)) {
                                        return "Invalid country code";
                                      }

                                      return null; // Valid input
                                    },
                                    suffixIcon: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        decoration: BoxDecoration(
                                            color: Appcolors.themeColor
                                                .withOpacity(0.70),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                        child: TextButton(
                                            onPressed: () {
                                              controller
                                                  .removePhoneField(index);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            )))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.addPhoneField,
                    child: Text(
                      'Add +',
                      style: TextStyle(color: Appcolors.themeColor),
                    ),
                  ),
                  Customwidgets().contentsharefields(
                    hintText: 'abcd1234@gmail.com',
                    labelText: 'Email',
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        try {
                          if (_formkey.currentState!.validate()) {
                            appcontroller.sendResources();
                            Get.toNamed('/');
                            appcontroller.selectedItems.clear();
                            appcontroller.medicalSearchDetails.clear();
                            controller.clearAll();
                          }
                        } catch (e) {
                          Get.snackbar('Error', e.toString());
                        }
                      },
                      child: Container(
                        height: 60,
                        width: 121.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Appcolors.themeColor.withOpacity(0.14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Center(
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Appcolors.themeColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Send',
                              style: TextStyle(
                                color: Appcolors.themeColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
