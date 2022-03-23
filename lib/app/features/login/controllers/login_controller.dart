import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/utils/services/firebase_services.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final phoneNumber = TextEditingController();
  final isLoading = false.obs;

  void goToRegistrationScreen() {
    Get.offNamed(Routes.registration);
  }

  void goToAuthenticationScreen() {
    Get.toNamed(Routes.authentication);
  }

  void login() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      var phoneNumberWithCountryCode =  "+92"+phoneNumber.text.trim();
      //await UserServices.phoneNumberExists(phoneNumber.text.trim(),
      await UserServices.phoneNumberExists(phoneNumberWithCountryCode,
          onError: (_) {
        isLoading.value = false;
      }).then((exist) {
        isLoading.value = false;
        if (exist) {
          Get.toNamed(
            Routes.authentication,
            parameters: {'phone_number': phoneNumberWithCountryCode},
          );
        } else {
          Get.snackbar(
            "Login Failed",
            "your phone number not exist",
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });
    }
  }
}
