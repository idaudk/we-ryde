import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:weryde/app/config/themes/app_basic_theme.dart';
import 'package:weryde/app/features/search_pool/controllers/search_pool_controller.dart';
import 'package:weryde/app/utils/models/ride_model.dart';
import 'package:weryde/app/utils/models/user_model.dart';

import '../../../../constants/map_constant.dart';
import 'join_pool_confirm.dart';

class SearchPoolDetailsScreen extends StatefulWidget {
  final RideModel rideData;
  final UserModel driverData;

  final LatLng selectedUserStartPoint;
  final LatLng selectedUserEndPoint;

  final String selectedStartAddress;
  final String selectedEndAddress;

  SearchPoolDetailsScreen(
      {Key? key,
      required this.rideData,
      required this.driverData,
      required this.selectedUserEndPoint,
      required this.selectedUserStartPoint,
      required this.selectedStartAddress,
      required this.selectedEndAddress})
      : super(key: key);

  @override
  State<SearchPoolDetailsScreen> createState() =>
      _SearchPoolDetailsScreenState();
}

class _SearchPoolDetailsScreenState extends State<SearchPoolDetailsScreen> {
  SearchPoolController searchPoolController = Get.put(SearchPoolController());

  @override
  void initState() {
    searchPoolController.valueSetter(
        passedDriverData: widget.driverData, passedRideData: widget.rideData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _panelMinSize = 160.h;
    final double _panelMaxSize = MediaQuery.of(context).size.height - 100.h;
    return Scaffold(
      body: SlidingUpPanel(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        minHeight: _panelMinSize,
        parallaxEnabled: true,
        parallaxOffset: .3,
        maxHeight: _panelMaxSize,
        footer: footer(),
        panel: slidingPanel(_panelMinSize),
        header: sliderHeader(_panelMinSize),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 305.h),
                        child: GetBuilder(
                          init: SearchPoolController(),
                          builder: (value) => GoogleMap(
                            myLocationButtonEnabled: true,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 40),
                            onMapCreated:
                                (GoogleMapController functioncontroller) {
                              searchPoolController.mapController =
                                  functioncontroller;
                              functioncontroller.setMapStyle(Utils.mapStyles);
                            },
                            markers: searchPoolController.markers,
                            polylines: searchPoolController.polylines,
                            initialCameraPosition:
                                searchPoolController.initialLocation,
                            myLocationEnabled: true,
                            mapType: MapType.normal,
                            compassEnabled: true,
                          ),
                        )),
                    Expanded(
                        child: Container(
                            width: Get.width,
                            height: 320.h,
                            decoration: BoxDecoration(
                                color: AppBasicTheme().secondaryColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 24, right: 24, top: 15.h),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Ride starts on ' +
                                            Jiffy(widget.rideData.startDate)
                                                .MMMd +
                                            ', ' +
                                            widget.rideData.time
                                                .format(context),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.r),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 24,
                                      right: 24,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              size: 12.r,
                                              color:
                                                  AppBasicTheme().primaryColor,
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 5.h,
                                                  top: 2.h,
                                                  bottom: 2.h),
                                              height: 46.h,
                                              child: DottedLine(
                                                dashGapLength: 2.0,
                                                dashColor: Colors.black
                                                    .withOpacity(0.5),
                                                direction: Axis.vertical,
                                              ),
                                            ),
                                            Icon(
                                              Icons.circle,
                                              size: 12.r,
                                              color: Colors.red,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 20.h,
                                        ),
                                        Flexible(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.rideData
                                                        .startSubLocality,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.r),
                                                  ),
                                                  Text(
                                                    widget
                                                        .rideData.startAddress,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10.r),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 28.h,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.rideData
                                                        .endSubLocality,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16.r),
                                                  ),
                                                  Text(
                                                    widget.rideData.endAddress,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 10.r),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container slidingPanel(double panelMinSize) {
    return Container(
        padding: const EdgeInsets.only(left: 24, right: 24),
        margin: EdgeInsets.only(top: panelMinSize - 60.h),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Co-Passengers',
              style: TextStyle(
                  fontSize: 18.r,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.4)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              width: double.infinity,
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.rideData.totalSeats,
                  itemBuilder: (_, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: AppBasicTheme().primaryColor),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 12.r,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'User Name',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                        )
                      ],
                    );
                  }),
            ),
          ],
        )
        );
  }

  Container footer() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 24, right: 24, top: 5.h, bottom: 15.h),
      width: Get.width,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: AppBasicTheme().primaryColor),
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(45)),
            height: 45.h,
            width: 45.w,
            padding: EdgeInsets.all(10),
            child: Center(
              child: Icon(
                Iconsax.messages_3,
                size: 20.r,
                color: AppBasicTheme().primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 20.h,
          ),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                List<String> ListofSeats = [];
                for (var i = 1;
                    i <=
                        widget.rideData.totalSeats -
                            widget.rideData.confirmedSeats;
                    i++) {
                  ListofSeats.add(i.toString());
                  print(i.toString());
                }
                Get.to(
                  () => JoinPoolConfirmScreen(
                    driverID: widget.driverData.userId,
                    rideID: widget.rideData.id,
                    passangerID: searchPoolController.auth.currentUser!.uid,
                    selectedStartAddress: widget.selectedStartAddress,
                    selectedEndAddress: widget.selectedEndAddress,
                    selectedUserStartPoint: widget.selectedUserStartPoint,
                    selectedUserEndPoint: widget.selectedUserEndPoint,
                    numberOfSeatsAvailable: ListofSeats,
                  ),
                );
              },
              child: searchPoolController.isLoading.value
                  ? SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    )
                  : Text(
                      "Join Ride",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Container sliderHeader(double _panelMinSize) {
    return Container(
        height: _panelMinSize,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        child: Container(
          //color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 5,
                  width: 50.h,
                  child: Container(
                    color: const Color.fromARGB(96, 158, 158, 158),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60.h,
                    width: 60.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.driverData.profile_image == "-"
                            ? "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19637.jpg?t=st=1648123180~exp=1648123780~hmac=39b64ea5a82853c6c17321282f5712adf297e8e24a418df12a77661f503584d2&w=996"
                            : widget.driverData.profile_image.toString(),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.driverData.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.r),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        widget.rideData.vehicleType,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 12.r),
                      )
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "\$3.50",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20.r),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 18,
                          child: ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: widget.rideData.totalSeats,
                              itemBuilder: (_, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18),
                                      color: AppBasicTheme().primaryColor),
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 18,
                                  height: 18,
                                  child: Center(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 12.r,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
