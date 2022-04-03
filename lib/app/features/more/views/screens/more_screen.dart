library more_view;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/features/more/controllers/more_controller.dart';
import 'package:weryde/app/utils/animations/animations.dart';

part '../components/appbar.dart';
part '../components/userinfo.dart';
part '../components/testing_comp.dart';
part '../components/user_stream.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);
  MoreController moreController = Get.put(MoreController());
  // final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xffebf2f8),
        height: MediaQuery.of(context).size.height,
        //key: _key,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.stretch,
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
            _TestingComp(),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: SlideAnimation(
                begin: const Offset(0, 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          leading: const Icon(
                            Iconsax.car,
                            color: Color(0xff0ec874),
                          ),
                          title: const Text(
                            "My Vehicle",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("Add vehicle Information"),
                          onTap: () => Get.toNamed(Routes.myvehicles),
                        ),
                        ListTile(
                          leading: const Icon(
                            Iconsax.location,
                            color: Color(0xff0ec874),
                          ),
                          title: const Text(
                            "Manage Address",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("Pre Saved Addresses"),
                          onTap: () => Get.toNamed(Routes.manageaddress),
                        ),
                        ListTile(
                          leading: const Icon(
                            Iconsax.message,
                            color: Color(0xff0ec874),
                          ),
                          title: const Text(
                            "Support",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              const Text("Connect us for issues & queries"),
                          onTap: () => Get.toNamed(Routes.support),
                        ),
                        const ListTile(
                          leading: Icon(
                            Iconsax.language_circle,
                            color: Color(0xff0ec874),
                          ),
                          title: Text(
                            "Change Language",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Set your prefered language"),
                        ),
                        ListTile(
                          leading: const Icon(
                            Iconsax.message_question,
                            color: Color(0xff0ec874),
                          ),
                          title: const Text(
                            "FAQs",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("get your Question's answered"),
                          onTap: () => Get.toNamed(Routes.faq),
                        ),
                        const ListTile(
                          leading: Icon(
                            Iconsax.color_swatch,
                            color: Color(0xff0ec874),
                          ),
                          title: Text(
                            "Themes",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Change the Color theme of App"),
                        ),
                        ListTile(
                          leading: const Icon(
                            Iconsax.information,
                            color: Color(0xff0ec874),
                          ),
                          title: const Text(
                            "About Us",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("Know our privacy policies"),
                          onTap: () => Get.toNamed(Routes.about_us),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ));
  }
}
