library home_view;


import 'dart:math' as math;
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:tab_container/tab_container.dart';
import 'package:weryde/app/constants/map_constant.dart';
import 'package:weryde/app/features/home/controllers/home_controller.dart';

import '../../../pin_map/views/screens/pin_map_screen.dart';
import '../../controllers/home_controller.dart';

part '../components/profile.dart';
part '../components/drawer.dart';
part '../components/appbar.dart';
part '../components/container_nav.dart';
part '../components/find_pool.dart';
part '../components/offer_pool.dart';
part '../components/offer_pool_button.dart';
part '../components/find_pool_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  //final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  HomeController homeController = Get.put(HomeController());

  // void initState() {
  //
  //   super.initState();
  //   marker.addAll(list);
  //   // String apikey='AIzaSyD9YM0CFsOLiX4JIQ8AHv6yioAyoPMTOQw';
  //   // googlePlace =GooglePlace(apikey);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  // @override
  // void dispose() {
  //   super.dispose();
  //   //homeController.mapController.dispose();
  //   //homeController.streamSubscription.cancel();
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Container(
                            margin: EdgeInsets.only(bottom: 230.h),
                            
                            child: GetBuilder(
                              init: HomeController(),
                              builder: (value) => GoogleMap(
                                myLocationButtonEnabled: true,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 30.h),
                                markers: homeController.markers,
                                polylines: homeController.polylines,
                                //polygons: homeController.polygon,

                                initialCameraPosition:
                                    homeController.initialLocation,

                                //onMapCreated: homeController.onMapCreated(homeController.mapController),
                                onMapCreated: (GoogleMapController controller) {
                                  //homeController.mapCompleter.complete() = controller;
                                  homeController.mapController = controller;
                                  controller.setMapStyle(Utils.mapStyles);
                                },
                                // onMapCreated: (GoogleMapController controller) {
                                //   if (!homeController.mapCompleter.isCompleted) {
                                //     homeController.mapCompleter
                                //         .complete(controller);
                                //     homeController.mapController = controller;
                                //   }
                                // },
                                myLocationEnabled: true,
                                mapType: MapType.normal,
                                compassEnabled: true,
                              ),
                            )),

                        ContainerNav()
                       
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
