import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideModel {
  late String id;
  late String driverID;

  late String startAddress;
  late LatLng startPoint;

  late String startSubThoroughfare;
  late String endSubThoroughfare;

  late String endAddress;
  late LatLng endPoint;

  late String startSubLocality;
  late String endSubLocality;
  late String startCity;
  late String endCity;

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
    id = snapshot.data()!['id'];
    driverID = snapshot.data()!['driverID'];
    startAddress = snapshot.data()!['startAddress'];
    startSubLocality = snapshot.data()!['startSubLocality'];
    endSubLocality = snapshot.data()!['endSubLocality'];
    startCity = snapshot.data()!['startCity'];
    endCity = snapshot.data()!['endCity'];
    GeoPoint start = snapshot.data()!['startPoint'];
    startPoint = LatLng(start.latitude, start.longitude);
    startSubThoroughfare = snapshot.data()!['startSubThoroughfare'];
    endSubThoroughfare = snapshot.data()!['endSubThoroughfare'];
    endAddress = snapshot.data()!['endAddress'];
    GeoPoint end = snapshot.data()!['endPoint'];
    endPoint = LatLng(end.latitude, end.longitude);
    route = snapshot.data()!['route'];
    startDate = DateTime.fromMicrosecondsSinceEpoch(snapshot.data()!['date']);
    time = TimeOfDay(
        hour: snapshot.data()!['time']['hour'],
        minute: snapshot.data()!['time']['minute']);
    vehicleId = snapshot['vehicle']['id'];
    totalSeats = snapshot.data()!['totalSeats'];
    confirmedSeats = snapshot.data()!['confirmedSeats'];
    vehicleType = snapshot.data()!['vehicle']['type'];
    message = snapshot.data()!['message'];
    postedAt =
        DateTime.fromMicrosecondsSinceEpoch(snapshot.data()!['postedAt']);

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
