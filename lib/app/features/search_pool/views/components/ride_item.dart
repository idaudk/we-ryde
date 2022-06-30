import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:place_picker/place_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weryde/app/features/search_pool/views/screens/search_pool_details.dart';

import '../../../../config/themes/app_basic_theme.dart';
import '../../../../utils/animations/animations.dart';
import '../../../../utils/models/ride_model.dart';
import '../../../../utils/models/user_model.dart';

class RideItem extends StatefulWidget {
  final RideModel ride;

  final LatLng selectedUserStartPoint;
  final LatLng selectedUserEndPoint;

  final String selectedStartAddress;
  final String selectedEndAddress;

  const RideItem(
      {Key? key,
      required this.ride,
      required this.selectedUserEndPoint,
      required this.selectedUserStartPoint,
      required this.selectedStartAddress,
      required this.selectedEndAddress})
      : super(key: key);

  @override
  State<RideItem> createState() => _RideItemState();
}

class _RideItemState extends State<RideItem> {
  UserModel? driver;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.ride.driverID)
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            driver = UserModel.fromDocumentSnapshot(snapshot: documentSnapshot);
          });
        } else {
          print("User document not found");
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return driver == null
        ? SlideAnimation(
            begin: const Offset(50, 500),
            child: Shimmer.fromColors(
                baseColor: AppBasicTheme().secondaryColor,
                highlightColor: Colors.white60,
                child: Container(
                    height: 120.h,
                    width: Get.width,
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: BoxDecoration(
                        color: AppBasicTheme().secondaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: null //Text(driver!.name),
                    )),
          )
        : FadeAnimation(
            duration: const Duration(milliseconds: 850),
            child: InkWell(
              onTap: () {
                Get.to(() => SearchPoolDetailsScreen(
                      rideData: widget.ride,
                      driverData: driver!,
                      selectedStartAddress: widget.selectedStartAddress,
                      selectedEndAddress: widget.selectedEndAddress,
                      selectedUserEndPoint: widget.selectedUserEndPoint,
                      selectedUserStartPoint: widget.selectedUserStartPoint,
                    ));
              },
              child: Container(
                height: 120.h,
                width: Get.width,
                margin: const EdgeInsets.only(bottom: 15),
                padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 13.h),
                decoration: BoxDecoration(
                    color: AppBasicTheme().secondaryColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Expanded(
                      flex: 20,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60.h,
                            width: 60.w,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                driver!.profile_image == "-"
                                    ? "https://img.freepik.com/free-photo/handsome-young-man-with-new-stylish-haircut_176420-19637.jpg?t=st=1648123180~exp=1648123780~hmac=39b64ea5a82853c6c17321282f5712adf297e8e24a418df12a77661f503584d2&w=996"
                                    : driver!.profile_image.toString(),
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Row(
                            children: [
                              Container(
                                  height: 25.h,
                                  width: 60.w,
                                  padding: const EdgeInsets.only(),
                                  decoration: BoxDecoration(
                                      color: AppBasicTheme().primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.star,
                                        size: 11.r,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                            fontSize: 11.r,
                                            color: Colors.white),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 60,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        driver!.name,
                                        style: TextStyle(
                                            fontSize: 19.r,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        widget.ride.vehicleType,
                                        style: TextStyle(
                                            fontSize: 9.r,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '💲3.50',
                                        style: TextStyle(
                                            fontSize: 18.r,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 18,
                                        child: ListView.builder(
                                            reverse: true,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemCount: widget.ride.totalSeats,
                                            itemBuilder: (_, index) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    color: AppBasicTheme()
                                                        .primaryColor),
                                                margin: const EdgeInsets.only(
                                                    left: 5),
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
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person_pin_circle_outlined,
                                  size: 11.r,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.ride.startSubLocality +
                                        ", " +
                                        widget.ride.startCity,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.r,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.person_pin_circle_outlined,
                                  size: 11.r,
                                ),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.ride.endSubLocality +
                                        ", " +
                                        widget.ride.endCity,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.r,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
          );
  }
}
