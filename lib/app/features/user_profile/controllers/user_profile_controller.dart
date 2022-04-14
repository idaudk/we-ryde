import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import '../../../config/routes/app_pages.dart';
import '../../../utils/services/firebase_services.dart';

class UserProfileController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late Rx<Registrant?> user = Rx(null);

  var name = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();

  var isLoading = true.obs;
  var imageIsLoading = true.obs;
  var isButtonLoading = true.obs;

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
      imageIsLoading.value = false;
      isButtonLoading.value = false;
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

  pickImageFromCamera() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);
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

  Future<void> updateUser() {
    //isLoading.value = true;
    isButtonLoading.value = true;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .update({
      'name': name.text,
      'email': email.text,
      'phone_number': phoneNumber.text
    }).then((value) {
      isButtonLoading.value = false;
      Get.snackbar("Profile Updated Sucessfully",
          "Your profile informataion have been updated sucessfully.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          icon: Icon(
            Iconsax.tick_circle,
          ),
          shouldIconPulse: true);
    }).catchError((error) {
      isButtonLoading.value = false;
      Get.snackbar("Failed to update profile", "$error",
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(Iconsax.wifi),
          shouldIconPulse: true);
    });
  }
}
