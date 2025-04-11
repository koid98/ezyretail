
import 'package:ezyretail/helpers/sqflite_helper.dart';

class UsersModel {
  String userKey;
  String name;
  String password;
  int access;
  String pin;

  UsersModel({
    required this.userKey,
    required this.name,
    required this.password,
    required this.access,
    required this.pin,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        userKey: json["userKey"],
        name: json["name"],
        password: json["password"],
        access: json["access"],
        pin: json["pin"],
      );

  factory UsersModel.fromCloud(Map<String, dynamic> json) => UsersModel(
        userKey: json["user_id"].toString(),
        name: json["username"],
        password: json["password"],
        access: int.parse((json["access_control"] ?? 1).toString()),
        pin: json["fast_login_pin"],
      );

  factory UsersModel.fromDB(Map<String, dynamic> json) => UsersModel(
        userKey: json[DatabaseHelper.userKey],
        name: json[DatabaseHelper.userName],
        password: json[DatabaseHelper.password],
        access: json[DatabaseHelper.access],
        pin: json[DatabaseHelper.pin],
      );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.userKey: userKey,
      DatabaseHelper.userName: name,
      DatabaseHelper.password: password,
      DatabaseHelper.access: access,
      DatabaseHelper.pin: pin,
    };
  }

  UsersModel copyWith({
    String? userKey,
    String? name,
    String? password,
    int? access,
    String? pin,
  }) =>
      UsersModel(
        userKey: userKey ?? this.userKey,
        name: name ?? this.name,
        password: password ?? this.password,
        access: access ?? this.access,
        pin: pin ?? this.pin,
      );
}
