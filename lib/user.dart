import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    required this.user,
    required this.phone,
    required this.checkIn,
  });

  String user;
  String phone;
  DateTime checkIn;

  factory User.fromJson(Map<String, dynamic> json) => User(
        user: json["user"],
        phone: json["phone"],
        checkIn: DateTime.parse(json["check-in"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "phone": phone,
        "check-in": checkIn.toIso8601String(),
      };
}
