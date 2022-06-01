import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/utils/models/vehicle_model.dart';
import 'package:weryde/app/utils/services/firebase_services.dart';

import '../../../utils/models/selected_location_model.dart';

class HomeController extends GetxController {
  final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  late Rx<Registrant?> user = Rx(null);
  var isLoading = true.obs;
  var isbuttonLoading = false.obs;

  final endSearchFieldController = TextEditingController();

  //start and drop locations for offer pool tab   ********************************
  SelectedLocation? offerPoolStartLocation;
  final offerPoolStartLocationController = TextEditingController();
  SelectedLocation? offerPoolDropLocation;
  final offerPoolDropLocationController = TextEditingController();
  List<Map<String, dynamic>> selectVehicleValues = [];
  final selectVehicleController = TextEditingController();
  final offerPoolMessageController = TextEditingController();
  final offerPoolDateController = TextEditingController();
  final offerPoolTimeController = TextEditingController();
  late TimeOfDay? startTime;
  late DateTime? startDate;

  // vehilce model for getting vehicles info of user
  final List<VehicleModel> _vehicleModelList = [];
  VehicleModel? _selectedVehicleDataModel; //String? selectedVehicleId;

  //Google map variables  *********************************
  late GooglePlace googlePlace;
  late Circle circle = Circle(circleId: CircleId('Home'));
  CameraPosition? kGoogleplace;
  CameraPosition initialLocation = CameraPosition(
      target: LatLng(34.01877029295088, 71.53112872504462), zoom: 5);
  Set<Marker> markers = Set<Marker>().obs;

  // api(direction api enabled) from another github repository
  //AIzaSyDEiArRJg8QdgATPevCeNjwRqDl4L3-4Ak

  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  late BitmapDescriptor originPin, destinattionPin;

  //int polygonIdCounter = 1;

  late GoogleMapController mapController;
  Completer<GoogleMapController> mapCompleter = Completer();

  // var latitude = 'loading'.obs;
  // var longitude = 'loading'.obs;
  // var address = 'loading'.obs;
  // late StreamSubscription<Position> streamSubscription;

  //String apikey = "AIzaSyD9YM0CFsOLiX4JIQ8AHv6yioAyoPMTOQw";
  String apikey = "AIzaSyCpc7S2R1JXMYuV6VtdX1-I9jJ4TVUiI2I";

  //AIzaSyAKo0VW69mMMtrCeJ79AXYjpqGVwr3pM9I

  @override
  void onInit() async {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      vehicleDataFetcher();
      isLoading.value = false;
    });
    permissionGetter();
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
    //mapController.setMapStyle(Utils.mapStyles);
    //getLocation();
  }

  void startLocationMapHandler() {
    LatLng selectedPosition = LatLng(offerPoolStartLocation!.locationLatitude,
        offerPoolStartLocation!.locationLongitude);
    markers.add(Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        //icon: originPin,
        icon: originPin,
        //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: selectedPosition));
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(offerPoolStartLocation!.locationLatitude,
            offerPoolStartLocation!.locationLongitude),
        zoom: 16)));
    update();
    if (polylineCoordinates.isNotEmpty) {
      setPolylines();
    }
  }

  void dropLocationMapHandler() {
    LatLng selectedPosition = LatLng(offerPoolDropLocation!.locationLatitude,
        offerPoolDropLocation!.locationLongitude);
    markers.add(Marker(
        markerId: const MarkerId('Destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: destinattionPin,
        position: selectedPosition));
    maplocationUpdater(selectedPosition);
  }

  void maplocationUpdater(selectedPosition) {
    LatLngBounds bound;
    final LatLng offerLatLng = selectedPosition;
    var currentLatLng = LatLng(offerPoolStartLocation!.locationLatitude,
        offerPoolStartLocation!.locationLongitude);
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
    setPolylines();
  }

  setPolylines() async {
    polylines.clear();
    polylineCoordinates.clear();
    PolylineResult polyResult = await polylinePoints.getRouteBetweenCoordinates(
      //'AIzaSyCpc7S2R1JXMYuV6VtdX1-I9jJ4TVUiI2I',
      'AIzaSyDEiArRJg8QdgATPevCeNjwRqDl4L3-4Ak',
      PointLatLng(offerPoolStartLocation!.locationLatitude,
          offerPoolStartLocation!.locationLongitude),
      PointLatLng(offerPoolDropLocation!.locationLatitude,
          offerPoolDropLocation!.locationLongitude),
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
        polylineId: PolylineId("route"),
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

  // @override
  // void onClose() {
  //   super.onClose();
  //   // mapController.dispose();
  //   // streamSubscription.cancel();
  // }

  void logout() async {
    await _auth.signOut().then((value) => Get.offNamed(Routes.login));
  }

  permissionGetter() async {
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
  }

  void vehicleDataFetcher() async {
    var document =
        await _firestore.collection('users').doc(_auth.currentUser!.uid);
    document.get().then((document) {
      var userDocument = document.data();
      var vehicleData = List.from(userDocument!['vehicleList']);
      vehicleData.forEach((element) {
        //print(element['vehicleName']);
        selectVehicleValues.add({
          'value': element['vehicleRegNo'],
          'label': element['vehicleName'],
        });
      });
      // setting all vehicles data in model list
      vehicleData.forEach((element) {
        _vehicleModelList.add(VehicleModel(
            vehicleOwnerId: element['vehicleOwnerId'],
            vehicleName: element['vehicleName'],
            vehilceType: element['vehilceType'],
            vehicleRegNo: element['vehicleRegNo'],
            vehicleSeats: element['vehicleSeats'],
            vehicleFacilities: element['vehicleFacilities'],
            vehicleInstructions: element['vehicleInstructions']));
      });
      print(selectVehicleValues);
    }).catchError((e) {
      print('******************************* ' +
          e +
          ' *********************************');
    });
  }

  // assign vehicle data in model
  void selectedVehicleSetter(val) {
    _vehicleModelList.forEach((map) {
      if (map.vehicleRegNo == val) {
        _selectedVehicleDataModel = VehicleModel(
            vehicleOwnerId: map.vehicleOwnerId,
            vehicleName: map.vehicleName,
            vehilceType: map.vehilceType,
            vehicleRegNo: map.vehicleRegNo,
            vehicleSeats: map.vehicleSeats,
            vehicleFacilities: map.vehicleFacilities,
            vehicleInstructions: map.vehicleInstructions);
      }
    });
    print(_selectedVehicleDataModel!.vehicleName.toString());
  }

  Future<void> postNewRide() async {
    var rideCollection = FirebaseFirestore.instance.collection('ride');
    isbuttonLoading.value = true;
    // startingPoints.
    //upload cnic and img_url to user info
    rideCollection.add({
      "driverID": _auth.currentUser!.uid,
      "startAddress": offerPoolStartLocation!.completeAddress,
      "startSubLocality": offerPoolStartLocation!.subLocality,
      'startSubThoroughfare': offerPoolStartLocation!.subThoroughfare,
      "startCity": offerPoolStartLocation!.cityName,
      "startPoint": GeoPoint(offerPoolStartLocation!.locationLatitude,
          offerPoolStartLocation!.locationLongitude),
      "endAddress": offerPoolDropLocation!.completeAddress,
      "endSubLocality": offerPoolDropLocation!.subLocality,
      'endSubThoroughfare': offerPoolDropLocation!.subThoroughfare,
      "endCity": offerPoolDropLocation!.cityName,
      "endPoint": GeoPoint(offerPoolDropLocation!.locationLatitude,
          offerPoolDropLocation!.locationLongitude),
      //route data not added yet
      "route": 'will add later',
      "date": startDate!.microsecondsSinceEpoch,
      "time": {
        "hour": startTime!.hour,
        "minute": startTime!.minute,
      },
      //"gender": gender,
      "vehicle": {
        "id": _selectedVehicleDataModel!.vehicleRegNo,
        "type": _selectedVehicleDataModel!.vehilceType,
        'vehilceName': _selectedVehicleDataModel!.vehicleName,
        'vehicleFacilities': _selectedVehicleDataModel!.vehicleFacilities,
        'vehicleInstructions': _selectedVehicleDataModel!.vehicleInstructions
        //"img_url": vehicleImg,
        //"isAC": isAc,
      },
      "message": offerPoolMessageController.text,
      //"isSaved": isSavedTemplate,
      "postedAt": DateTime.now().microsecondsSinceEpoch,
      "confirmedSeats": 0,
      "totalSeats": _selectedVehicleDataModel!.vehicleSeats,
    }).then((value) {
      // print(value.id);
      rideCollection.doc(value.id).update({"id": value.id}).then((value) {
        isbuttonLoading.value = false;
        // clearing every field in offer pool form
        offerPoolStartLocationController.clear();
        offerPoolDateController.clear();
        selectVehicleController.clear();
        offerPoolDropLocationController.clear();
        offerPoolTimeController.clear();
        offerPoolMessageController.clear();

        polylines.clear();
        markers.clear();
        update();

        Get.snackbar("Ride Post Sucessfuly!",
            "People can now request to join your pool.");
      }).catchError((error) {
        print("Failed to Post Ride ID: $error");
        isbuttonLoading.value = false;
        Get.snackbar("Failed to Post Ride", "Please Try again");
      });
    }).catchError((error) {
      print("Failed to Post Ride: $error");
      isbuttonLoading.value = false;
      Get.snackbar("Failed to Post Ride", "Please Try again!");
    });
  }

  // offerPoolButtonHandler() async {
  //   var document = await _firestore.collection('rides').doc().set({
  //     'driverId': _auth.currentUser!.uid,
  //     'vehicleId': selectVehicleController.value,
  //     'startAddress': offerPoolStartLocationController.text,
  //     'startPoint': GeoPoint(offerPoolStartLocation!.locationLatitude,
  //         offerPoolStartLocation!.locationLongitude),
  //     'endAddress': offerPoolDropLocationController.text,
  //     'endPoint': GeoPoint(offerPoolDropLocation!.locationLatitude,
  //         offerPoolDropLocation!.locationLongitude),
  //     // 'startDate' : DateTime.fromMicrosecondsSinceEpoch();
  //   }, SetOptions(merge: true));
  // }

  // getLocation(BuildContext context) async {
  //   Uint8List imageData = await getMarker(context);

  // bool serviceEnabled;
  // LocationPermission permission;

  // //test if the location service is enabled
  // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  // if (!serviceEnabled) {
  //   await Geolocator.openLocationSettings();
  //   return Future.error('Location Services are Disbaled');
  // }
  // permission = await Geolocator.checkPermission();
  // if (permission == LocationPermission.denied) {
  //   permission = await Geolocator.requestPermission();
  //   if (permission == LocationPermission.denied) {
  //     return Future.error('Location permission are denied');
  //   }
  // }
  // if (permission == LocationPermission.deniedForever) {
  //   return Future.error(
  //       'Location permissions are permenently denied, we cannot request permissions.');
  // }
  //   streamSubscription =
  //       Geolocator.getPositionStream().listen((Position position) {
  //     latitude.value = position.latitude.toString();
  //     longitude.value = position.longitude.toString();
  //     getAddressFromlatLang(position);
  //     // kGoogleplace = CameraPosition(
  //     //     target: LatLng(position.latitude, position.longitude), zoom: 14);

  //     if (mapController != null) {
  //       mapController
  //           .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //               //bearing: 192.8334901395799,
  //               target: LatLng(position.latitude, position.longitude),
  //               tilt: 0,
  //               zoom: 15.00)));
  //     }
  //     updateMarkerAndCircle(position, imageData);
  //     update();
  //   });
  // }

  // Future<void> getAddressFromlatLang(Position position) async {
  //   List<Placemark> placemark =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //   Placemark place = placemark[0];
  //   address.value = '${place.subLocality}, ${place.locality}, ${place.country}';
  //   //startSearchFieldController.text = address.value;
  //   isLocationLocation.value = false;
  // }

  // void updateMarkerAndCircle(Position newLocalData, Uint8List imageData) {
  //   LatLng latLng = LatLng(newLocalData.latitude, newLocalData.longitude);
  //   marker = Marker(
  //       markerId: MarkerId("home"),
  //       position: latLng,
  //       // rotation: newLocalData.heading,
  //       draggable: true,
  //       zIndex: 2,
  //       flat: true,
  //       anchor: Offset(0.5, 0.9),
  //       icon: BitmapDescriptor.fromBytes(imageData));
  //   // marker = Marker(
  //   //   markerId: const MarkerId("You are here"),
  //   //   position: latLng,
  //   //   rotation: newLocalData.heading as double,
  //   //   draggable: false,
  //   //   zIndex: 2,
  //   //   flat: true,
  //   //   anchor: const Offset(0.5, 0.5),
  //   // );
  //   // circle = Circle(
  //   //     circleId: const CircleId("Your Current Location"),
  //   //     radius: newLocalData.accuracy as double,
  //   //     zIndex: 1,
  //   //     strokeColor: Colors.blue,
  //   //     center: latLng,
  //   //     fillColor: Colors.blue.withAlpha(70));
  //   update();
  // }
}
