import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/view/phoneNumber.dart';

class ShareResources extends StatelessWidget {
  const ShareResources({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Content Share',
                  style: TextStyle(
                      color: Appcolors.TextColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close))
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Recipient Information',
              style: TextStyle(
                  color: Appcolors.hintColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Appcolors.hintColor,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Enter your notes",
                  hintStyle: TextStyle(
                      color: Appcolors.hintColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                  labelText: 'Notes',
                  labelStyle: TextStyle(
                      color: Appcolors.TextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Appcolors.themeColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Appcolors.themeColor))),
            ),
            SizedBox(height: 10,),
            PhoneNumberInputExample()
          ],
        ),
      ),
    );
  }
}
