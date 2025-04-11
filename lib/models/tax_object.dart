import 'package:ezyretail/helpers/sqflite_helper.dart';

class TaxObject {
  String taxCode;
  String taxDesc;
  String taxRate;
  String tariffCode;
  bool taxIncl;
  bool defaultTax;

  TaxObject({
    required this.taxCode,
    required this.taxDesc,
    required this.taxRate,
    required this.tariffCode,
    required this.taxIncl,
    required this.defaultTax,
  });

  factory TaxObject.fromJson(Map<String, dynamic> json) => TaxObject(
    taxCode: json["tax_code"],
    taxDesc: json["tax_desc"],
    taxRate: json["tax_rate"],
    tariffCode: json["tariff"],
    taxIncl: json["tax_inclusive"] ?? "F" == "T",
    defaultTax: json["tax_default"] ?? "F" == "T",
  );

  factory TaxObject.fromDB(Map<String, dynamic> json) => TaxObject(
    taxCode: json[DatabaseHelper.taxCode],
    taxDesc: json[DatabaseHelper.taxDesc],
    taxRate: json[DatabaseHelper.taxRate],
    tariffCode: json[DatabaseHelper.tariffCode],
    taxIncl: json[DatabaseHelper.taxIncl] == 1,
    defaultTax: json[DatabaseHelper.defaultTax] == 1,
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.taxCode: taxCode,
      DatabaseHelper.taxDesc: taxDesc,
      DatabaseHelper.taxRate: taxRate,
      DatabaseHelper.tariffCode: tariffCode,
      DatabaseHelper.taxIncl: taxIncl ? 1 : 0,
      DatabaseHelper.defaultTax: defaultTax ? 1 : 0,
    };
  }
}
