import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/utils/services/firebase_services.dart';

class RegistrationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final isLoading = false.obs;

  void goToLoginScreen() {
    Get.offNamed(Routes.login);
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      var updatedNumberwithCountryCode = "+92"+phoneNumber.text.trim();
      print("User number is :" + updatedNumberwithCountryCode.toString());
      //UserServices.phoneNumberExists(phoneNumber.text.trim(), onError: (_) {})
      UserServices.phoneNumberExists(updatedNumberwithCountryCode, onError: (_) {})
          .then((exist) {
        isLoading.value = false;
        if (exist) {
          Get.snackbar(
            "Registration Failed",
            "Phone Number already exists",
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            "Sending OTP",
            "check your message",
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          Get.toNamed(
            Routes.authentication,
            arguments:
                Registrant(name: name.text, phoneNumber: updatedNumberwithCountryCode),
          );
        }
      });
    }
  }
}
