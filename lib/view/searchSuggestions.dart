import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resource_plus/constants/colors.dart';
import 'package:resource_plus/controller/appcontroller.dart';

class Searchsuggestions extends StatelessWidget {
  const Searchsuggestions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Appcontroller());
    return Scaffold(
      body: Center(child:ListView(children: [
        TextButton(onPressed: (){
          controller.isLoading.value=true;
        controller.fetchMedicalSearch();
        }, child: Text('data '),),
      ],),),
    );
  }
}