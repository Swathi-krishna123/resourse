import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offNamed('/');
    
    });
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/svg/applogo.svg',
          height: 40,
        ),
      ),
    );
  }
}
