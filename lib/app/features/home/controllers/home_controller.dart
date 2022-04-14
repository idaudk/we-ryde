import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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
  List<AutocompletePrediction> predictions = [];

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
      getLocation();
    });
    super.onInit();
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
}
