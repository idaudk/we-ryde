import 'package:get/get.dart';

import '../controllers/manage_address.dart';

class ManageAddress extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageAdreesController());
  }
}