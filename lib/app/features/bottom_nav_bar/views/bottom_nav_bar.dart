import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weryde/app/features/bottom_nav_bar/controllers/bottom_nav_controller.dart';
import 'package:weryde/app/features/home/views/views/home_screen.dart';
import 'package:weryde/app/features/more/views/screens/more_screen.dart';

class BottomNavigationBarUI extends StatelessWidget {
  BottomNavigationBarController bottomNavigationBarController =
      Get.put(BottomNavigationBarController());

  BottomNavigationBarUI({Key? key}) : super(key: key);
  final screens = [
    HomeScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => PageTransitionSwitcher(
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return FadeThroughTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: screens[bottomNavigationBarController.selectedIndex.value],
            //   IndexedStack(
            //   index: bottomNavigationBarController.selectedIndex.value,
            //   children: screens,
            // ),
          )),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))
        ]),
        child: Obx(() => GNav(
                selectedIndex:
                    bottomNavigationBarController.selectedIndex.value,
                onTabChange: (index) {
                  bottomNavigationBarController.changeIndex(index);
                },
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                //backgroundColor: Colors.white,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: Iconsax.home,
                    text: "Home",
                  ),
                  GButton(
                    icon: Iconsax.menu,
                    text: "More",
                  ),
                ])),
      ),
    );
  }
}
