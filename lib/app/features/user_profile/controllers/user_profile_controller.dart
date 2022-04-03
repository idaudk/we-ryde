import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/routes/app_pages.dart';
import '../../../utils/services/firebase_services.dart';

class UserProfileController extends GetxController {
  final _auth = FirebaseAuth.instance;
  late Rx<Registrant?> user = Rx(null);

  var name = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();

  var isLoading = true.obs;

  File? pickedImage;
  var showLocalImage = false.obs;

  @override
  void onInit() async {
    UserServices.getUserLogin().then((result) {
      user.value = result;
      name.text = result!.name;
      email.text = result.emailAddress;
      phoneNumber.text = result.phoneNumber;
      isLoading.value = false;
      print("user Profile Image URL: " + user.value!.profileImage.toString());
    });
    super.onInit();
  }

  void logout() async {
    await _auth.signOut().then((value) => Get.offNamed(Routes.login));
  }

  pickImageFromDevice() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      Get.back();
      //return;
    } else {
      Get.back();

      Get.snackbar(
        "Profile Image Uploading",
        "Your selected profile image is uploading....",
        icon: Icon(Iconsax.document_upload, color: Color(0xff0ec874)),
        shouldIconPulse: true,
        isDismissible: false,
        snackPosition: SnackPosition.TOP,
        duration: Duration(minutes: 99),
      );

      pickedImage = File(file.path);

      //Get.back();
      //update();
      //Align(alignment: Alignment.topCenter, child: CircularProgressIndicator());
      try {
        var fileName = user.value!.phoneNumber + '.jpg';
        UploadTask uploadTask = FirebaseStorage.instance
            .ref()
            .child('profile_images')
            .child(fileName)
            .putFile(pickedImage!);
        TaskSnapshot snapshot = await uploadTask;
        String profileImageUrl = await snapshot.ref.getDownloadURL();
        print("ProfileImageUrl:" + profileImageUrl);
        FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({'profile_image': profileImageUrl}).then(
                (value) => print("database is updated"));

        //FirebaseFirestore.instance.collection('users').doc( )

        showLocalImage.value = true;

        update();
        Get.back();
      } catch (e) {
        Get.snackbar("Unable to upload image!", e.toString());
      }
    }
  }
}
