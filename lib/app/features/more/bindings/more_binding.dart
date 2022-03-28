import 'package:get/get.dart';
import 'package:weryde/app/features/more/controllers/more_controller.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() => MoreController());
  }
}
