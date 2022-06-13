// import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String phone_number;
  late String email;
  late String cnic;
  late String? profile_image;
  late String driverID;
  //late DateTime dob;
  //late String homeAddress = "null";
  //double rating = 0.0; //get from database
  //double profileComplete = 30; //get from database
  //Map<String, dynamic> nomineeDetails = {};
  //Map<String, dynamic> cnicDetails = {};
  //Map<String, dynamic> workingDetails = {};
  List vehicleList = [];
  // List<RideModel> postedRidesList = [];
  //List<dynamic> chatList = [];
  // late String id;
  // late String id;
  UserModel(
      {required this.name,
      required this.email,
      required this.cnic,
      required this.phone_number,
      required this.profile_image,
      required this.vehicleList,
      required this.driverID});

  UserModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot,
      bool isLoadOthers = false}) {
    //id = snapshot.data()!["id"];
    name = snapshot.data()!["name"];
    email = snapshot.data()!["email"];
    phone_number = snapshot.data()!["phone_number"];
    profile_image = snapshot.data()!["profile_image"];
    driverID = snapshot.data()!['driverID'];
    if (snapshot.data()!.containsKey('vehiclesList')) {
      vehicleList = snapshot.data()!['vehiclesList'];
    }
  }

  // loadRides() {
  //   // postedRidesList.clear();
  //   FirebaseFirestore.instance
  //       .collection('ride')
  //       .where("driverID", isEqualTo: Get.find<AuthController>().userfb!.uid)
  //       .get()
  //       .then((value) {
  //     value.docs.forEach((element) {
  //       // postedRidesList.add(RideModel.fromDocumentSnapshot(snapshot: element));
  //     });
  //   });
  // }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
