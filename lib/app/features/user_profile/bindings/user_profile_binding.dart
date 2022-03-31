import 'package:get/get.dart';
import 'package:weryde/app/features/user_profile/controllers/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() => UserProfileController());
  }
}
