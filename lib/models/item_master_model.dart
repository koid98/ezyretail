import 'package:ezyretail/helpers/sqflite_helper.dart';

class ItemMasterModel {
  String itemCode;
  String itemDesc;
  String itemDesc2;
  String itemUom;
  String baseUom;
  double uomRate;
  String itemGroup;
  String itemCategory;
  double? itemCost;
  double itemPrice;
  double itemPrice2;
  double itemPrice3;
  double itemPrice4;
  double itemPrice5;
  double itemPrice6;
  double memberPrice;
  int itemStatus;
  bool? isTempItem;
  String? itemType;
  bool? isBatchItem;
  bool? isSerialItem;
  String? lastModified;
  String? itemImage;
  int? uomCount;
  String? classification;
  String? taxCode;
  String? tariff;

  ItemMasterModel({
    required this.itemCode,
    required this.itemDesc,
    required this.itemDesc2,
    required this.itemUom,
    required this.baseUom,
    required this.uomRate,
    required this.itemGroup,
    required this.itemCategory,
    required this.itemCost,
    required this.itemPrice,
    required this.itemPrice2,
    required this.itemPrice3,
    required this.itemPrice4,
    required this.itemPrice5,
    required this.itemPrice6,
    required this.memberPrice,
    required this.itemStatus,
    required this.isTempItem,
    required this.itemType,
    required this.isBatchItem,
    required this.isSerialItem,
    required this.lastModified,
    this.itemImage,
    this.uomCount,
    this.classification,
    this.taxCode,
    this.tariff,
  });

  factory ItemMasterModel.fromJson(Map<String, dynamic> json) =>
      ItemMasterModel(
        itemCode: json["ITEMCODE"],
        itemDesc: json["DESCRIPTION"],
        itemDesc2: json["DESC2"] ?? "",
        itemUom: json["UOM"],
        baseUom: json["BASEUOM"],
        uomRate: json["RATE"],
        itemGroup: json["ITEMGROUP"] ?? "",
        itemCategory: json["ITEMCATEGORY"] ?? "",
        itemCost: json["ITEMCOST"] ?? 0.0,
        itemPrice: json["PRICE"],
        itemPrice2: json["PRICE2"],
        itemPrice3: json["PRICE3"],
        itemPrice4: json["PRICE4"],
        itemPrice5: json["PRICE5"],
        itemPrice6: json["PRICE6"],
        memberPrice: json["MEMBERPRICE"] ?? 0.0,
        itemStatus: json["STATUS"] ?? 1,
        isTempItem: false,
        itemType: "",
        isBatchItem: false,
        isSerialItem: false,
        lastModified: "",
      );

  factory ItemMasterModel.fromCloud(Map<String, dynamic> json) =>
      ItemMasterModel(
        itemCode: json["item_code"],
        itemDesc: json["item_desc"],
        itemDesc2: json["item_desc2"] ?? "",
        itemUom: json["item_uom"],
        baseUom: json["base_uom"],
        uomRate: double.parse((json["uom_rate"] ?? 0.0).toString()),
        itemGroup: json["item_group"] ?? "",
        itemCategory: json["item_category"] ?? "",
        itemCost: double.parse((json["item_cost"] ?? 0.0).toString()),
        itemPrice: double.parse((json["item_price"] ?? 0.0).toString()),
        itemPrice2: double.parse((json["item_price2"] ?? 0.0).toString()),
        itemPrice3: double.parse((json["item_price3"] ?? 0.0).toString()),
        itemPrice4: double.parse((json["item_price4"] ?? 0.0).toString()),
        itemPrice5: double.parse((json["item_price5"] ?? 0.0).toString()),
        itemPrice6: double.parse((json["item_price6"] ?? 0.0).toString()),
        memberPrice: double.parse((json["member_price"] ?? 0.0).toString()),
        itemStatus: int.parse((json["item_status"] ?? 1).toString()),
        isTempItem: false,
        itemType: "",
        isBatchItem: false,
        isSerialItem: false,
        lastModified: "",
      );

  factory ItemMasterModel.fromDefault() => ItemMasterModel(
    itemCode: "",
    itemDesc: "",
    itemDesc2: "",
    itemUom: "",
    baseUom: "",
    uomRate: 1,
    itemGroup: "",
    itemCategory: "",
    itemCost: 0.0,
    itemPrice: 0.0,
    itemPrice2: 0.0,
    itemPrice3: 0.0,
    itemPrice4: 0.0,
    itemPrice5: 0.0,
    itemPrice6: 0.0,
    memberPrice: 0.0,
    itemStatus: 1,
    isTempItem: true,
    itemType: "",
    isBatchItem: false,
    isSerialItem: false,
    lastModified: "",
  );

  factory ItemMasterModel.fromDB(Map<String, dynamic> json) => ItemMasterModel(
    itemCode: json[DatabaseHelper.itemCode],
    itemDesc: json[DatabaseHelper.itemDesc],
    itemDesc2: json[DatabaseHelper.itemDesc2] ?? "",
    itemUom: json[DatabaseHelper.itemUom],
    baseUom: json[DatabaseHelper.baseUom],
    uomRate: json[DatabaseHelper.uomQTY],
    itemGroup: json[DatabaseHelper.itemGroup] ?? "",
    itemCategory: json[DatabaseHelper.itemCategory] ?? "",
    itemCost: json[DatabaseHelper.itemCost] ?? 0.0,
    itemPrice: json[DatabaseHelper.itemPrice],
    itemPrice2: json[DatabaseHelper.itemPrice2],
    itemPrice3: json[DatabaseHelper.itemPrice3],
    itemPrice4: json[DatabaseHelper.itemPrice4],
    itemPrice5: json[DatabaseHelper.itemPrice5],
    itemPrice6: json[DatabaseHelper.itemPrice6],
    memberPrice: json[DatabaseHelper.memberPrice] ?? 0.0,
    itemStatus: json[DatabaseHelper.itemStatus] ?? 1,
    isTempItem: json[DatabaseHelper.tempItem] == 1 ? true : false,
    itemType: json[DatabaseHelper.itemType] ?? "",
    isBatchItem: json[DatabaseHelper.isBatch] == 1 ? true : false,
    isSerialItem: json[DatabaseHelper.isSerial] == 1 ? true : false,
    lastModified: json[DatabaseHelper.lastModified] ?? "",
    itemImage: json[DatabaseHelper.itemImage] ?? "",
    uomCount: json["UomCount"] ?? 0,
    classification: json[DatabaseHelper.classification] ?? "",
    taxCode: json[DatabaseHelper.taxCode] ?? "",
    tariff: json[DatabaseHelper.tariff] ?? "",
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.itemCode: itemCode,
      DatabaseHelper.itemDesc: itemDesc,
      DatabaseHelper.itemDesc2: itemDesc2,
      DatabaseHelper.itemUom: itemUom,
      DatabaseHelper.baseUom: baseUom,
      DatabaseHelper.uomQTY: uomRate,
      DatabaseHelper.itemGroup: itemGroup,
      DatabaseHelper.itemCategory: itemCategory,
      DatabaseHelper.itemCost: itemCost,
      DatabaseHelper.itemPrice: itemPrice,
      DatabaseHelper.itemPrice2: itemPrice2,
      DatabaseHelper.itemPrice3: itemPrice3,
      DatabaseHelper.itemPrice4: itemPrice4,
      DatabaseHelper.itemPrice5: itemPrice5,
      DatabaseHelper.itemPrice6: itemPrice6,
      DatabaseHelper.memberPrice: memberPrice,
      DatabaseHelper.itemStatus: itemStatus,
      DatabaseHelper.tempItem: isTempItem == true ? 1 : 0,
      DatabaseHelper.itemType: itemType,
      DatabaseHelper.isBatch: isBatchItem == true ? 1 : 0,
      DatabaseHelper.isSerial: isSerialItem == true ? 1 : 0,
      DatabaseHelper.lastModified: lastModified,
      DatabaseHelper.classification: classification,
      DatabaseHelper.taxCode: taxCode,
      DatabaseHelper.tariff: tariff,
    };
  }
}

class StockItemModel {
  String Code;
  String Description;
  String Description2;
  String OutPutTax;
  String Tariff;
  String IrbClassification;
  bool StockControl;
  bool IsActive;
  List<StockUomModel> ItemUOMList;
  List<StockBarcode> ItemBarcodeList;

  StockItemModel({
    required this.Code,
    required this.Description,
    required this.Description2,
    required this.Tariff,
    required this.OutPutTax,
    required this.IrbClassification,
    required this.StockControl,
    required this.IsActive,
    required this.ItemUOMList,
    required this.ItemBarcodeList,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Code"] = Code;
    data["Description"] = Description;
    data["Description2"] = Description2;
    data["OutPutTax"] = OutPutTax;
    data["Tariff"] = Tariff;
    data["IrbClassification"] = IrbClassification;
    data["StockControl"] = StockControl;
    data["IsActive"] = IsActive;
    data["ItemUOMList"] =
        ItemUOMList.map((details) => details.toJson()).toList();
    data["ItemBarcodeList"] =
        ItemBarcodeList.map((details) => details.toJson()).toList();
    return data;
  }
}

class StockUomModel {
  String UOM;
  double Rate;
  double RefCost;
  double RefPrice;
  bool IsBase;

  StockUomModel({
    required this.UOM,
    required this.Rate,
    required this.RefCost,
    required this.RefPrice,
    required this.IsBase,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["UOM"] = UOM;
    data["Rate"] = Rate;
    data["RefCost"] = RefCost;
    data["RefPrice"] = RefPrice;
    data["IsBase"] = IsBase;
    return data;
  }
}

class StockBarcode {
  String Barcode;
  String UOM;

  StockBarcode({
    required this.Barcode,
    required this.UOM,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["Barcode"] = Barcode;
    data["UOM"] = UOM;
    return data;
  }
}

class ItemUom {
  String itemUom;
  double uomRate;
  double itemPrice;

  ItemUom({
    required this.itemUom,
    required this.uomRate,
    required this.itemPrice,
  });

  ItemUom copyWith({
    String? itemUom,
    double? uomRate,
    double? itemPrice,
  }) =>
      ItemUom(
        itemUom: itemUom ?? this.itemUom,
        uomRate: uomRate ?? this.uomRate,
        itemPrice: itemPrice ?? this.itemPrice,
      );
}
