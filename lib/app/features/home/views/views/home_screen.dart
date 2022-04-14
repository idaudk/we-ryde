library home_view;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tab_container/tab_container.dart';
import 'package:weryde/app/features/home/controllers/home_controller.dart';

import '../../controllers/home_controller.dart';

part '../components/profile.dart';
part '../components/drawer.dart';
part '../components/appbar.dart';
part '../components/container_nav.dart';
part '../components/find_pool.dart';
part '../components/offer_pool.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  HomeController homeController = Get.put(HomeController());
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGoogleplace =
      CameraPosition(target: LatLng(27.2046, 77.4977), zoom: 14);
  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        infoWindow: InfoWindow(title: "My Location"),
        markerId: MarkerId("1"),
        position: LatLng(27.2046, 77.4977))
  ];
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
    // String apikey='AIzaSyD9YM0CFsOLiX4JIQ8AHv6yioAyoPMTOQw';
    // googlePlace =GooglePlace(apikey);
  }

  @override
  Widget build(BuildContext context) {
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
                        margin: const EdgeInsets.only(bottom: 205),
                        child: GoogleMap(
                          myLocationButtonEnabled: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24.h),
                          markers: Set<Marker>.of(_marker),
                          initialCameraPosition: _kGoogleplace,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          compassEnabled: true,
                        ),
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
