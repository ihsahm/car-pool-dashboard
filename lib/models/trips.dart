class Trip {
  final String driverID;
  final String pickUpLatPos;
  final String pickUpLongPos;
  final String dropOffLatPos;
  final String dropOffLongPos;
  final String destinationLocation;
  final String passengers;
  final String tripID;
  final String price;
  final String pickUpLocation;

  const Trip(
      {required this.driverID,
      required this.pickUpLatPos,
      required this.pickUpLongPos,
      required this.dropOffLatPos,
      required this.tripID,
      required this.passengers,
      required this.dropOffLongPos,
      required this.destinationLocation,
      required this.pickUpLocation,
      required this.price});
  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      price: json['price'],
      destinationLocation: json['destinationLocation'],
      pickUpLocation: json['pickUpLocation'],
      pickUpLongPos: json['pickUpLongPos'],
      pickUpLatPos: json['pickUpLatPos'],
      driverID: json['driverID'],
      tripID: json['tripID'],
      dropOffLatPos: json['dropOffLatPos'],
      dropOffLongPos: json['dropOffLongPos'],
      passengers: json['passengers'],
    );
  }
}
