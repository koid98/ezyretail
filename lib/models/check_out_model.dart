import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:flutter/material.dart';

class CheckOutPaymentObject {
  String batchKey;
  String code;
  String description;
  int paymentType;
  int salesCount;
  int returnCount;
  double salesAmount;
  double returnAmount;
  double totalAmount;

  CheckOutPaymentObject({
    required this.batchKey,
    required this.code,
    required this.description,
    required this.paymentType,
    required this.salesCount,
    required this.returnCount,
    required this.salesAmount,
    required this.returnAmount,
    required this.totalAmount,
  });
}

class CashIOObject {
  String batchKey;
  double openingAmount;
  double closingAmount;
  double cashInAmount;
  double cashOutAmount;

  CashIOObject({
    required this.batchKey,
    required this.openingAmount,
    required this.closingAmount,
    required this.cashInAmount,
    required this.cashOutAmount,
  });

  factory CashIOObject.fromDB(Map<String, dynamic> json) => CashIOObject(
    batchKey: json[DatabaseHelper.batchKey],
    openingAmount: json["OpeningAmount"] ?? 0.0,
    closingAmount: json["ClosingAmount"] ?? 0.0,
    cashInAmount: json["CashInAmount"] ?? 0.0,
    cashOutAmount: json["CashOutAmount"] ?? 0.0,
  );
}

class SyncObject {
  String docDate;
  String docNo;
  String docType;
  String syncTime;
  String status;

  SyncObject({
    required this.docDate,
    required this.docNo,
    required this.docType,
    required this.syncTime,
    required this.status,
  });

  factory SyncObject.fromDB(Map<String, dynamic> json) => SyncObject(
    docDate: json[DatabaseHelper.docDate],
    docNo: json[DatabaseHelper.docNo] ?? "",
    docType: json[DatabaseHelper.docType] ?? "",
    syncTime: json[DatabaseHelper.syncTime] ?? "",
    status: json[DatabaseHelper.status] ?? "",
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.docDate: docDate,
      DatabaseHelper.docNo: docNo,
      DatabaseHelper.docType: docType,
      DatabaseHelper.syncTime: syncTime,
      DatabaseHelper.status: status,
    };
  }
}

class SyncEinvoiceObject {
  String docDate;
  String docNo;
  String docType;
  String syncTime;
  String status;
  String? eInvoiceNum;
  String? eInvoiceRemark;

  SyncEinvoiceObject({
    required this.docDate,
    required this.docNo,
    required this.docType,
    required this.syncTime,
    required this.status,
    this.eInvoiceNum,
    this.eInvoiceRemark,
  });

  factory SyncEinvoiceObject.fromDB(Map<String, dynamic> json) =>
      SyncEinvoiceObject(
        docDate: json[DatabaseHelper.docDate],
        docNo: json[DatabaseHelper.docNo] ?? "",
        docType: json[DatabaseHelper.docType] ?? "",
        syncTime: json[DatabaseHelper.syncTime] ?? "",
        status: json[DatabaseHelper.status] ?? "",
        eInvoiceNum: json[DatabaseHelper.eInvoiceNum] ?? "",
        eInvoiceRemark: json[DatabaseHelper.eInvoiceRemark] ?? "",
      );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.docDate: docDate,
      DatabaseHelper.docNo: docNo,
      DatabaseHelper.docType: docType,
      DatabaseHelper.syncTime: syncTime,
      DatabaseHelper.status: status,
      DatabaseHelper.eInvoiceNum: eInvoiceNum,
      DatabaseHelper.eInvoiceRemark: eInvoiceRemark,
    };
  }
}
