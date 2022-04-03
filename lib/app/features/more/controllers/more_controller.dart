import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../config/routes/app_pages.dart';
import '../../../utils/services/firebase_services.dart';

class MoreController extends GetxController {
  final auth = FirebaseAuth.instance;
  late Rx<Registrant?> user = Rx(null);
  var isLoading = true.obs;

  //testing code ------- Daud K
  Rx<List<Registrant>> registrantList = Rx<List<Registrant>>([]);
  List<Registrant> get registrants => registrantList.value;

  @override
  void onInit() async {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      isLoading.value = false;
    });
    super.onInit();
  }

  // Testing Code --- idaudk
  // @override
  // void onReady() {
  //   super.onReady();
  //   registrantList.bindStream(UserServices.userDataStream());
  // }

  void logout() async {
    await auth.signOut().then((value) => Get.offNamed(Routes.login));
  }

  // Testing Code ----Idaudk
  // Stream getUserDataInRealTime() {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(auth.currentUser!.uid)
  //       .snapshots();
  // }
}
