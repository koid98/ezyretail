import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dart_ping/dart_ping.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../globals.dart';

String generateRandomString(int lengthOfString) {
  final random = Random();
  const allChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  // below statement will generate a random string of length using the characters
  // and length provided to it
  final randomString = List.generate(
      lengthOfString, (index) => allChars[random.nextInt(allChars.length)])
      .join();
  return randomString; // return the generated string
}

String generateRandomNumber(int lengthOfString) {
  final random = Random();
  const allChars = '1234567890';
  // below statement will generate a random string of length using the characters
  // and length provided to it
  final randomString = List.generate(
      lengthOfString, (index) => allChars[random.nextInt(allChars.length)])
      .join();
  return randomString; // return the generated string
}

Decimal customRounding(Decimal y) {
  Decimal result = Decimal.fromInt(0);
  Decimal value = y >= Decimal.zero ? Decimal.one : Decimal.fromInt(-1);
  y = y * value;
  Decimal RM;
  Decimal sen;
  Decimal sen1;
  Decimal sen2;
  Decimal sentb1 = Decimal.fromInt(cent1);
  Decimal sentb2 = Decimal.fromInt(cent2);
  Decimal sentb3 = Decimal.fromInt(cent3);
  Decimal sentb4 = Decimal.fromInt(cent4);
  Decimal sentb5 = Decimal.fromInt(cent5);
  Decimal sentb6 = Decimal.fromInt(cent6);
  Decimal sentb7 = Decimal.fromInt(cent7);
  Decimal sentb8 = Decimal.fromInt(cent8);
  Decimal sentb9 = Decimal.fromInt(cent9);

  RM = y.truncate();
  sen = y - RM;

  sen = sen * Decimal.fromInt(10);
  sen1 = sen.truncate();

  sen2 = (sen * Decimal.fromInt(10)) - (sen1 * Decimal.fromInt(10));
  sen2 = ((sen2.round()) / Decimal.fromInt(100)).toDecimal();
  sen1 = (sen1 / Decimal.fromInt(10)).toDecimal();

  if (sen2 == Decimal.parse("0.01")) {
    result = RM + sen1 + (sentb1 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.02")) {
    result = RM + sen1 + (sentb2 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.03")) {
    result = RM + sen1 + (sentb3 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.04")) {
    result = RM + sen1 + (sentb4 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.05")) {
    result = RM + sen1 + (sentb5 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.06")) {
    result = RM + sen1 + (sentb6 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.07")) {
    result = RM + sen1 + (sentb7 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.08")) {
    result = RM + sen1 + (sentb8 / Decimal.fromInt(100)).toDecimal();
  } else if (sen2 == Decimal.parse("0.09")) {
    result = RM + sen1 + (sentb9 / Decimal.fromInt(100)).toDecimal();
  } else {
    result = y;
  }

  return result * value;
}

int calMemberEarnPoint(double priceValue) {
  int result = 0;

  int ezyEarnPoint = ezyMemberEarnPoint;
  int ezyEarnPrice = ezyMemberEarnPrice;
  int ezyRounding = ezyMemberRoundingMethod;

  double tmpValue =
      priceValue / ezyEarnPrice.toDouble() * ezyEarnPoint.toDouble();

  // 1 - Normal Rounding
  // 2 - Round Up
  // 3 - Round Down
  // 4 - No Rounding

  switch (ezyRounding) {
    case 2:
      result = tmpValue.ceil();
      break;
    case 3:
      result = tmpValue.floor();
      break;
    case 4:
      result = tmpValue.truncate();
      break;
    default:
      result = tmpValue.round();
  }

  return result;
}

double calMemberRedeemValue(int memberPoint) {
  double result = 0.0;

  int ezyRedeemPoint = ezyMemberRedeemPoint;
  int ezyRedeemPrice = ezyMemberRedeemPrice;

  double tempValue = memberPoint / ezyRedeemPoint * ezyRedeemPrice;

  result = tempValue.toPrecision(2);

  return result;
}

bool isValidMacAddress(String mac) {
  // Define regex patterns for different MAC address formats
  final RegExp colonSeparated = RegExp(
    r'^([0-9A-Fa-f]{2}:){5}([0-9A-Fa-f]{2})$',
  );

  // Check if the input matches any of the patterns
  return colonSeparated.hasMatch(mac);
}

bool isValidIPv4(String ip) {
  final RegExp ipv4Regex = RegExp(
    r'^((25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)\.){3}(25[0-5]|2[0-4]\d|1\d{2}|[1-9]?\d)$',
  );
  return ipv4Regex.hasMatch(ip);
}

Future<bool> pingHostConnection(String host,
    {int count = 3, int timeout = 2}) async {
  int success = 0;
  final completer = Completer<bool>();

  final ping = Ping(
    host,
    count: count,
    interval: timeout,
    timeout: timeout,
  );

  ping.stream.listen((PingData data) {
    if (data.response != null) {
      success++;
    } else if (data.error != null) {
      // Handle individual ping errors if needed
    }
  }, onDone: () {
    completer.complete(success > 0);
  }, onError: (error) {
    completer.complete(false);
  });

  return completer.future;
}

Future<bool> validateEInvoice(
    String tmpKey, String tmpUrl, String tmpClient, String expDate) async {
  bool result = true;

  if (tmpKey.isEmpty || tmpUrl.isEmpty || tmpClient.isEmpty) {
    return false;
  }

  Uri uri = Uri.parse(tmpUrl);
  bool tmp = uri.hasScheme && (uri.isScheme('http') || uri.isScheme('https'));

  if (!tmp) {
    return false;
  }

  DateTime date1 = DateTime.now();
  DateTime date2 = systemShortDate.parse(expDate);

  if (date1.isAfter(date2)) {
    return false;
  }

  return result;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
