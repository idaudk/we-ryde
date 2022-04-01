import 'package:get/get.dart';
import 'package:weryde/app/features/chats/controllers/chats_controller.dart';


class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatsController());
  }
}