class Users {
  final String id;
  final String imagePath;
  final String name;
  final String email;
  final String phone;
  const Users(
      {required this.id,
      required this.imagePath,
      required this.name,
      required this.email,
      required this.phone});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      imagePath: json['userImage'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      id: json['id'],
    );
  }
}
