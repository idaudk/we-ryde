library home_view;

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:tab_container/tab_container.dart';
import 'package:weryde/app/constants/map_constant.dart';
import 'package:weryde/app/features/home/controllers/home_controller.dart';

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
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
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
    //homeController.getLocation(context);
    //homeController.mapController.setMapStyle(Utils.mapStyles);
    print("Home screen init called");
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
                          //padding: EdgeInsets.only(top: 10.h),
                          child: GetBuilder(
                            init: HomeController(),
                            builder: (value) => GoogleMap(
                              myLocationButtonEnabled: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 30.h),
                              markers: Set.of((homeController.marker != null)
                                  ? [homeController.marker]
                                  : []),
                              circles: Set.of((homeController.circle != null)
                                  ? [homeController.circle]
                                  : []),
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
                          )

                          // Obx(
                          //   () => homeController.isLoading.value
                          //       ? const Align(
                          //           alignment: Alignment.center,
                          //           child: CircularProgressIndicator())
                          //       : GoogleMap(
                          //           myLocationButtonEnabled: true,
                          //           padding: EdgeInsets.symmetric(
                          //               horizontal: 24, vertical: 24.h),
                          //           markers:
                          //               Set.of((homeController.marker != null)? [homeController.marker]: []),
                          //           circles:
                          //               Set.of((homeController.marker != null)? [homeController.circle]: []),
                          //           initialCameraPosition:
                          //               homeController.kGoogleplace,
                          //           onMapCreated:
                          //               (GoogleMapController controller) {
                          //             homeController.controller
                          //                 .complete(controller);
                          //           },
                          //           myLocationEnabled: true,
                          //           mapType: MapType.normal,
                          //           compassEnabled: true,
                          //         ),
                          // ),
                          ),

                      ContainerNav()
                      // Container(
                      //   height: 100.h,
                      //   width: MediaQuery.of(context).size.width,
                      //   child: SingleChildScrollView(
                      //     child: Column(children: [
                      //       TabBar(
                      //         tabs: [
                      //           Tab(icon: Icon(Icons.flight)),
                      //           Tab(icon: Icon(Icons.directions_transit)),
                      //         ],
                      //       ),
                      //       TabBarView(
                      //         children: [
                      //           Icon(Icons.flight, size: 350),
                      //           Icon(Icons.directions_transit, size: 350),
                      //         ],
                      //       ),
                      //     ]),
                      //   ),
                      // ),

                      //box2(),
                      //Location(),
                    ],
                  ),
                ),
              ],
            )));
  }
}
