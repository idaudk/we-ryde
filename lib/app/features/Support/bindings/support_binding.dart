import 'package:get/get.dart';

import '../controllers/supoort_controller.dart';

class SupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SupportController());
  }
}