import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_button/group_button.dart';
import 'package:weryde/app/config/themes/app_basic_theme.dart';
import 'package:weryde/app/features/search_pool/controllers/search_pool_controller.dart';
import 'package:weryde/app/utils/animations/animations.dart';

class JoinPoolConfirmScreen extends StatelessWidget {
  SearchPoolController _searchPoolController = Get.put(SearchPoolController());

  String rideID;
  String driverID;
  String passangerID;
  List numberOfSeatsAvailable;
  String? userMsg;
  final LatLng selectedUserStartPoint;
  final LatLng selectedUserEndPoint;

  final String selectedStartAddress;
  final String selectedEndAddress;

  JoinPoolConfirmScreen(
      {Key? key,
      required this.rideID,
      required this.driverID,
      required this.passangerID,
      required this.numberOfSeatsAvailable,
      required this.selectedUserEndPoint,
      required this.selectedUserStartPoint,
      required this.selectedStartAddress,
      required this.selectedEndAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: AppBasicTheme().secondaryColor,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideAnimation(
                begin: Offset(-200, 0),
                child: ScaleAnimation(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back)),
                        SizedBox(width: 16.h),
                        Text(
                          'Confirm Ride',
                          style: TextStyle(
                              fontSize: 16.r, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ScaleAnimation(
                      child: Text(
                        "Seats",
                        style: TextStyle(
                            fontSize: 24.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ScaleAnimation(
                      child: Text(
                        "Select number seats you want.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.r, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ScaleAnimation(
                      child: SlideAnimation(
                        begin: Offset(-300, 0),
                        child: GroupButton(
                          controller: _searchPoolController.seatsController,
                          isRadio: true,
                          options: GroupButtonOptions(
                            mainGroupAlignment: MainGroupAlignment.start,
                            crossGroupAlignment: CrossGroupAlignment.start,
                            groupRunAlignment: GroupRunAlignment.start,
                            borderRadius: BorderRadius.circular(20),
                            groupingType: GroupingType.wrap,
                            direction: Axis.horizontal,
                            unselectedColor: AppBasicTheme().secondaryColor,
                            spacing: 10,
                            runSpacing: 10,
                            buttonHeight: 50,
                            buttonWidth: 50,
                          ),
                          onSelected: (index, selectedIndex, x) =>
                              print('$index button is selected'),
                          buttons: numberOfSeatsAvailable,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    ScaleAnimation(
                      child: Text(
                        "Message",
                        style: TextStyle(
                            fontSize: 24.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ScaleAnimation(
                      child: Text(
                        "Enter message for driver",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.r, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    ScaleAnimation(
                      child: TextField(
                        controller: _searchPoolController.userMessageController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        minLines: 5,
                        decoration: const InputDecoration(
                          fillColor: Colors.white,

                          // enabledBorder: OutlineInputBorder(
                          //   borderSide:
                          //       BorderSide(color: Colors.greenAccent, width: 1.0),
                          // ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Obx(() => ScaleAnimation(
                            child: ElevatedButton(
                          onPressed: () {
                            if (_searchPoolController
                                    .seatsController.selectedIndex ==
                                null) {
                              Get.snackbar('Select number of seats.', '');
                            } else
                              _searchPoolController.sendRequestToJoin(
                                rideID: rideID,
                                driverID: driverID,
                                passangerID: passangerID,
                                startAddress: selectedStartAddress,
                                startPoint: selectedUserStartPoint,
                                endAddress: selectedEndAddress,
                                endPoint: selectedUserEndPoint,
                                message: _searchPoolController
                                    .userMessageController.text,
                                seats: _searchPoolController
                                        .seatsController.selectedIndex!
                                        .toInt() +
                                    1,
                              );
                          },
                          child:
                              _searchPoolController.isConfirmButtonLoading.value
                                  ? const SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(
                                      "Join Ride",
                                      style: TextStyle(color: Colors.white),
                                    ),
                        ))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
