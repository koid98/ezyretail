import 'package:ezyretail/helpers/sqflite_helper.dart';

class SalesAndReturnModel {
  List<ItemSummaryReportModel> salesList;
  List<ItemSummaryReportModel> returnList;

  SalesAndReturnModel({
    required this.salesList,
    required this.returnList,
  });
}

class ItemSummaryReportModel {
  String itemCode;
  String itemDesc;
  String itemUom;
  double quantity;
  double totalAmount;

  ItemSummaryReportModel({
    required this.itemCode,
    required this.itemDesc,
    required this.itemUom,
    required this.quantity,
    required this.totalAmount,
  });

  factory ItemSummaryReportModel.fromDB(Map<String, dynamic> json) =>
      ItemSummaryReportModel(
        itemCode: json[DatabaseHelper.itemCode] ?? "",
        itemDesc: json[DatabaseHelper.itemDesc] ?? "",
        itemUom: json[DatabaseHelper.itemUom] ?? "",
        quantity: json[DatabaseHelper.quantity] ?? 0.0,
        totalAmount: json[DatabaseHelper.totalAmount] ?? 0.0,
      );

  Map<String, dynamic> toJson() {
    return {
      'itemCode': itemCode,
      'itemDesc': itemDesc,
      'itemUom': itemUom,
      'quantity': quantity,
      'totalAmount': totalAmount,
    };
  }
}
