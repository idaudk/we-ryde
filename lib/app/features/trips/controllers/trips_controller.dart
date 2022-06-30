import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weryde/app/utils/models/request_ride_model.dart';
import 'package:weryde/app/utils/models/ride_model.dart';

import '../../../utils/services/firebase_services.dart';

class TripsController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  late Rx<Registrant?> user = Rx(null);

  var goneToOtherPage = false.obs;

  var isButtonLoading = false.obs;

  // Firebase references
  static var rideRequestCollection =
      FirebaseFirestore.instance.collection('request');
  static var rideInfoCollection = FirebaseFirestore.instance.collection('ride');

  final isLoading = false.obs;
  void Submit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
    }
  }

  Future<int?> getCurrentConfirmedSeats(String Id) async {
    DocumentReference documentReference = rideInfoCollection.doc(Id);
    int? confirmedSeats;
    await documentReference.get().then((snapshot) {
      confirmedSeats = snapshot['confirmedSeats'];
    });
    return confirmedSeats;
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => new ListTile(
            title: new Text(doc["name"]),
            subtitle: new Text(doc["amount"].toString())))
        .toList();
  }

  acceptButtonHandler(
      {required RideModel rideModel,
      required RequestModel requestModel}) async {
    isButtonLoading.value = true;

    int? confirmedSeats = await getCurrentConfirmedSeats(rideModel.id);

    rideRequestCollection
        .doc(requestModel.requestID)
        .update({'isConfirmed': true});

    rideInfoCollection.doc(requestModel.rideID).update(
      {
        'confirmedSeats': requestModel.seats + confirmedSeats!,
        'confirmedRideList': FieldValue.arrayUnion([
          requestModel.requestID
        ])
      },
    );
    // rideInfoCollection.doc(requestModel.rideID).

    isButtonLoading.value = false;
    print(confirmedSeats);

    // print(rideModel.confirmedSeats);
  }
}
