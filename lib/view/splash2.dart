import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/customWidgets/customWidgets.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/svg/welcomtext.svg', height: 75),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'A one-stop platform for the resources you need to \ntransform lives.',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Appcolors.TextColor),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(child: SvgPicture.asset('assets/svg/splashimg.svg')),
            SizedBox(
              height: 35,
            ),
            Spacer(),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.offNamed('/Login');
                      },
                      child: Customwidgets().customContainer(
                          text: 'SIGN IN',
                          width: MediaQuery.of(context).size.width * 0.42)),
                  GestureDetector(
                      onTap: () {
                        Get.offNamed('/Signup');
                      },
                      child: Customwidgets().customContainer(
                          text: 'SIGN UP',
                          width: MediaQuery.of(context).size.width * 0.42)),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
