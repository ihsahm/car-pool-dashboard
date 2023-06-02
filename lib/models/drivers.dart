class Driver {
  final String id;
  final String imagePath;
  final String name;
  final String email;
  final String phone;
  final String ratings;
  final String carMake;
  final String carModel;
  final String carYear;
  final String carColor;
  final String carPlateNo;

  const Driver({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.email,
    required this.phone,
    required this.ratings,
    required this.carMake,
    required this.carModel,
    required this.carYear,
    required this.carColor,
    required this.carPlateNo,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      imagePath: json['driver_image'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      ratings: json['ratings'],
      carMake: json['car_make'],
      carColor: json['car_color'],
      carModel: json['car_model'],
      carPlateNo: json['car_plateNo'],
      carYear: json['car_year'],
      id: json['id'],
    );
  }
}
