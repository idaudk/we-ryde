class SelectedLocation {
  final String placeName;
  final String completeAddress;
  final double locationLatitude;
  final double locationLongitude;
  final String subThoroughfare;
  final String cityName;
  final String subLocality;
  final String? postalCode;

  SelectedLocation(
      {required this.placeName,
      required this.completeAddress,
      required this.locationLatitude,
      required this.locationLongitude,
      required this.subThoroughfare,
      required this.cityName,
      required this.subLocality,
      this.postalCode});

  // factory SelectedLocation.fromDocument(DocumentSnapshot document) {
  //   return User(
  //     document['userName'],
  //     document['email'],
  //     document['name'],
  //     document['phoneNumber'],
  //     document['profilePictureUrl'],
  //     document['creationDate']
  //   );
  // }
}
