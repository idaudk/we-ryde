library my_vehciles_screen;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/features/my_vehicles/controllers/my_vehicles_controller.dart';

import '../../../../utils/animations/animations.dart';

part '../components/appbar.dart';
part '../components/banner.dart';

class MyVehiclesScreen extends StatelessWidget {
  MyVehiclesScreen({Key? key}) : super(key: key);
  MyVehiclesController moreController = Get.put(MyVehiclesController());
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
              Container(
                width: double.infinity,
                height: 20.h,
                decoration: BoxDecoration(color: Colors.red),
              ),
              SlideAnimation(
                begin: const Offset(0, 300),
                child: Container(
                  //sconstraints: BoxConstraints.expand(),
                  height: MediaQuery.of(context).size.height - 230.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.h),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Colors.white),
                  //width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height,
                  child: ListView(
                    //physics: BouncingScrollPhysics(),
                    children: [
                      ListTile(
                        trailing: Container(
                          height: 90.h,
                          width: 90.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "https://images.pexels.com/photos/3610342/pexels-photo-3610342.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        title: Text(
                          "Toyota Matrix",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("Hatchback | NYC55142 | 4 seats"),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
