

import 'package:ezyretail/helpers/sqflite_helper.dart';

class ShiftObject {
  String batchKey;
  DateTime openTime;
  String openUserKey;
  String openUser;
  String closeTime;
  String closeUserKey;
  String? closeUser;

  ShiftObject({
    required this.batchKey,
    required this.openTime,
    required this.openUserKey,
    required this.openUser,
    required this.closeTime,
    required this.closeUserKey,
    required this.closeUser,
  });

  factory ShiftObject.fromDB(Map<String, dynamic> json) => ShiftObject(
    batchKey: json[DatabaseHelper.batchKey],
    openTime:
    DateTime.parse(json[DatabaseHelper.startCounter] ?? DateTime.now()),
    openUserKey: json[DatabaseHelper.openCounterUser] ?? "",
    openUser: json['OPENUSER'] ?? "",
    closeTime: json[DatabaseHelper.endCounter] ?? "",
    closeUserKey: json[DatabaseHelper.closeCounterUser] ?? "",
    closeUser: json['CLOSEUSER'] ?? "",
  );
}
