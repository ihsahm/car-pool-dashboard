class Trip {
  final String driverID;
  final String pickUpLatPos;
  final String pickUpLongPos;
  final String dropOffLatPos;
  final String dropOffLongPos;
  final double pickUpDistance;
  final double dropOffDistance;
  final String destinationLocation;
  final int passengers;
  final String tripID;
  final String pickUpLocation;

  const Trip(
      {required this.driverID,
      required this.pickUpLatPos,
      required this.pickUpLongPos,
      required this.dropOffLatPos,
      required this.tripID,
      required this.passengers,
      required this.dropOffLongPos,
      required this.pickUpDistance,
      required this.dropOffDistance,
      required this.destinationLocation,
      required this.pickUpLocation});
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      destinationLocation: json['destinationLocation'],
      pickUpLocation: json['pickUpLocation'],
      pickUpLongPos: json['pickUpLongPos'],
      pickUpDistance: json['pickUpDistance'],
      pickUpLatPos: json['pickUpLatPos'],
      driverID: json['driverID'],
      tripID: json['tripID'],
      dropOffDistance: json['dropOffDistance'],
      dropOffLatPos: json['dropOffLatPos'],
      dropOffLongPos: json['dropOffLongPos'],
      passengers: json['passengers'],
    );
  }
}
