import 'package:get/get.dart';

import '../contorller/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqContorller());
  }
}