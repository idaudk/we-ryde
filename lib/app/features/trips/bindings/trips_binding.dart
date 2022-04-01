import 'package:get/get.dart';
import 'package:weryde/app/features/trips/controllers/trips_controller.dart';


class TripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TripsController());
  }
}