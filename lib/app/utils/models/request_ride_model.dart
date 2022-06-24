// import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestModel {
  late String rideID; //get from that screen
  String? requestID;

  late String passangerID;
  late String startAddress;
  late LatLng startPoint;
  late LatLng endPoint;
  late String endAddress;
  late String message;
  late int seats;

  late DateTime requestedAt;
  late bool isConfirmed;
  late int rideCost;

  // "timestamp": FieldValue.serverTimestamp(),
  // late TimeOfDay requestTime;
  late Timestamp timestamp;
  late DateTime rideStartDate;
 
  late TimeOfDay rideStartTime;

  RequestModel.fromDocumentSnapshot(
      {required DocumentSnapshot<Map<String, dynamic>> snapshot}) {
    rideID = snapshot['rideID'];
    // requestID = snapshot['requestId'] == null ? "" : "";
    passangerID = snapshot['passangerID'];
    startAddress = snapshot['startAddress'];
    GeoPoint start = snapshot['startPoint'];
    startPoint = LatLng(start.latitude, start.longitude);

    endAddress = snapshot['endAddress'];
    GeoPoint end = snapshot['endPoint'];
    endPoint = LatLng(end.latitude, end.longitude);

    message = snapshot['message'];
    seats = snapshot['seats'];
    isConfirmed = snapshot['isConfirmed'];

    requestedAt = DateTime.fromMicrosecondsSinceEpoch(snapshot['requestedAt']);
    
    rideStartTime = TimeOfDay(
        hour: snapshot.data()!['rideStartTime']['hour'],
        minute: snapshot.data()!['rideStartTime']['minute']);
 
    rideStartDate = DateTime.fromMicrosecondsSinceEpoch(snapshot.data()!['rideStartDate']);
  }
}
