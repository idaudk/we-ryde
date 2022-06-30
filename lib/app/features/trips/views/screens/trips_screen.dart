library trips_screen;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tab_container/tab_container.dart';
import 'package:weryde/app/config/themes/app_basic_theme.dart';
import 'package:weryde/app/features/trips/controllers/trips_controller.dart';
import '../../../../utils/animations/animations.dart';
import '../../../../utils/models/request_ride_model.dart';
import '../../../../utils/models/ride_model.dart';
import '../../../../utils/models/user_model.dart';

part '../components/appbar.dart';
part '../components/offered_pool.dart';
part '../components/requested_pool.dart';
part '../components/offered_pool_details.dart';
part '../components/accept_button.dart';
//part '../components/ride_item.dart';

class TripsScreen extends StatelessWidget {
  TripsScreen({Key? key}) : super(key: key);
  final TripsController _tripsController = Get.put(TripsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
          color: Color(0xffebf2f8),
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
                    //color: const Color(0xff0ec874),
                    decoration: const BoxDecoration(
                        color: Color(0xffebf2f8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11),
                        )),
                    //height: 250.h,
                    child: TabContainer(
                      radius: 11,
                      tabCurve: Curves.easeIn,
                      transitionBuilder: (child, animation) {
                        animation = CurvedAnimation(
                            curve: Curves.easeIn, parent: animation);
                        return SlideTransition(
                          position: Tween(
                            begin: const Offset(0.2, 0.0),
                            end: const Offset(0.0, 0.0),
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },

                      //color: Color(0xffebf2f8),
                      color: Colors.white,
                      children: [
                        _OfferedPool(),
                        _RequestedPool(),
                      ],
                      tabs: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Iconsax.car),
                            label: const Text(
                              "Offered Pools",
                              style: TextStyle(),
                            )),
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.outbond_outlined,
                            ),
                            label: const Text(
                              "Requested Pools",
                              style: TextStyle(),
                            )),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
