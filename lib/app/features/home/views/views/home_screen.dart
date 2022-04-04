library home_view;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/features/home/controllers/home_controller.dart';

import '../../controllers/home_controller.dart';

part '../components/profile.dart';
part '../components/drawer.dart';
part '../components/appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffebf2f8),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          _AppBar(),
          SizedBox(
            height: 40.h,
          ),
          Expanded(
              child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                height: 500.h,
                color: Colors.pink,
              ),
              Container(
                height: 400.h,
                color: Colors.grey,
              )
            ],
          ))
        ],
      ),
    );
  }
}
