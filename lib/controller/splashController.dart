import 'package:get/get.dart';
import 'package:resource_plus/utilities/sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  
SharedPrefHelper sharedPrefHelper = SharedPrefHelper();
  @override
  void onInit() {
    super.onInit();
   
    Future.delayed(const Duration(seconds: 3), checkAuthentication);
  }

  
  void checkAuthentication() async {
    final token = await sharedPrefHelper.getToken();
    if (token != null) {
      Get.offNamed('/');
    } else {
      Get.offNamed('/Splash2');
    }
  }
}
