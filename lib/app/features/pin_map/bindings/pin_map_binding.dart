import 'package:get/get.dart';
import '../controllers/pin_map_controller.dart';

class StartLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PinMapController());
  }
}
