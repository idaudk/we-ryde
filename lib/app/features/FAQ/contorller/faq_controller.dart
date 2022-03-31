import 'package:flutter/material.dart';
import 'package:get/get.dart';
class FaqContorller extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final feedback = TextEditingController();
  final isLoading = false.obs;
  void Submit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

    };
  }
}
