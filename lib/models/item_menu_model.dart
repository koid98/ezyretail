import 'package:ezyretail/helpers/sqflite_helper.dart';

class ItemMenuModel {
  String headerId;
  String menuId;
  int menuSeq;
  String itemType;
  String itemCode;
  String itemDesc;
  String itemUom;
  String textColor;
  String baseColor;
  bool weightItem;
  String? itemImg;

  ItemMenuModel({
    required this.headerId,
    required this.menuId,
    required this.menuSeq,
    required this.itemType,
    required this.itemCode,
    required this.itemDesc,
    required this.itemUom,
    required this.textColor,
    required this.baseColor,
    required this.weightItem,
    this.itemImg,
  });

  factory ItemMenuModel.fromJson(Map<String, dynamic> json) => ItemMenuModel(
    headerId: json["HeaderId"],
    menuId: json["MenuId"],
    menuSeq: json["MenuSeq"],
    itemType: json["ItemType"],
    itemCode: json["ItemCode"],
    itemDesc: json["ItemDesc"],
    itemUom: json["ItemUom"],
    textColor: json["TextColor"],
    baseColor: json["BaseColor"],
    weightItem: json["WeightItem"],
  );

  factory ItemMenuModel.fromCloud(Map<String, dynamic> json) => ItemMenuModel(
    headerId: json["menu_header_id"],
    menuId: json["menu_id"],
    menuSeq: int.parse((json["menu_seq"] ?? 1).toString()),
    itemType: json["item_type"],
    itemCode: json["item_code"],
    itemDesc: json["item_desc"],
    itemUom: json["item_uom"],
    textColor: "#FFFFFF",
    baseColor: "#4E6D9C",
    weightItem: json["is_weight_item"] == "1",
  );

  factory ItemMenuModel.fromDB(Map<String, dynamic> json) => ItemMenuModel(
    headerId: json[DatabaseHelper.headerId],
    menuId: json[DatabaseHelper.menuId],
    menuSeq: json[DatabaseHelper.menuSeq],
    itemType: json[DatabaseHelper.itemType],
    itemCode: json[DatabaseHelper.itemCode],
    itemDesc: json[DatabaseHelper.itemDesc],
    itemUom: json[DatabaseHelper.itemUom],
    textColor: json[DatabaseHelper.textColor] ?? "#FFFFFF",
    baseColor: json[DatabaseHelper.baseColor] ?? '#4E6D9C',
    weightItem: json[DatabaseHelper.isWeightItem] == 1,
    itemImg: json[DatabaseHelper.itemImage] ?? "",
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.headerId: headerId,
      DatabaseHelper.menuId: menuId,
      DatabaseHelper.menuSeq: menuSeq,
      DatabaseHelper.itemType: itemType,
      DatabaseHelper.itemCode: itemCode,
      DatabaseHelper.itemDesc: itemDesc,
      DatabaseHelper.itemUom: itemUom,
      DatabaseHelper.textColor: textColor,
      DatabaseHelper.baseColor: baseColor,
      DatabaseHelper.isWeightItem: weightItem,
    };
  }
}
