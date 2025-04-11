class MemberServerModel {
  String servId;
  String compId;
  String servUrl;
  String publicKey;
  String privateKey;
  bool isactive;

  MemberServerModel({
    required this.servId,
    required this.compId,
    required this.servUrl,
    required this.publicKey,
    required this.privateKey,
    required this.isactive,
  });

  factory MemberServerModel.fromJson(Map<String, dynamic> json) =>
      MemberServerModel(
        servId: json["serv_id"] ?? "",
        compId: json["comp_id"] ?? "",
        servUrl: json["serv_url"] ?? "",
        publicKey: json["public_key"] ?? "",
        privateKey: json["private_key"] ?? "",
        isactive: json["isactive"] ?? false,
      );

  Map<String, dynamic> toJson(MemberServerModel memberServerSettings) => {
    "serv_id": servId,
    "comp_id": compId,
    "serv_url": servUrl,
    "public_key": publicKey,
    "private_key": privateKey,
    "isactive": isactive,
  };
}

class MemberPointSettings {
  int id;
  int earnPoint;
  int earnPrice;
  int redeemPoint;
  int redeemPrice;
  int roundingMethod;

  MemberPointSettings({
    required this.id,
    required this.earnPoint,
    required this.earnPrice,
    required this.redeemPoint,
    required this.redeemPrice,
    required this.roundingMethod,
  });

  factory MemberPointSettings.fromHost(Map<String, dynamic> json) =>
      MemberPointSettings(
        id: json["id"] ?? 0,
        earnPoint: int.parse((json["earn_point"] ?? "0").toString()),
        earnPrice: int.parse((json["earn_price"] ?? "0").toString()),
        redeemPoint: int.parse((json["redeem_point"] ?? "0").toString()),
        redeemPrice: int.parse((json["redeem_price"] ?? "0").toString()),
        roundingMethod: int.parse((json["rounding_method"] ?? "0").toString()),
      );

  factory MemberPointSettings.fromJson(Map<String, dynamic> json) =>
      MemberPointSettings(
        id: json["id"] ?? 0,
        earnPoint: json["earnPoint"] ?? 0,
        earnPrice: json["earnPrice"] ?? 0,
        redeemPoint: json["redeemPoint"] ?? 0,
        redeemPrice: json["redeemPrice"] ?? 0,
        roundingMethod: json["roundingMethod"] ?? 0,
      );

  Map<String, dynamic> toJson(MemberPointSettings memberPointSettings) => {
    "id": id,
    "earnPoint": earnPoint,
    "earnPrice": earnPrice,
    "redeemPoint": redeemPoint,
    "redeemPrice": redeemPrice,
    "roundingMethod": roundingMethod,
  };
}
