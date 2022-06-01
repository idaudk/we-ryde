library trips_screen;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weryde/app/features/trips/controllers/trips_controller.dart';
import '../../../../utils/animations/animations.dart';
import '../../../../utils/models/ride_model.dart';

part '../components/appbar.dart';
//part '../components/ride_item.dart';

class TripsScreen extends StatelessWidget {
  TripsScreen({Key? key}) : super(key: key);
  final TripsController _tripsController = Get.put(TripsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                _AppBar(),
                SizedBox(
                  height: 50.h,
                ),
                Expanded(
                  child: SlideAnimation(
                    begin: const Offset(0, 400),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      //sconstraints: BoxConstraints.expand(),
                      height: MediaQuery.of(context).size.height - 230.h,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0.w, vertical: 10.h),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Color(0xffebf2f8),
                      ),
                      //width: MediaQuery.of(context).size.width,
                      //height: MediaQuery.of(context).size.height,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("ride")
                              .where('driverID',
                                  isEqualTo:
                                      _tripsController.auth.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.docs.length == 0) {
                                return Text("No ride found");
                              }
                              return Flex(
                                direction: Axis.vertical,
                                children: snapshot.data!.docs.map((e) {
                                  return _RideItem(
                                      ride: RideModel.fromDocumentSnapshot(
                                          snapshot: e),
                                      context: context);
                                }).toList(),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          }),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

Widget _RideItem({required RideModel ride, required BuildContext context}) {
  return Container(
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      // border: Border.all(width: 0.5),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0),
          spreadRadius: 2,
          blurRadius: 3,
          // offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${ride.time.format(context)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.r),
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Icon(
                      Iconsax.calendar,
                      size: 14.r,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      "${Jiffy(ride.startDate).MMMd}",
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            CircleAvatar()
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              size: 10.r,
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: Get.width / 1.45,
              child: Text(
                "${ride.startAddress}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: Get.width / 98),
              alignment: Alignment.center,
              height: 20,
              child: const DottedLine(
                dashGapRadius: 5,
                direction: Axis.vertical,
                dashLength: 1.0,
                dashColor: Colors.green,
                lineThickness: 3.0,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.circle,
              size: 10.r,
            ),
            SizedBox(
              width: 5.w,
            ),
            Container(
              alignment: Alignment.topLeft,
              width: Get.width / 1.45,
              child: Text(
                "${ride.endAddress}",
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                maxLines: 1,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Posted: ${Jiffy(ride.postedAt).fromNow()}",
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10.r),
            ),
          ],
        )
      ],
    ),
  );
}
