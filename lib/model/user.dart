import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.name,
    required this.image,
    required this.phoneNumber,
    required this.address,
    required this.email,
    required this.status,
  });

  String id;
  String name;
  String image;
  String phoneNumber;
  String address;
  String email;
  String status;

  User copyWith({
    required String id,
    required String name,
    required String image,
    required String phoneNumber,
    required String address,
    required String email,
    required String status,
  }) =>
      User(
        id: id,
        name: name,
        image: image,
        phoneNumber: phoneNumber,
        address: address,
        email: email,
        status: status,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        email: json["email"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "phoneNumber": phoneNumber,
        "address": address,
        "email": email,
        "status": status,
      };
}
