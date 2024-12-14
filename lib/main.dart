import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/view/homepage.dart';
import 'package:resource_plus/view/login.dart';
import 'package:resource_plus/view/otp.dart';
import 'package:resource_plus/view/signUp.dart';
import 'package:resource_plus/view/splash2.dart';
import 'package:resource_plus/view/splashScreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Resource Plus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.urbanistTextTheme(),
          scaffoldBackgroundColor: Appcolors.backgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: Appcolors.backgroundColor,
            centerTitle: true,
          )),
      initialRoute: '/Splashscreen',
      getPages: [
        GetPage(name: '/', page: () => Homepage()),
        GetPage(name: '/Splashscreen', page: () => Splashscreen()),
        GetPage(name: '/Splash2', page: () => Splash2()),
        GetPage(name: '/Login', page: () => Login()),
        GetPage(name: '/Signup', page: () => Signup()),
        GetPage(name: '/OtpScreen', page: () => OtpScreen()),
      ],
    );
  }
}
