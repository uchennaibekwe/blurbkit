// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.email,
    this.firstname,
    this.lastname,
    this.gender,
    this.middlename,
    this.phone,
    this.image,
    this.roles,
    this.dateJoined,
    this.verified,
    this.password,
  });

  String id;
  String email;
  String firstname;
  String lastname;
  String gender;
  String middlename;
  String phone;
  dynamic image;
  List<String> roles;
  DateTime dateJoined;
  bool verified;
  String password;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        gender: json["gender"],
        middlename: json["middlename"],
        phone: json["phone"],
        image: json["image"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        dateJoined: DateTime.parse(json["date_joined"]),
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "middlename": middlename,
        "phone": phone,
        "image": image,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "date_joined": dateJoined.toIso8601String(),
        "verified": verified,
      };
}
