import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';
import '../../../utils/services/firebase_services.dart';

class UserProfileController extends GetxController {
  final _auth = FirebaseAuth.instance;
  late Rx<Registrant?> user = Rx(null);

  var name = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();

  var isLoading = true.obs;

  @override
  void onInit() async {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      name.text = result!.name;
      email.text = result.emailAddress;
      phoneNumber.text = result.phoneNumber;
      isLoading.value = false;
    });
    super.onInit();
  }

  void logout() async {
    await _auth.signOut().then((value) => Get.offNamed(Routes.login));
  }
}
