import 'package:decimal/decimal.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:get/get.dart';

import '../globals.dart';

class PromotionModel {
  String promotionKey;
  int priority;
  String promotionCode;
  String description;
  int promotionType;
  DateTime fromDate;
  DateTime toDate;
  String fromTime;
  String toTime;
  int validDay1;
  int validDay2;
  int validDay3;
  int validDay4;
  int validDay5;
  int validDay6;
  int validDay7;
  int validNoneMember;
  int validBirthday;
  int validBirthdayMonth;
  List<ItemPromotion> itemPromotion;
  List<dynamic> promotionPwp;
  List<dynamic> promotionMm;

  PromotionModel({
    required this.promotionKey,
    required this.priority,
    required this.promotionCode,
    required this.description,
    required this.promotionType,
    required this.fromDate,
    required this.toDate,
    required this.fromTime,
    required this.toTime,
    required this.validDay1,
    required this.validDay2,
    required this.validDay3,
    required this.validDay4,
    required this.validDay5,
    required this.validDay6,
    required this.validDay7,
    required this.validNoneMember,
    required this.validBirthday,
    required this.validBirthdayMonth,
    required this.itemPromotion,
    required this.promotionPwp,
    required this.promotionMm,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemPromotionList = json['ItemPromotion'];
    List<ItemPromotion> itemPromotions =
    itemPromotionList.map((i) => ItemPromotion.fromJson(i)).toList();

    return PromotionModel(
      promotionKey: json["PROMOTIONKEY"],
      priority: json["PRIORITY"],
      promotionCode: json["PROMOTIONCODE"],
      description: json["DESCRIPTION"] ?? "",
      promotionType: json["PROMOTIONTYPE"],
      fromDate: DateTime.parse(json["FROMDATE"]),
      toDate: DateTime.parse(json["TODATE"]),
      fromTime: json["FROMTIME"] ?? "",
      toTime: json["TOTIME"] ?? "",
      validDay1: json["VALIDDAY1"] == "T" ? 1 : 0,
      validDay2: json["VALIDDAY2"] == "T" ? 1 : 0,
      validDay3: json["VALIDDAY3"] == "T" ? 1 : 0,
      validDay4: json["VALIDDAY4"] == "T" ? 1 : 0,
      validDay5: json["VALIDDAY5"] == "T" ? 1 : 0,
      validDay6: json["VALIDDAY6"] == "T" ? 1 : 0,
      validDay7: json["VALIDDAY7"] == "T" ? 1 : 0,
      validNoneMember: json["VALIDNONEMEMBER"] == "T" ? 1 : 0,
      validBirthday: json["VALIDBIRTHDAY"] == "T" ? 1 : 0,
      validBirthdayMonth: json["VALIDBIRTHDAYMONTH"] == "T" ? 1 : 0,
      itemPromotion: itemPromotions,
      promotionPwp: [],
      promotionMm: [],
    );
  }

  factory PromotionModel.fromCloud(Map<String, dynamic> json) {
    List<dynamic> itemPromotionList = json['promotion_item'];
    List<ItemPromotion> itemPromotions =
    itemPromotionList.map((i) => ItemPromotion.fromCloud(i)).toList();

    return PromotionModel(
      promotionKey: json["promotion_key"],
      priority: json["priority"],
      promotionCode: json["promotion_code"],
      description: json["promotion_desc"] ?? "",
      promotionType: json["promotion_type"],
      fromDate: DateTime.parse(json["start_date"]),
      toDate: DateTime.parse(json["expired_date"]),
      fromTime: json["from_time"],
      toTime: json["to_time"],
      validDay1: json["valid_day_1"],
      validDay2: json["valid_day_2"],
      validDay3: json["valid_day_3"],
      validDay4: json["valid_day_4"],
      validDay5: json["valid_day_5"],
      validDay6: json["valid_day_6"],
      validDay7: json["valid_day_7"],
      validNoneMember: json["valid_none_member"],
      validBirthday: json["valid_birthday"],
      validBirthdayMonth: json["valid_birthday_month"],
      itemPromotion: itemPromotions,
      promotionPwp: [],
      promotionMm: [],
    );
  }

  factory PromotionModel.fromDB(Map<String, dynamic> json) {
    return PromotionModel(
      promotionKey: json[DatabaseHelper.promotionKey],
      priority: json[DatabaseHelper.priority],
      promotionCode: json[DatabaseHelper.promotionCode],
      description: json[DatabaseHelper.description] ?? "",
      promotionType: json[DatabaseHelper.promotionType],
      fromDate: DateTime.parse(json[DatabaseHelper.fromDate]),
      toDate: DateTime.parse(json[DatabaseHelper.toDate]),
      fromTime: json[DatabaseHelper.fromTime] ?? "",
      toTime: json[DatabaseHelper.toTime] ?? "",
      validDay1: json[DatabaseHelper.validDay1],
      validDay2: json[DatabaseHelper.validDay2],
      validDay3: json[DatabaseHelper.validDay3],
      validDay4: json[DatabaseHelper.validDay4],
      validDay5: json[DatabaseHelper.validDay5],
      validDay6: json[DatabaseHelper.validDay6],
      validDay7: json[DatabaseHelper.validDay7],
      validNoneMember: json[DatabaseHelper.validNoneMember],
      validBirthday: json[DatabaseHelper.validBirthday],
      validBirthdayMonth: json[DatabaseHelper.validBirthdayMonth],
      itemPromotion: [],
      promotionPwp: [],
      promotionMm: [],
    );
  }

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.promotionKey: promotionKey,
      DatabaseHelper.priority: priority,
      DatabaseHelper.promotionCode: promotionCode,
      DatabaseHelper.description: description,
      DatabaseHelper.promotionType: promotionType,
      DatabaseHelper.fromDate: dbDateFormat.format(fromDate),
      DatabaseHelper.toDate: dbDateFormat.format(toDate),
      DatabaseHelper.fromTime: fromTime,
      DatabaseHelper.toTime: toTime,
      DatabaseHelper.validDay1: validDay1,
      DatabaseHelper.validDay2: validDay2,
      DatabaseHelper.validDay3: validDay3,
      DatabaseHelper.validDay4: validDay4,
      DatabaseHelper.validDay5: validDay5,
      DatabaseHelper.validDay6: validDay6,
      DatabaseHelper.validDay7: validDay7,
      DatabaseHelper.validNoneMember: validNoneMember,
      DatabaseHelper.validBirthday: validBirthday,
      DatabaseHelper.validBirthdayMonth: validBirthdayMonth,
    };
  }

  PromotionModel copyWith({
    String? promotionKey,
    int? priority,
    String? promotionCode,
    String? description,
    int? promotionType,
    DateTime? fromDate,
    DateTime? toDate,
    String? fromTime,
    String? toTime,
    int? validDay1,
    int? validDay2,
    int? validDay3,
    int? validDay4,
    int? validDay5,
    int? validDay6,
    int? validDay7,
    int? validNoneMember,
    int? validBirthday,
    int? validBirthdayMonth,
    List<ItemPromotion>? itemPromotion,
    List<dynamic>? promotionPwp,
    List<dynamic>? promotionMm,
  }) =>
      PromotionModel(
        promotionKey: promotionKey ?? this.promotionKey,
        priority: priority ?? this.priority,
        promotionCode: promotionCode ?? this.promotionCode,
        description: description ?? this.description,
        promotionType: promotionType ?? this.promotionType,
        fromDate: fromDate ?? this.fromDate,
        toDate: toDate ?? this.toDate,
        fromTime: fromTime ?? this.fromTime,
        toTime: toTime ?? this.toTime,
        validDay1: validDay1 ?? this.validDay1,
        validDay2: validDay2 ?? this.validDay2,
        validDay3: validDay3 ?? this.validDay3,
        validDay4: validDay4 ?? this.validDay4,
        validDay5: validDay5 ?? this.validDay5,
        validDay6: validDay6 ?? this.validDay6,
        validDay7: validDay7 ?? this.validDay7,
        validNoneMember: validNoneMember ?? this.validNoneMember,
        validBirthday: validBirthday ?? this.validBirthday,
        validBirthdayMonth: validBirthdayMonth ?? this.validBirthdayMonth,
        itemPromotion: itemPromotion ?? this.itemPromotion,
        promotionPwp: promotionPwp ?? this.promotionPwp,
        promotionMm: promotionMm ?? this.promotionMm,
      );
}

class PromotionInfo {
  String promotionKey;
  String promotionCode;
  int promotionType;
  int validNoneMember;

  PromotionInfo({
    required this.promotionKey,
    required this.promotionCode,
    required this.promotionType,
    required this.validNoneMember,
  });

  factory PromotionInfo.fromDB(Map<String, dynamic> json) => PromotionInfo(
    promotionKey: json[DatabaseHelper.promotionKey],
    promotionCode: json[DatabaseHelper.promotionCode],
    promotionType: json[DatabaseHelper.promotionType],
    validNoneMember: json[DatabaseHelper.validNoneMember],
  );
}

class ItemPromotion {
  String promotionKey;
  String itemCode;
  String uom;
  double minPurchaseQty;
  double maxPurchaseQty;
  double unitPrice;
  double discount;
  double promoPrice;

  ItemPromotion({
    required this.promotionKey,
    required this.itemCode,
    required this.uom,
    required this.minPurchaseQty,
    required this.maxPurchaseQty,
    required this.unitPrice,
    required this.discount,
    required this.promoPrice,
  });

  factory ItemPromotion.fromJson(Map<String, dynamic> json) => ItemPromotion(
    promotionKey: json["PROMOTIONKEY"],
    itemCode: json["ITEMCODE"],
    uom: json["UOM"] ?? "",
    minPurchaseQty:
    double.parse(json["MINPURCHASEQTY"].toString() ?? "0.0"),
    maxPurchaseQty:
    double.parse(json["MAXPURCHASEQTY"].toString() ?? "0.0"),
    unitPrice: json["UNITPRICE"] ?? 0.0,
    discount: json["DISCOUNT"] ?? 0.0,
    promoPrice: json["PROMOPRICE"] ?? 0.0,
  );

  factory ItemPromotion.fromCloud(Map<String, dynamic> json) {
    double unitPrice = double.parse((json["item_price"] ?? 0.0).toString())
        .toPrecision(unitPriceDecPlace);
    double promoPrice =
    double.parse((json["promotion_price"] ?? 0.0).toString())
        .toPrecision(unitPriceDecPlace);
    double minPurchaseQty =
    double.parse((json["min_purchase_quantity"] ?? 0.0).toString())
        .toPrecision(2)
        .toPrecision(2);
    double maxPurchaseQty =
    double.parse((json["max_purchase_quantity"] ?? 0.0).toString())
        .toPrecision(2);

    double promoDiscount = (unitPrice - promoPrice).toPrecision(2);

    return ItemPromotion(
      promotionKey: json["promotion_key"],
      itemCode: json["item_code"],
      uom: json["item_uom"] ?? "",
      minPurchaseQty: minPurchaseQty,
      maxPurchaseQty: maxPurchaseQty,
      unitPrice: unitPrice,
      discount: promoDiscount,
      promoPrice: promoPrice,
    );
  }

  factory ItemPromotion.fromDB(Map<String, dynamic> json) => ItemPromotion(
    promotionKey: json[DatabaseHelper.promotionKey],
    itemCode: json[DatabaseHelper.itemCode],
    uom: json[DatabaseHelper.uom] ?? "",
    minPurchaseQty:
    Decimal.parse(json[DatabaseHelper.minPurchaseQty].toString())
        .toDouble(),
    maxPurchaseQty:
    Decimal.parse(json[DatabaseHelper.maxPurchaseQty].toString())
        .toDouble(),
    unitPrice:
    Decimal.parse(json[DatabaseHelper.unitPrice].toString()).toDouble(),
    discount:
    Decimal.parse(json[DatabaseHelper.discount].toString()).toDouble(),
    promoPrice: Decimal.parse(json[DatabaseHelper.promoPrice].toString())
        .toDouble(),
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.promotionKey: promotionKey,
      DatabaseHelper.itemCode: itemCode,
      DatabaseHelper.uom: uom,
      DatabaseHelper.minPurchaseQty: minPurchaseQty,
      DatabaseHelper.maxPurchaseQty: maxPurchaseQty,
      DatabaseHelper.unitPrice: unitPrice,
      DatabaseHelper.discount: discount,
      DatabaseHelper.promoPrice: promoPrice,
    };
  }
}
