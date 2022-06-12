import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../utils/models/user_model.dart';

class SearchPoolController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final phoneNumber = TextEditingController();
  final isLoading = false.obs;
  UserModel? driverData;

  late GoogleMapController mapController;
  CameraPosition initialLocation = CameraPosition(
      target: LatLng(34.01877029295088, 71.53112872504462), zoom: 5);
  Set<Marker> markers = Set<Marker>().obs;

   Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  late BitmapDescriptor originPin, destinattionPin;

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
