import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/view/homepage.dart';
import 'package:resource_plus/view/shareResources.dart';

void main() {
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
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => Homepage())],
    );
  }
}
