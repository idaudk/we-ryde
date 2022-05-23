import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:place_picker/place_picker.dart';
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
      target: LatLng(34.01877029295088, 71.53112872504462), zoom: 5);

  late BitmapDescriptor customIcon;

  Future<Uint8List> getMarker(context) async {
    ByteData byteData = await DefaultAssetBundle.of(context)
        .load("assets/images/raster/user.png");
    return byteData.buffer.asUint8List();
  }

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
  Completer<GoogleMapController> mapCompleter = Completer();

  // onMapCreated(GoogleMapController controller) {
  //   controller.setMapStyle(Utils.mapStyles);
  //   mapCompleter.complete(controller);
  // }

  var latitude = 'loading'.obs;
  var longitude = 'loading'.obs;
  var address = 'loading'.obs;
  late StreamSubscription<Position> streamSubscription;

  //String apikey = "AIzaSyD9YM0CFsOLiX4JIQ8AHv6yioAyoPMTOQw";
  String apikey = "AIzaSyAKo0VW69mMMtrCeJ79AXYjpqGVwr3pM9I";

  //AIzaSyAKo0VW69mMMtrCeJ79AXYjpqGVwr3pM9I

  @override
  void onInit() async {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      isLoading.value = false;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
            'assets/images/raster/user.png')
        .then((d) {
      customIcon = d;
    });
    super.onInit();
    //mapController.setMapStyle(Utils.mapStyles);
    //getLocation();
  }

  void showPlacePicker(context) async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              apikey,
            )));

    // Handle the result in your way
    print(result);
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  //   // mapController.dispose();
  //   // streamSubscription.cancel();
  // }

  void logout() async {
    await _auth.signOut().then((value) => Get.offNamed(Routes.login));
  }

  getLocation(BuildContext context) async {
    Uint8List imageData = await getMarker(context);

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

      if (mapController != null) {
        mapController
            .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                //bearing: 192.8334901395799,
                target: LatLng(position.latitude, position.longitude),
                tilt: 0,
                zoom: 15.00)));
      }
      updateMarkerAndCircle(position, imageData);
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

  void updateMarkerAndCircle(Position newLocalData, Uint8List imageData) {
    LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
    marker = Marker(
        markerId: MarkerId("home"),
        position: latLng,
        // rotation: newLocalData.heading,
        draggable: true,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.9),
        icon: BitmapDescriptor.fromBytes(imageData));
    // marker = Marker(
    //   markerId: const MarkerId("You are here"),
    //   position: latLng,
    //   rotation: newLocalData.heading as double,
    //   draggable: false,
    //   zIndex: 2,
    //   flat: true,
    //   anchor: const Offset(0.5, 0.5),
    // );
    // circle = Circle(
    //     circleId: const CircleId("Your Current Location"),
    //     radius: newLocalData.accuracy as double,
    //     zIndex: 1,
    //     strokeColor: Colors.blue,
    //     center: latLng,
    //     fillColor: Colors.blue.withAlpha(70));
    update();
  }
}
