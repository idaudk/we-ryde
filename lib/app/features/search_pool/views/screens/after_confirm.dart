import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weryde/app/features/search_pool/controllers/search_pool_controller.dart';

import '../../../../config/routes/app_pages.dart';
import '../../../../utils/animations/animations.dart';

class ConfirmScreen extends StatelessWidget {
  SearchPoolController _searchPoolController = Get.put(SearchPoolController());

  ConfirmScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 30.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.h,
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ScaleAnimation(
                      child: Container(
                        // height: 300.h,
                        width: 300.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            "https://firebasestorage.googleapis.com/v0/b/we-ryde-007.appspot.com/o/profile_images%2Fcongrat.jpg?alt=media&token=6e979011-5360-459f-a50c-c7349367f826",
                            fit: BoxFit.contain,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 0.h,
                    ),
                    ScaleAnimation(
                      child: Text(
                        "Congratulations",
                        style: TextStyle(
                            fontSize: 24.r, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ScaleAnimation(
                      child: Text(
                        "Your Car Pooling has been confirmed.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.r, fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: ScaleAnimation(
                      child: ElevatedButton(
                        onPressed: () {
                          Get.offNamed(Routes.bottomnav);
                        },
                        child: Text(
                          "My Trips",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
