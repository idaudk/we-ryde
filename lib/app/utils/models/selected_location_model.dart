class SelectedLocation {
  final String placeName;
  final String completeAddress;
  final String locationLatitude;
  final String locationLongitude;

  SelectedLocation(
      {required this.placeName,
      required this.completeAddress,
      required this.locationLatitude,
      required this.locationLongitude,
      });

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
