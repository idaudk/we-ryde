library about_us_screen;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../utils/animations/animations.dart';
import 'package:url_launcher/url_launcher.dart';

part '../components/appbar.dart';
part '../components/banner.dart';
part '../components/daud.dart';
part '../components/saeed.dart';
part '../components/about_style.dart';








class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
            color: Color(0xffebf2f8),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                _AppBar(),
                SizedBox(
                  height: 50.h,
                ),
                const _Banner(),
                CallToAction(),
                Expanded(

                  child: SlideAnimation(
                    begin: const Offset(0, 300),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        //sconstraints: BoxConstraints.expand(),
                        height: MediaQuery.of(context).size.height - 230.h,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0.w, vertical: 30.h),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        //width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Our Story",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),),
                                  SizedBox(height: 10.h),
                                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation "),
                                ],
                              ),
                            ),
                            Text("Team",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),),
                            SizedBox(height: 10.h),

                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Row(

                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children:  [
                                        SlideAnimation(
                                          begin: Offset(0, 300),
                                          child: Daud(),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Saeed(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
