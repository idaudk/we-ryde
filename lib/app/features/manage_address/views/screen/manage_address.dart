library manage_address;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../utils/animations/animations.dart';
import '../../controllers/manage_address.dart';

part '../components/appbar.dart';
part '../components/banner.dart';
part '../components/add_new_address.dart';
part '../components/adress_manage.dart';


class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({Key? key}) : super(key: key);

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
                AddNewAddress(),
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
                          children: const [
                            ListTile(
                              leading: Icon(
                                Iconsax.home,
                                color: Color(0xff0ec874),
                              ),
                              title: Text(
                                "Home",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("B121 - Galaxy Residency "),
                            ),
                            ListTile(
                              leading: Icon(
                                Iconsax.building,
                                color: Color(0xff0ec874),
                              ),
                              title: Text(
                                "Office",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("B121 - Galaxy Residency "),
                            ),
                            ListTile(
                              leading: Icon(
                                Iconsax.more,
                                color: Color(0xff0ec874),
                              ),
                              title: Text(
                                "Other",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("B121 - Galaxy Residency "),
                            ),



                          ]),
                    ),
                  ),
                ),

              ],
            )),
      ),
    );
  }
}
