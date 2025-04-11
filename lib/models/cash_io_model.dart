import 'dart:typed_data';

import 'package:ezyretail/helpers/sqflite_helper.dart';

import '../globals.dart';

class CashIOModel {
  String docNo;
  String batchKey;
  String userKey;
  String performTime;
  double cashInOutAmount;
  String reasonCode;
  String reason;
  int isOpening;
  int isClosing;
  Uint8List? attachment;

  CashIOModel(
      {required this.docNo,
        required this.batchKey,
        required this.userKey,
        required this.performTime,
        required this.cashInOutAmount,
        required this.reasonCode,
        required this.reason,
        required this.isOpening,
        required this.isClosing,
        this.attachment});

  factory CashIOModel.fromDB(Map<String, dynamic> json) => CashIOModel(
    docNo: json[DatabaseHelper.docNo],
    batchKey: json[DatabaseHelper.batchKey],
    userKey: json[DatabaseHelper.userKey],
    performTime: json[DatabaseHelper.performTime],
    cashInOutAmount: json[DatabaseHelper.cashInOutAmount],
    reasonCode: json[DatabaseHelper.reasonCode],
    reason: json[DatabaseHelper.reason],
    isOpening: json[DatabaseHelper.isOpening],
    isClosing: json[DatabaseHelper.isClosing],
    attachment: json[DatabaseHelper.attachment],
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.docNo: docNo,
      DatabaseHelper.batchKey: batchKey,
      DatabaseHelper.userKey: userKey,
      DatabaseHelper.performTime: performTime,
      DatabaseHelper.cashInOutAmount: cashInOutAmount,
      DatabaseHelper.reasonCode: reasonCode,
      DatabaseHelper.reason: reason,
      DatabaseHelper.isOpening: isOpening,
      DatabaseHelper.isClosing: isClosing
    };
  }
}

class CashIOHeaderModel {
  String batchKey;
  String batchDate;
  double totalIn;
  double totalOut;

  CashIOHeaderModel({
    required this.batchKey,
    required this.batchDate,
    required this.totalIn,
    required this.totalOut,
  });

  factory CashIOHeaderModel.fromDB(Map<String, dynamic> json) =>
      CashIOHeaderModel(
          batchKey: json[DatabaseHelper.batchKey],
          batchDate: systemShortDate.format(DateTime.parse(json['TRANSDATE'])),
          totalIn: json['CASHIN'] ?? 0.0,
          totalOut: json['CASHOUT'] ?? 0.0);
}

class CashIoReasonModel {
  String code;
  String description;
  int isCashIn;
  int isCashOut;

  CashIoReasonModel({
    required this.code,
    required this.description,
    required this.isCashIn,
    required this.isCashOut,
  });

  factory CashIoReasonModel.fromDB(Map<String, dynamic> json) =>
      CashIoReasonModel(
        code: json[DatabaseHelper.reasonCode],
        description: json[DatabaseHelper.reasonDesc],
        isCashIn: json[DatabaseHelper.isCashIn],
        isCashOut: json[DatabaseHelper.isCashOut],
      );

  factory CashIoReasonModel.fromCloud(Map<String, dynamic> json) =>
      CashIoReasonModel(
        code: json["reason_code"],
        description: json["reason_desc"],
        isCashIn: int.parse((json["isCashIn"] ?? 0).toString()),
        isCashOut: int.parse((json["isCashOut"] ?? 0).toString()),
      );

  factory CashIoReasonModel.fromJson(Map<String, dynamic> json) =>
      CashIoReasonModel(
        code: json["REASON_CODE"],
        description: json["REASON_DESC"],
        isCashIn: (json["IS_CASH_IN"] ?? "F") == "T" ? 1 : 0,
        isCashOut: (json["IS_CASH_OUT"] ?? "F") == "T" ? 1 : 0,
      );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.reasonCode: code,
      DatabaseHelper.reasonDesc: description,
      DatabaseHelper.isCashIn: isCashIn,
      DatabaseHelper.isCashOut: isCashOut,
    };
  }
}

class CashIoUploadModel {
  String docNo;
  String batchKey;
  String batchDate;
  String userKey;
  String performTime;
  double cashInOutAmount;
  String reasonCode;
  String reason;
  int isOpening;
  String location;
  int counter;
  Uint8List? attachment;

  CashIoUploadModel({
    required this.docNo,
    required this.batchKey,
    required this.batchDate,
    required this.userKey,
    required this.performTime,
    required this.cashInOutAmount,
    required this.reasonCode,
    required this.reason,
    required this.isOpening,
    required this.location,
    required this.counter,
    this.attachment,
  });

  factory CashIoUploadModel.fromDB(Map<String, dynamic> json) =>
      CashIoUploadModel(
        docNo: json[DatabaseHelper.docNo],
        batchKey: json[DatabaseHelper.batchKey],
        batchDate: json[DatabaseHelper.startCounter],
        userKey: json[DatabaseHelper.userKey],
        performTime: json[DatabaseHelper.performTime],
        cashInOutAmount: json[DatabaseHelper.cashInOutAmount],
        reasonCode: json[DatabaseHelper.reasonCode],
        reason: json[DatabaseHelper.reason],
        isOpening: json[DatabaseHelper.isOpening],
        location: json[DatabaseHelper.label],
        counter: json[DatabaseHelper.counter],
        attachment: json[DatabaseHelper.attachment],
      );

  Map<String, dynamic> toJson() => {
    "docNo": docNo,
    "batchKey": batchKey,
    "batchDate": batchDate,
    "userKey": userKey,
    "performTime": performTime,
    "cashInOutAmount": cashInOutAmount,
    "reasonCode": reasonCode,
    "reason": reason,
    "isOpening": isOpening,
    "location": location,
    "counter": counter
  };
}
