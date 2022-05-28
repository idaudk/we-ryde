import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleModel {
   late String vehicleOwnerId;
   late String vehicleName;
   late String vehilceType;
   late String vehicleRegNo;
   late int vehicleSeats;
   late String? vehicleFacilities;
   late String? vehicleInstructions;

  VehicleModel(
      {required this.vehicleOwnerId,
      required this.vehicleName,
      required this.vehilceType,
      required this.vehicleRegNo,
      required this.vehicleSeats,
      required this.vehicleFacilities,
      required this.vehicleInstructions});


  VehicleModel.fromJson(Map<String, dynamic> json) {
    vehicleOwnerId = json['vehicleOwnerId'];
    vehicleName = json['vehicleName'];
    vehilceType = json['vehilceType'];
    vehicleRegNo = json['vehicleRegNo'];
    vehicleSeats = json['vehicleSeats'];
    vehicleFacilities = json['vehicleFacilities'];
    vehicleInstructions = json['vehicleInstructions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vehicleOwnerId'] = this.vehicleOwnerId;
    data['vehicleName'] = this.vehicleName;
    data['vehilceType'] = this.vehilceType;
    data['vehicleRegNo'] = this.vehicleRegNo;
    data['vehicleSeats'] = this.vehicleSeats;
    data['vehicleFacilities'] = this.vehicleFacilities;
    data['vehicleInstructions'] = this.vehicleInstructions;
    return data;
  }    

  // Map<String, dynamic> toMap() {
  //   return {
  //     'vehicleOwnerId': vehicleOwnerId,
  //     'vehicleName': vehicleName,
  //     'vehilceType': vehilceType,
  //     'vehicleRegNo': vehicleRegNo,
  //     'vehicleSeats': vehicleSeats,
  //     'vehicleFacilities': vehicleFacilities,
  //     'vehicleInstructions': vehicleInstructions,
  //     // 'address': address.toMap(),
  //     // 'employeeTraits': employeeTraits
  //   };
  // }

  //   retrieveVehicles() async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot =
  //       await _db.collection("Employees").get();
  //   return snapshot.docs
  //       .map((docSnapshot) => VehicleModel.fromDocumentSnapshot(docSnapshot))
  //       .toList();
  // }
  
}
