import 'dart:collection';
import 'dart:io';

import 'package:decimal/decimal.dart';
import 'package:ezyretail/modules/general_function.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as globals;

Map<String, dynamic> sortJson(Map<String, dynamic> json) {
  // 对entries进行排序
  List<MapEntry<String, dynamic>> sortedEntries = json.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key));

  // 创建有序的Map
  LinkedHashMap<String, dynamic> sortedMap =
  LinkedHashMap.fromEntries(sortedEntries);

  return sortedMap;
}

Decimal customRounding(Decimal y) {
  Decimal result = Decimal.fromInt(0);
  Decimal value = y >= Decimal.zero ? Decimal.one : Decimal.fromInt(-1);
  y = y * value;
  Decimal RM;
  Decimal sen;
  Decimal sen1;
  Decimal sen2;
  Decimal sentb1 = Decimal.fromInt(0);
  Decimal sentb2 = Decimal.fromInt(0);
  Decimal sentb3 = Decimal.fromInt(0);
  Decimal sentb4 = Decimal.fromInt(5);
  Decimal sentb5 = Decimal.fromInt(5);
  Decimal sentb6 = Decimal.fromInt(5);
  Decimal sentb7 = Decimal.fromInt(5);
  Decimal sentb8 = Decimal.fromInt(10);
  Decimal sentb9 = Decimal.fromInt(10);

  RM = y.truncate();
  sen = y - RM;

  sen = sen * Decimal.fromInt(10);
  sen1 = sen.truncate();

  sen2 = (sen * Decimal.fromInt(10)) - (sen1 * Decimal.fromInt(10));
  sen2 = ((sen2.round()) / Decimal.fromInt(100)).toDecimal();
  sen1 = (sen1 / Decimal.fromInt(10)).toDecimal();

  if (sen2 == Decimal.parse('0.01')) {
    result = RM + sen1 + (sentb1 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.02')) {
    result = RM + sen1 + (sentb2 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.03')) {
    result = RM + sen1 + (sentb3 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.04')) {
    result = RM + sen1 + (sentb4 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.05')) {
    result = RM + sen1 + (sentb5 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.06')) {
    result = RM + sen1 + (sentb6 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.07')) {
    result = RM + sen1 + (sentb7 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.08')) {
    result = RM + sen1 + (sentb8 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse('0.09')) {
    result = RM + sen1 + (sentb9 / Decimal.fromInt(100)).toDecimal();
  } else {
    result = y;
  }

  return result * value;
}

List<double> customRounding2(double y) {
  double result = 0;
  double carry = 0; // 累积进位
  double RM;
  double sen;
  double sen1;
  double sen2;
  double sentb1 = 0;
  double sentb2 = 0;
  double sentb3 = 5;
  double sentb4 = 5;
  double sentb5 = 5;
  double sentb6 = 5;
  double sentb7 = 5;
  double sentb8 = 10;
  double sentb9 = 10;

  RM = y.truncateToDouble();
  sen = y - RM;

  sen = sen * 10;
  sen1 = sen.truncateToDouble();

  sen2 = (sen * 10) - (sen1 * 10);
  sen2 = (sen2.round()) / 100;
  sen1 = sen1 / 10;

  if (sen2 == 0.01) {
    result = RM + sen1 + (sentb1 / 100);
    carry += sentb1;
  } else if (sen2 == 0.02) {
    result = RM + sen1 + (sentb2 / 100);
    carry += sentb2;
  } else if (sen2 == 0.03) {
    result = RM + sen1 + (sentb3 / 100);
    carry += sentb3;
  } else if (sen2 == 0.04) {
    result = RM + sen1 + (sentb4 / 100);
    carry += sentb4;
  } else if (sen2 == 0.05) {
    result = RM + sen1 + (sentb5 / 100);
    carry += sentb5;
  } else if (sen2 == 0.06) {
    result = RM + sen1 + (sentb6 / 100);
    carry += sentb6;
  } else if (sen2 == 0.07) {
    result = RM + sen1 + (sentb7 / 100);
    carry += sentb7;
  } else if (sen2 == 0.08) {
    result = RM + sen1 + (sentb8 / 100);
    carry += sentb8;
  } else if (sen2 == 0.09) {
    result = RM + sen1 + (sentb9 / 100);
    carry += sentb9;
  } else {
    result = y;
  }

  return [result, carry];
}

Future<void> saveCsvToFile(String csvString, String fileName) async {
  // Get the document directory path
  final directory = await getApplicationDocumentsDirectory();
  final path = directory.path;
  Directory documentsDirectory = Directory("storage/emulated/0/Download/");
  // Create a file and write the CSV string to it
  final file = File('$documentsDirectory/$fileName.csv');
  await file.writeAsString(csvString);
}

String currencyString(amount) {
  if (amount.runtimeType != Decimal) {
    amount = Decimal.parse(amount.toString());
  }

  return globals.currencyPosition == globals.CurrencyPosition.left
      ? '${globals.currencySymbol} ${formatDecimalWithTwoDecimalPlaces(amount)}'
      : '${formatDecimalWithTwoDecimalPlaces(amount)} ${globals.currencySymbol}';
}

String formatDecimalWithTwoDecimalPlaces(Decimal number) {
  String numberString = number.toString();
  int decimalIndex = numberString.indexOf('.');

  // 检查小数点的位置和小数位数
  if (decimalIndex == -1) {
    // 没有小数点，追加 ".00" 表示两位小数
    return '$numberString.00';
  } else if (numberString.length - decimalIndex - 1 < 2) {
    // 小数位数少于两位，在末尾补齐零
    return '$numberString${'0' * (2 - (numberString.length - decimalIndex - 1))}';
  }

  // 已经有两位或更多小数位数，直接返回原始字符串
  return numberString;
}

Future<String> generateAppId() async {
  final prefs = await SharedPreferences.getInstance();
  String tempDeviceId = prefs.getString("MachineId") ?? "";

  if (tempDeviceId == "") {
    tempDeviceId =
    'EZYPOS-${generateRandomString(8).toUpperCase()}-${generateRandomNumber(6).toUpperCase()}';
    prefs.setString("MachineId", tempDeviceId);
  }

  return tempDeviceId;
}

Future<String> reGenerateAppId() async {
  final prefs = await SharedPreferences.getInstance();
  String tempDeviceId = prefs.getString("MachineId") ?? "";

  tempDeviceId =
  'EZYPOS-${generateRandomString(8).toUpperCase()}-${generateRandomNumber(6).toUpperCase()}';
  prefs.setString("MachineId", tempDeviceId);

  return tempDeviceId;
}

bool validateEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}
