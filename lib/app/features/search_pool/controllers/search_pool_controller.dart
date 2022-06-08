import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/models/user_model.dart';

class SearchPoolController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final phoneNumber = TextEditingController();
  final isLoading = false.obs;
  UserModel? driverData;

  @override
  void onInit() {
    // TODO: implement onInit

    //getDriverData(ride)
    super.onInit();
  }

  getDriverData(ride) {
    Future.delayed(const Duration(milliseconds: 3000), () {
      FirebaseFirestore.instance
          .collection('users')
          .doc(ride.driverID)
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
            driverData = UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);      
        } else {
          print("User document not found");
        }
      });
    });
  }

  void GetVehiclesinfo() {
    //List _vehicleData = List.from(userDocument!['vehicleList']);
  }
}
