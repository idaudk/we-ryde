library pin_map_view;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/config/themes/app_basic_theme.dart';
import 'package:weryde/app/constants/map_constant.dart';

import '../../../../utils/animations/animations.dart';
import '../../controllers/pin_map_controller.dart';

part '../components/appbar.dart';
part '../components/display_pin_address.dart';
part '../components/search_bar.dart';

class PinMapScreen extends GetView<PinMapController> {
  PinMapScreen({Key? key}) : super(key: key);
  PinMapController _startLocationController = Get.put(PinMapController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 20.h,
            ),
            _AppBar(),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  GoogleMap(
                    compassEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    cameraTargetBounds: CameraTargetBounds.unbounded,
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 160.h),
                    initialCameraPosition: CameraPosition(
                        target: _startLocationController.startLocation,
                        zoom: 14.5),
                    onMapCreated: (controller) {
                      controller.setMapStyle(Utils.mapStyles);
                      _startLocationController.mapController = controller;
                    },
                    onCameraMove: (CameraPosition cameraPostiona) {
                      _startLocationController.pinMoving.value = true;
                      _startLocationController.cameraPosition = cameraPostiona;
                    },
                    onCameraIdle: () async {
                      List<Placemark> placemarks =
                          await placemarkFromCoordinates(
                              _startLocationController
                                  .cameraPosition!.target.latitude,
                              _startLocationController
                                  .cameraPosition!.target.longitude);
                      _startLocationController.address = placemarks;
                      //get place name from lat and lang
                      _startLocationController.location =
                          // placemarks.first.name.toString() +
                          //     ", " +
                          placemarks.first.subLocality.toString() +
                              ", " +
                              placemarks.first.locality.toString() +
                              " ," +
                              placemarks.first.administrativeArea.toString() +
                              " ," +
                              placemarks.first.isoCountryCode.toString();
                      print("***********************" +
                          _startLocationController.location.toString() +
                          "****************************");
                      _startLocationController.pinMoving.value = false;
                    },
                  ),
                  Positioned(
                    top: 20.h,
                    child: _SearchBar(),
                  ),
                  Center(
                    child: Image.network(
                      "https://www.outsystems.com/Forge_BL/rest/ComponentThumbnail/GetURL_ComponentThumbnail?ProjectImageId=33187",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  _DisplayPinAddress(),
                ],
              ),
            )
            //mainAxisAlignment: MainAxisAlignment.start,
          ]),
        ),
      ),
    );
  }
}
