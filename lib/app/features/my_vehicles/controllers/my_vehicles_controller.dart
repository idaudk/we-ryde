import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:weryde/app/utils/models/vehicle_model.dart';

import '../../../utils/services/firebase_services.dart';

class MyVehiclesController extends GetxController {
  final auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  late Rx<Registrant?> user = Rx(null);

  List<VehicleModel> vehicleModelList = [];

  final isLoading = true.obs;
  final isButtonLoading = false.obs;

  final vehicleTypeController = TextEditingController();
  final vehicleNameController = TextEditingController();
  final vehicleRegNoController = TextEditingController();
  final vehicleSeatController = GroupButtonController();
  final vehicleFacilitiesController = TextEditingController();
  final vehicleInstructionsController = TextEditingController();

  @override
  void onInit() {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      print(auth.currentUser!.uid.toString());
      VehicleListFromSnapshot();
      isLoading.value = false;
    });

    super.onInit();
  }

  VehicleListFromSnapshot() async {
    var document =
        await _firestore.collection('users').doc(auth.currentUser!.uid);
    document.get().then((document) {
      var userDocument = document.data();
      var vehicleData = List.from(userDocument!['vehicleList']);
      print(vehicleData.length);
      vehicleData.forEach((element) {
        print(element['vehicleName']);
        vehicleModelList.add(VehicleModel(
            vehicleOwnerId: element['vehicleOwnerId'],
            vehicleName: element['vehicleName'],
            vehilceType: element['vehilceType'],
            vehicleRegNo: element['vehicleRegNo'],
            vehicleSeats: element['vehicleSeats'],
            vehicleFacilities: element['vehicleFacilities'],
            vehicleInstructions: element['vehicleInstructions']));
      });
      //print(vehicleModelList.length);
    });
  }

  //late Stream<DocumentSnapshot<Map<String, dynamic>>> stream = _firestore.collection("users").doc(auth.currentUser!.uid).snapshots();

//   stream.forEach((QuerySnapshot element) {

//   if(element == null)
//     return;

//   for(int count=0;count<element.documents.length;count++) {
//     print(element.documents[count].data.toString());
//   }
// });

  void saveButtonHandler() async {
    isButtonLoading.value = true;

    try {
      await _firestore.collection('users').doc(auth.currentUser!.uid).update({
        'vehicleList': FieldValue.arrayUnion([
          {
            'vehicleOwnerId': auth.currentUser!.uid,
            'vehicleName': vehicleNameController.text,
            'vehilceType': vehicleTypeController.text,
            'vehicleRegNo': vehicleRegNoController.text,
            'vehicleSeats': vehicleSeatController.selectedIndex!.toInt() + 1,
            'vehicleFacilities': vehicleFacilitiesController.text,
            'vehicleInstructions': vehicleInstructionsController.text
          }
        ])
      }).then((value) {
        isButtonLoading.value = false;
        Get.back();
        Get.snackbar('Vehicle Added', 'Vehicle information saved sucessfully.');
      });
    } catch (e) {
      Get.snackbar('Error', 'Server Responded: ' + e.toString());
    }
  }

  // List<VehicleModel> VehicleListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return VehicleModel(
  //       vehicleOwnerId: doc.data(),
  //       vehicleName: vehicleName,
  //       vehilceType: vehilceType,
  //       vehicleRegNo: vehicleRegNo, vehicleSeats: vehicleSeats, vehicleFacilities: vehicleFacilities, vehicleInstructions: vehicleInstructions)
  //   }).toList();
  // }

  // void saveButtonHandler() async {
  //   isButtonLoading.value = true;
  //   await _firestore
  //       .collection('vehicles')
  //       .doc(vehicleRegNoController.text.toString())
  //       .set({
  // 'vehicleOwnerId': _auth.currentUser!.uid,
  // 'vehicleName': vehicleNameController.text,
  // 'vehilceType': vehicleTypeController.text,
  // 'vehicleRegNo': vehicleRegNoController.text,
  // 'vehicleSeats': vehicleSeatController.selectedIndex!.toInt() + 1,
  // 'vehicleFacilities': vehicleFacilitiesController.text,
  // 'vehicleInstructions': vehicleInstructionsController.text
  //   }, SetOptions(merge: true)).then((value) {
  //     isButtonLoading.value = false;
  //     //if (onSuccess != null) onSuccess();
  //   });
  // }

  // void saveButtonHandler() async {
  //   isButtonLoading.value = true;
  //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
  //     'vehicleList': [
  //       {'vehicleName': 'mark', 'vehicleRegNo': 'asd 345'}
  //     ]
  //   }) .then((value) {
  //     isButtonLoading.value = false;
  //   });
  // }

}
