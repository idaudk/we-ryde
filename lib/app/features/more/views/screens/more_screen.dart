library more_view;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/features/more/controllers/more_controller.dart';
import 'package:weryde/app/utils/animations/animations.dart';

part '../components/appbar.dart';
part '../components/userinfo.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);
  MoreController moreController = Get.put(MoreController());
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: Column(
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
            const _Userinfo(),
            SizedBox(
              height: 25.h,
            ),
            SlideAnimation(
              begin: const Offset(0, 300),
              child: Container(
                //constraints: BoxConstraints.expand(),

                height: double.maxFinite,
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white),
                //width: MediaQuery.of(context).size.width,
                //height: MediaQuery.of(context).size.height,
                child: ListView(children: [
                  ListTile(
                    leading: Icon(
                      Iconsax.car,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "My Vehicle",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Add vehicle Information"),
                    onTap: () => Get.toNamed(Routes.myvehicles),
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.location,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "Manage Address",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Pre Saved Addresses"),
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.message,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "Support",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Connect us for issues & queries"),
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.clipboard,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "Privacy Policy",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Know our privacy policies"),
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.language_circle,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "Change Language",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Set your prefered language"),
                  ),
                  ListTile(
                    leading: Icon(
                      Iconsax.message_question,
                      color: Colors.blueAccent,
                    ),
                    title: Text(
                      "FAQs",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("get your Question's answered"),
                  ),
                ]),
              ),
            )
          ],
        ));
  }
}
