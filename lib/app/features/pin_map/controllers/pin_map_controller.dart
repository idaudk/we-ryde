import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:weryde/app/constants/map_constant.dart';

class PinMapController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final isLoading = false.obs;
  final pinMoving = true.obs;

  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(34.0151, 71.5249);
  String location = "Location Name:";
  var address;

  loadPredictions() {
    PluginGooglePlacePicker.initialize(androidApiKey: Utils.googleApiKey);
  }
}
