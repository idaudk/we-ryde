library pin_map_view;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
part '../components/search_listview.dart';

class PinMapScreen extends GetView<PinMapController> {
  PinMapScreen({Key? key}) : super(key: key);
  final PinMapController _pinMapController = Get.put(PinMapController());

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
            const _AppBar(),
            SizedBox(
              height: 20.h,
            ),
            const _SearchBar(),
            Expanded(
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  GetBuilder<PinMapController>(
                    //init: PinMapController(),
                    builder: (_) {
                      return Container(
                        height: 640.h,
                        child: GoogleMap(
                          compassEnabled: true,
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          zoomControlsEnabled: false,
                          cameraTargetBounds: CameraTargetBounds.unbounded,
                          // padding: EdgeInsets.symmetric(
                          //     horizontal: 18.w, vertical: 160.h),
                          initialCameraPosition: CameraPosition(
                              target: _pinMapController.locationLatLng,
                              zoom: 14.5),
                          onMapCreated: (controller) {
                            controller.setMapStyle(Utils.mapStyles);
                            _pinMapController.mapController = controller;
                          },
                          onCameraMove: (CameraPosition cameraPostiona) {
                            _pinMapController.pinMoving.value = true;
                            _pinMapController.cameraPosition = cameraPostiona;
                            //_pinMapController.searchTextField.text = '';
                          },
                          onCameraIdle: () {
                            controller.loadAddress();
                          },
                        ),
                      );
                    },
                  ),
                  // Positioned(
                  //   top: 20.h,
                  //   child:
                  // ),
                  Center(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Image.asset(
                      'assets/images/raster/origin_pin.png',
                      height: 40,
                      width: 40,
                    ),
                  )),
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
