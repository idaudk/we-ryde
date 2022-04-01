library about_us_screen;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/animations/animations.dart';


part '../components/appbar.dart';
part '../components/banner.dart';




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
                SizedBox(
                  height: 25.h,
                ),
                Expanded(
                  child: SlideAnimation(
                    begin: const Offset(0, 300),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        //sconstraints: BoxConstraints.expand(),
                        height: MediaQuery.of(context).size.height - 230.h,
                        padding:
                        EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 30.h),
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
                            Text("Write Us",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.sp),),
                            Text("Let us know your query",style: TextStyle(fontWeight: FontWeight.w300,),),
                            SizedBox(height: 40.h,),
                            Text("Email Address",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),

                            SizedBox(height: 15.h,),
                            Text("Add your issue/feedback",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),




                          ],
                        )
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
