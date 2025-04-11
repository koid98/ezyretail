

import 'package:ezyretail/helpers/sqflite_helper.dart';

class ItemBarcodeModel {
  String itemCode;
  String barcode;
  String uom;

  ItemBarcodeModel({
    required this.itemCode,
    required this.barcode,
    required this.uom,
  });

  factory ItemBarcodeModel.fromJson(Map<String, dynamic> json) =>
      ItemBarcodeModel(
        itemCode: json["ITEMCODE"],
        barcode: json["BARCODE"],
        uom: json["UOM"],
      );

  factory ItemBarcodeModel.fromCloud(Map<String, dynamic> json) =>
      ItemBarcodeModel(
        itemCode: json["item_code"],
        barcode: json["barcode"],
        uom: json["item_uom"],
      );

  factory ItemBarcodeModel.fromDB(Map<String, dynamic> json) =>
      ItemBarcodeModel(
        itemCode: json[DatabaseHelper.itemCode],
        barcode: json[DatabaseHelper.itemBarcode],
        uom: json[DatabaseHelper.itemUom],
      );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.itemCode: itemCode,
      DatabaseHelper.itemBarcode: barcode,
      DatabaseHelper.itemUom: uom,
    };
  }
}
