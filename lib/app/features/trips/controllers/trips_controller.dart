import 'package:flutter/material.dart';
import 'package:get/get.dart';



class TripsController extends GetxController{
  
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  final isLoading = false.obs;
  void Submit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
    };
  }
}
