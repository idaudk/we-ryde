import 'package:get/get.dart';
import 'package:weryde/app/features/search_pool/controllers/search_pool_controller.dart';

class SearchPoolBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPoolController());
  }
}
