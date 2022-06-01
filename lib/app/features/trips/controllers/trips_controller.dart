import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/services/firebase_services.dart';



class TripsController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  late Rx<Registrant?> user = Rx(null);
  

  final isLoading = false.obs;
  void Submit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
    };
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => new ListTile(title: new Text(doc["name"]), subtitle: new Text(doc["amount"].toString())))
        .toList();
  }



}
