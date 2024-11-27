import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberInputExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PhoneNumber number = PhoneNumber(isoCode: 'US'); // Default country code

    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber value) {
        print('Phone Number: ${value.phoneNumber}');
      },
      onInputValidated: (bool isValid) {
        print('Is valid: $isValid');
      },
      selectorConfig: SelectorConfig(
        selectorType:
            PhoneInputSelectorType.DROPDOWN, // Dropdown or BottomSheet
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      initialValue: number,
      textFieldController: TextEditingController(),
      formatInput: true,
      inputDecoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
