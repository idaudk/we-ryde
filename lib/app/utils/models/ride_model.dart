import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideModel {
  // late String driverId;
  // late DateTime date;
  // late String homeAddress = "null";
  // Map<String, dynamic> nomineeDetails = {};
  // Map<String, dynamic> cnicDetails = {};
  // Map<String, dynamic> workingDetails = {};
  // List<dynamic> vehicleList = [];
  // List<dynamic> postedRidesList = [];
  // late String id;
  // late String id;
  late String id;
  late String driverId;

  //late String startPostalCode;
  late String startAddress;
  late LatLng startPoint;

  late String startSubThoroughfare;
  late String endSubThoroughfare;

  late String endAddress;
  late LatLng endPoint;

  late String route;
  //ads route points or poluline later on
  late DateTime startDate;
  late TimeOfDay time;

  late String vehicleId;
  late String vehicleType;
  late String message;
  late DateTime postedAt;
  late int totalSeats;
  late int confirmedSeats;
  // List<RequestModel> requestList = [];

  RideModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    id = snapshot['id'];
    driverId = snapshot['driverID'];
    startAddress = snapshot['startAddress'];
    GeoPoint start = snapshot['startPoint'];
    startPoint = LatLng(start.latitude, start.longitude);
    startSubThoroughfare = snapshot['startSubThoroughfare'];
    endAddress = snapshot['endAddress'];
    GeoPoint end = snapshot['endPoint'];
    endPoint = LatLng(end.latitude, end.longitude);
    route = snapshot['route'];
    startDate = DateTime.fromMicrosecondsSinceEpoch(snapshot['date']);
    time = TimeOfDay(
        hour: snapshot['time']['hour'], minute: snapshot['time']['minute']);
    vehicleId = snapshot['vehicle']['id'];
    totalSeats = snapshot['totalSeats'];
    confirmedSeats = snapshot['confirmedSeats'];
    vehicleType = snapshot['vehicle']['type'];
    message = snapshot['message'];
    postedAt = DateTime.fromMicrosecondsSinceEpoch(snapshot['postedAt']);

    // requestList = RideDatabase.loadRideRequests(id);
//manage ride requests from here

    // if (snapshot.data().containsKey('request')) {
    //   // vehicleList = snapshot['vehicles'];
    //   // print(vehicleList[0]);
    //   var tempList = snapshot['request'];

    //   for (var item in tempList) {
    //     requestList
    //         .add(RequestModel.fromDocumentSnapshot(snapshot: item, rideId: id));
    //   }
    // }
  }

  // Map<String, dynamic> toJson(){
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   return data;
  // }
}
