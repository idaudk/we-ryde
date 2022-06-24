import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_button/group_button.dart';

import '../../../utils/models/ride_model.dart';
import '../../../utils/models/user_model.dart';
import '../views/screens/after_confirm.dart';

class SearchPoolController extends GetxController {
  final auth = FirebaseAuth.instance;
  final phoneNumber = TextEditingController();
  final isLoading = false.obs;
  final isMapLoading = true.obs;
  var isConfirmButtonLoading = false.obs;
  //firebase  Request Ride collection Reference
  static var rideRequestCollection =
      FirebaseFirestore.instance.collection('request');

  final userMessageController = TextEditingController();
  final seatsController = GroupButtonController();

  // 'vehicleSeats': vehicleSeatController.selectedIndex!.toInt() + 1,

  UserModel? driverData;
  RideModel? rideData;

  late GoogleMapController mapController;
  Completer<GoogleMapController> mapCompleter = Completer();

  CameraPosition initialLocation = const CameraPosition(
      target: LatLng(34.01877029295088, 71.53112872504462), zoom: 5);
  Set<Marker> markers = Set<Marker>().obs;

  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  late BitmapDescriptor originPin, destinattionPin;

  @override
  void onInit() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1, 1)),
            'assets/images/raster/origin_pin.png')
        .then((d) {
      originPin = d;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(1, 1)),
            'assets/images/raster/destination_pin.png')
        .then((d) {
      destinattionPin = d;
    });
    super.onInit();
  }

  void GetVehiclesinfo() {
    //List _vehicleData = List.from(userDocument!['vehicleList']);
  }

  void valueSetter({passedDriverData, passedRideData}) {
    markers.clear();
    polylines.clear();
    driverData = passedDriverData;
    rideData = passedRideData;

    Future.delayed(const Duration(milliseconds: 3000), () {
      startLocationMarker();
      endLocationMarker();
      setPolylines();
      maplocationUpdater();
      print(
          'value setter launched ********************************************');
      print(rideData!.startPoint.latitude);
    });
  }

  void startLocationMarker() {
    LatLng selectedPosition =
        LatLng(rideData!.startPoint.latitude, rideData!.startPoint.longitude);
    markers.add(Marker(
        markerId: const MarkerId('Start Location'),
        infoWindow: const InfoWindow(title: 'Start Location'),
        icon: originPin,
        position: selectedPosition));
    update();
    //maplocationUpdater(selectedPosition);
  }

  void endLocationMarker() {
    LatLng selectedPosition =
        LatLng(rideData!.endPoint.latitude, rideData!.endPoint.longitude);
    markers.add(Marker(
        markerId: const MarkerId('Destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: destinattionPin,
        position: selectedPosition));
    update();
    //maplocationUpdater(selectedPosition);
  }

  void maplocationUpdater() {
    LatLngBounds bound;
    final LatLng offerLatLng =
        LatLng(rideData!.startPoint.latitude, rideData!.startPoint.longitude);

    var currentLatLng =
        LatLng(rideData!.endPoint.latitude, rideData!.endPoint.longitude);
    if (offerLatLng.latitude > currentLatLng.latitude &&
        offerLatLng.longitude > currentLatLng.longitude) {
      bound = LatLngBounds(southwest: currentLatLng, northeast: offerLatLng);
    } else if (offerLatLng.longitude > currentLatLng.longitude) {
      bound = LatLngBounds(
          southwest: LatLng(offerLatLng.latitude, currentLatLng.longitude),
          northeast: LatLng(currentLatLng.latitude, offerLatLng.longitude));
    } else if (offerLatLng.latitude > currentLatLng.latitude) {
      bound = LatLngBounds(
          southwest: LatLng(currentLatLng.latitude, offerLatLng.longitude),
          northeast: LatLng(offerLatLng.latitude, currentLatLng.longitude));
    } else {
      bound = LatLngBounds(southwest: offerLatLng, northeast: currentLatLng);
    }

    mapController.animateCamera(CameraUpdate.newLatLngBounds(bound, 60));
    update();
    //setPolylines();
  }

  setPolylines() async {
    polylines.clear();
    polylineCoordinates.clear();
    PolylineResult polyResult = await polylinePoints.getRouteBetweenCoordinates(
      //'AIzaSyCpc7S2R1JXMYuV6VtdX1-I9jJ4TVUiI2I',
      'AIzaSyDEiArRJg8QdgATPevCeNjwRqDl4L3-4Ak',
      PointLatLng(
          rideData!.startPoint.latitude, rideData!.startPoint.longitude),
      PointLatLng(rideData!.endPoint.latitude, rideData!.endPoint.longitude),
      // polyline middle away edition

      // wayPoints: [PolylineWayPoint(location: "33.6844,73.0479")]
      // SOURCE_LOCATION,
      // DEST_LOCATION,
    );
    if (polyResult.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      polyResult.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      print('polyresult not empty');
    }
    // create a Polyline instance
    // with an id, an RGB color and the list of LatLng pairs
    Polyline polyline = Polyline(
        polylineId: PolylineId("ways"),
        color: Color(0xFF0ec874),
        jointType: JointType.round,
        width: 3,
        geodesic: true,
        //patterns: <PatternItem>[PatternItem.dash(25), PatternItem.gap(15)],
        points: polylineCoordinates);

    // add the constructed polyline as a set of points
    // to the polyline set, which will eventually
    // end up showing up on the map
    polylines.add(polyline);
    print(polylines.first.points);
    update();
  }

  sendRequestToJoin({
    required String rideID,
    required String driverID,
    required String passangerID,
    required String startAddress,
    required LatLng startPoint,
    required String endAddress,
    required LatLng endPoint,
    required String message,
    required int seats,
  }) async {
    // showLoading();
    isConfirmButtonLoading.value = true;

    rideRequestCollection.add({
      "passangerID": passangerID,
      "rideID": rideID,
      "driverID": driverID,
      "startPoint": GeoPoint(startPoint.latitude, startPoint.longitude),
      "startAddress": startAddress,
      "endPoint": GeoPoint(endPoint.latitude, endPoint.longitude),
      "endAddress": endAddress,
      "message": message,
      "seats": seats,
      "isConfirmed": false,
      "requestedAt": DateTime.now().microsecondsSinceEpoch,
    }).then((value) {
      // print(value.id);

      rideRequestCollection
          .doc(value.id)
          .update({"requestId": value.id}).then((value) {
        isConfirmButtonLoading.value = false;
        Get.to(()=> ConfirmScreen(),
            transition: Transition.zoom, curve: Curves.easeIn);
        // Get.to(() => RideScreen(currentTab: 1));
      }).catchError((error) {
        print("Failed to Sent Request: $error");
        Get.snackbar("Failed to Post Ride", "Please Try again!");
      });
    }).catchError((error) {
      print("Failed to Post Ride Request: $error");
      Get.snackbar("Failed to Post Ride Request", "Please Try again!");
    });
  }
}
