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
      imagePath: json['userImage'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      ratings: json['ratings'],
      carMake: json['carMake'],
      carColor: json['carColor'],
      carModel: json['carModel'],
      carPlateNo: json['carPlateNo'],
      carYear: json['carYear'],
      id: json['id'],
    );
  }
}
