import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/utils/services/firebase_services.dart';

class HomeController extends GetxController {
  final _auth = FirebaseAuth.instance;
  late Rx<Registrant?> user = Rx(null);
  var isLoading = true.obs;
  var isLocationLocation = true.obs;

  final startSearchFieldController = TextEditingController();
  final endSearchFieldController = TextEditingController();

  late GooglePlace googlePlace;
  late Circle circle = Circle(circleId: CircleId('Home'));
  CameraPosition? kGoogleplace;
  CameraPosition initialLocation = CameraPosition(
      target: LatLng(34.01877029295088, 71.53112872504462), zoom: 14.4746);
  late Marker marker = const Marker(markerId: MarkerId("1"));
  //List<Marker> marker = [];
  // List<Marker> list = const [
  //   Marker(
  //       infoWindow: InfoWindow(title: "My Location"),
  //       markerId: MarkerId("1"),
  //       position: LatLng(27.2046, 77.4977))
  // ];
  // List<AutocompletePrediction> predictions = [];
  late GoogleMapController mapController;

  var latitude = 'loading'.obs;
  var longitude = 'loading'.obs;
  var address = 'loading'.obs;
  late StreamSubscription<Position> streamSubscription;

  String apikey = "AIzaSyD9YM0CFsOLiX4JIQ8AHv6yioAyoPMTOQw";

  @override
  void onInit() async {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      isLoading.value = false;
    });
    super.onInit();
    getLocation();
    //kGoogleplace = CameraPosition(target: target)
    //marker.addAll(list);
  }

  void logout() async {
    await _auth.signOut().then((value) => Get.offNamed(Routes.login));
  }

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    //test if the location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Services are Disbaled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permenently denied, we cannot request permissions.');
    }
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude.toString();
      longitude.value = position.longitude.toString();
      getAddressFromlatLang(position);
      // kGoogleplace = CameraPosition(
      //     target: LatLng(position.latitude, position.longitude), zoom: 14);

      if (mapController != null)
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(position.latitude, position.longitude),
                tilt: 0,
                zoom: 15.00)));
      updateMarkerAndCircle(position);
      update();
    });
  }

  Future<void> getAddressFromlatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
    address.value = '${place.subLocality}, ${place.locality}, ${place.country}';
    startSearchFieldController.text = address.value;
    isLocationLocation.value = false;
  }

  void updateMarkerAndCircle(Position newLocalData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    marker = Marker(
      markerId: const MarkerId("You are here"),
      position: latLng,
      rotation: newLocalData.heading as double,
      draggable: false,
      zIndex: 2,
      flat: true,
      anchor: const Offset(0.5, 0.5),
    );
    circle = Circle(
        circleId: const CircleId("Your Current Location"),
        radius: newLocalData.accuracy as double,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70));

    // mapController.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
    //           bearing: 192.8334901395799,
    //           target: LatLng(newLocalData.latitude, newLocalData.longitude),
    //           tilt: 0,
    //           zoom: 18.00)));
    update();
  }
}
