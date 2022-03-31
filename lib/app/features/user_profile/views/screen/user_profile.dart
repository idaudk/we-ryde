library user_profile_screen;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/features/more/controllers/more_controller.dart';
import 'package:weryde/app/utils/animations/animations.dart';

import '../../controllers/user_profile_controller.dart';

part '../components/appbar.dart';
part '../components/userinfo.dart';
part '../components/name_field.dart';
part '../components/email_field.dart';
part '../components/phone_field.dart';
part '../components/save_button.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({Key? key}) : super(key: key);
  UserProfileController userProfileController =
      Get.put(UserProfileController());
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xffebf2f8),
          height: MediaQuery.of(context).size.height,
          key: _key,
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
                          Text(
                            "National Identification Card",
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "cnic.pdf",
                                style: TextStyle(color: Color(0xff0ec874)),
                              ),
                              Icon(
                                Iconsax.verify,
                                color: Color(0xff0ec874),
                              )
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Driving License",
                            style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.3)),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Driving license.pdf",
                                style: TextStyle(color: Color(0xff0ec874)),
                              ),
                              Icon(
                                Iconsax.verify,
                                color: Color(0xff0ec874),
                              )
                            ],
                          ),
                          const Divider(),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text(
                            "Account Info",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11.sp,
                                color: Colors.black.withOpacity(0.3)),
                          ),
                          SizedBox(height: 30.h),
                          _NameField(),
                          Obx(() => userProfileController.isLoading.value
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: CircularProgressIndicator())
                              // : Card(
                              //     child: ListTile(
                              //       title: Text(controller.user.value?.name ?? "-"),
                              //       subtitle: Text(controller.user.value?.phoneNumber ?? "-"),
                              //     ),
                              //   ),
                              : Column(
                                  children: [
                                    _EmailField(),
                                    _PhoneField(),
                                    SizedBox(
                                      height: 30.h,
                                    ),
                                    _SavedButton()
                                  ],
                                )),
                        ]),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
