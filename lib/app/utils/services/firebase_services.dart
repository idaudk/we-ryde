import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

abstract class UserServices {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  /// return true if phone number already exists
  static Future<bool> phoneNumberExists(String phoneNumber,
      {Function(Object)? onError}) async {
    var isValidUser = false;

    await _firestore
        .collection('users')
        .where('phone_number', isEqualTo: phoneNumber)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
    }).catchError(
      onError ??
          (_) {
            log("checking phone number : failed");
          },
    );

    return isValidUser;
  }

  static void addUser(
    Registrant data, {
    Function()? onSuccess,
    Function(Object)? onError,
  }) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      'name': data.name,
      'phone_number': data.phoneNumber,
      'email': data.emailAddress,
      'cinc': data.cnic,
      'profile_image': data.profileImage
    }, SetOptions(merge: true)).then((value) {
      if (onSuccess != null) onSuccess();
    }).catchError(
      onError ??
          (_) {
            log("add user : failed");
          },
    );
  }

  static Future<Registrant?> getUserLogin() async {
    Registrant? registrant;
    if (_auth.currentUser != null) {
      var phoneNumber = _auth.currentUser!.phoneNumber!;

      await _firestore
          .collection('users')
          .where('phone_number', isEqualTo: phoneNumber)
          .get()
          .then((result) {
        if (result.docs.length > 0) {
          registrant = Registrant(
            name: result.docs[0].data()['name'],
            phoneNumber: phoneNumber,
            emailAddress: result.docs[0].data()['email'],
            cnic: result.docs[0].data()['cinc'],
            profileImage: result.docs[0].data()['profile_image'],
          );
        }
      }).catchError((_) {});
    }
    return registrant;
  }

  // static Stream<Map<String, dynamic>> userDataStream() {
  //   return _firestore
  //       .collection('users')
  //       .doc(_auth.currentUser!.uid)
  //       .snapshots().toList().then((value) {});
  //     //   .map((DocumentSnapshot query) {
  //     // List<Registrant> usersDocs = [];
      
  //     // for (var users in query.docs) {
  //     //   final registrant =
  //     //       Registrant.fromDocumentSnapshot(documentSnapshot: users);
  //     //   usersDocs.add(registrant);
  //     // }
  //     // return usersDocs;
  //   // });
  // }
}

class Registrant {
  late String name;
  late String phoneNumber;
  late String emailAddress;
  late String cnic;
  late String profileImage;

  Registrant({
    required this.name,
    required this.phoneNumber,
    required this.emailAddress,
    required this.cnic,
    required this.profileImage,
  });

  // Registrant.fromDocumentSnapshot(
  //     {required DocumentSnapshot documentSnapshot}) {
  //   name = documentSnapshot["name"];
  //   phoneNumber = documentSnapshot["phone_number"];
  //   emailAddress = documentSnapshot["email"];
  //   profileImage = documentSnapshot["profile_image"];
  //   cnic = documentSnapshot["cnic"];
  // }
}
