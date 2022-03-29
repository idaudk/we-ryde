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
    return Container(
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
            Expanded(
              child: SlideAnimation(
                begin: const Offset(0, 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
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
                            color: Colors.blueAccent,
                          ),
                          title: const Text(
                            "My Vehicle",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("Add vehicle Information"),
                          onTap: () => Get.toNamed(Routes.myvehicles),
                        ),
                        const ListTile(
                          leading: Icon(
                            Iconsax.location,
                            color: Colors.blueAccent,
                          ),
                          title: const Text(
                            "Manage Address",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Pre Saved Addresses"),
                        ),
                        const ListTile(
                          leading: Icon(
                            Iconsax.message,
                            color: Colors.blueAccent,
                          ),
                          title: const Text(
                            "Support",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              const Text("Connect us for issues & queries"),
                        ),
                        const ListTile(
                          leading: const Icon(
                            Iconsax.clipboard,
                            color: Colors.blueAccent,
                          ),
                          title: const Text(
                            "Privacy Policy",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("Know our privacy policies"),
                        ),
                        const ListTile(
                          leading: Icon(
                            Iconsax.language_circle,
                            color: Colors.blueAccent,
                          ),
                          title: Text(
                            "Change Language",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Set your prefered language"),
                        ),
                        const ListTile(
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
                        const ListTile(
                          leading: Icon(
                            Iconsax.color_swatch,
                            color: Colors.blueAccent,
                          ),
                          title: Text(
                            "Themes",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("Change the Color theme of App"),
                        ),
                      ]),
                ),
              ),
            )
          ],
        ));
  }
}
