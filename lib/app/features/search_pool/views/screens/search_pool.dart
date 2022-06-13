library search_pool;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weryde/app/config/themes/app_basic_theme.dart';
import 'package:weryde/app/utils/models/ride_model.dart';
import '../../../../utils/animations/animations.dart';
import '../../controllers/search_pool_controller.dart';
import '../components/ride_item.dart';

part '../components/appbar.dart';
//part '../components/ride_item.dart';

class SearchPool extends StatelessWidget {
  final LatLng? startPoint;
  final LatLng? endPoint;
  final String? startAddress;
  final String? endAddress;
  final String? startCity;
  final String? endCity;
  final String? startSubLocality;
  final String? endSubLocality;
  final String? startPostalCode;
  final String? endPostalCode;
  SearchPool(
      {Key? key,
      this.startPoint,
      this.endPoint,
      this.startAddress,
      this.endAddress,
      this.startCity,
      this.endCity,
      this.startSubLocality,
      this.endSubLocality,
      this.startPostalCode,
      this.endPostalCode})
      : super(key: key);

  SearchPoolController _searchPoolController = Get.put(SearchPoolController());

  Query<Map<String, dynamic>> getQuery({required int queryType}) {
    if (queryType == 1) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startPostalCode', isEqualTo: startPostalCode)
          .where('endPostalCode', isEqualTo: endPostalCode);
    } else if (queryType == 2) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startCity', isEqualTo: startCity)
          .where('endCity', isEqualTo: endCity);
    } else if (queryType == 3) {
      return FirebaseFirestore.instance
          .collection("ride")
          .where('startSubLocality', isEqualTo: startSubLocality)
          .where('endSubLocality', isEqualTo: endSubLocality);
    } else {
      return FirebaseFirestore.instance.collection("ride");
    }
    // return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
          color: AppBasicTheme().secondaryColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              _AppBar(endSubLocality: endSubLocality),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                  child: SlideAnimation(
                begin: const Offset(0, 400),
                child: Container(
                    width: Get.width,
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    //color: const Color(0xff0ec874),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11),
                        )),
                    //height: 250.h,
                    child: ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                            stream: getQuery(queryType: 2).snapshots(),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.length == 0) {
                                  return const Center(
                                      child: Text('No pool found'));
                                }
                                return Flex(
                                    direction: Axis.vertical,
                                    children: snapshot.data!.docs.map((e) {
                                      return RideItem(
                                        selectedStartAddress: startAddress!,
                                        selectedEndAddress: endAddress!,
                                        selectedUserStartPoint: startPoint!,
                                        selectedUserEndPoint: endPoint!,
                                        ride: RideModel.fromDocumentSnapshot(
                                              snapshot: e));
                                    }).toList());
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                            },
                          ),
                        ])),
              ))
            ],
          )),
    );
  }
}
