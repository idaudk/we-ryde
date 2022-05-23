import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weryde/app/config/routes/app_pages.dart';
import 'package:weryde/app/constants/assets_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _initialize();
    return Scaffold(
      body: Container(
        color: Color(0xffebf2f8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width * 0.5,
                child: Image.asset(
                  ImageRasterConstant.appLogo,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "We Ryde",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.r,
                    color: Colors.green),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _initialize() {
    Firebase.initializeApp().then((value) async {
      await Future.delayed(Duration(seconds: 2));
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offNamed(Routes.bottomnav);
      } else {
        Get.offNamed(Routes.login);
      }
    });
  }
}
