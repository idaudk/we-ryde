library faq_screen;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/animations/animations.dart';


part '../components/banner.dart';
part '../components/appbar.dart';
part '../components/faq.dart';








class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 10.0.w,),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: Colors.white),
                        //width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
                        child: ListView(
                          children:[
                            ExpansionItems(),
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
