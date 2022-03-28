import 'package:get/get.dart';
import 'package:weryde/app/features/bottom_nav_bar/controllers/bottom_nav_controller.dart';


class BottomNavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationBarController());
  }
}
