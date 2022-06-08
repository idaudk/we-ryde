import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weryde/app/utils/models/selected_location_model.dart';

import '../../../utils/helpers/mapbox_helper.dart';

class PinMapController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    getCurrentLocation();
    super.onReady();
  }

  final searchTextField = TextEditingController();
  final isLoading = false.obs;
  final pinMoving = true.obs;
  final showPredictions = true.obs;

  //veriables for search predicitons
  late List<Placemark> placemarks;
  Timer? searchOnStoppedTyping;
  String query = '';

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng locationLatLng = LatLng(34.0151, 71.5249);
  LatLng currentLocationLatLng = LatLng(0, 0);
  String location = "Location Name:";
  var address;

  //Prediction of MAPBOX api
  List responses = [];

  //
  SelectedLocation? _selectedLocation;

  loadAddress() async {
    placemarks = await placemarkFromCoordinates(
        cameraPosition!.target.latitude, cameraPosition!.target.longitude);
    address = placemarks;
    //get place name from lat and lang
    location = placemarks.first.name.toString() +
        ", " +
        placemarks.first.subLocality.toString() +
        ", " +
        placemarks.first.locality.toString() +
        " ," +
        placemarks.first.administrativeArea.toString() +
        " ," +
        placemarks.first.isoCountryCode.toString();
    print("***********************" +
        location.toString() +
        "****************************");

    pinMoving.value = false;
    //print(cameraPosition!.target.longitude);
  }

  onChangeHandler(value) {
    // Set isLoading = true in parent
    //PrepareRide.of(context)?.isLoading = true;

    // Make sure that requests are not made
    // until 1 second after the typing stops
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping =
        Timer(const Duration(seconds: 1), () => _searchHandler(value));
  }

  _searchHandler(String value) async {
    // Get response using Mapbox Search API
    responses = await getParsedResponseForQuery(value);
    if (responses.isEmpty) {
      isLoading.value = false;
      showPredictions.value = false;
      print(
          '********************************* no response ***************************');
    } else {
      showPredictions.value = true;
      isLoading.value = false;
    }
  }

  //call this onPress floating action button
  void useCurrentLocationButtonHandler() async {
    //final GoogleMapController controller = await _controller.future;
    getCurrentLocation();
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        //bearing: 0,
        target: currentLocationLatLng,
        zoom: 17,
      ),
    ));

    Future.delayed(const Duration(milliseconds: 2500), () {
      searchTextField.text = address.first.name.toString() +
          ", " +
          address.first.subLocality.toString() +
          ", " +
          address.first.locality.toString();
    });

    //update();
  }

  selectLocationButtonHandler() {
    _selectedLocation = SelectedLocation(
      placeName: placemarks.first.name.toString(),
      completeAddress: location,
      locationLatitude: cameraPosition!.target.latitude,
      locationLongitude: cameraPosition!.target.longitude,
      cityName: placemarks.first.locality.toString(),
      subLocality: placemarks.first.subLocality.toString(),
      subThoroughfare: placemarks.first.subThoroughfare.toString(),
      postalCode: placemarks.first.postalCode
    );
    //print(_selectedLocation);
    Get.back(result: _selectedLocation);
  }

  // get current location
  void getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((currLocation) {
      currentLocationLatLng =
          LatLng(currLocation.latitude, currLocation.longitude);
    });
  }
}
