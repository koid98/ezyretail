
import 'package:ezyretail/helpers/sqflite_helper.dart';

class PaymentMethodModel {
  String code;
  String description;
  int paymentType;
  bool rReference;
  bool rDrawer;
  String storeId;
  String clientId;
  String clientKey;
  String privateKey;
  String publicKey;
  bool useTerminal;
  String terminalKey;
  bool useCreditCard;
  bool useQrPay;
  String refundPin;
  String textColor;
  String baseColor;
  bool withImage;
  String imgString;

  PaymentMethodModel({
    required this.code,
    required this.description,
    required this.paymentType,
    required this.rReference,
    required this.rDrawer,
    required this.storeId,
    required this.clientId,
    required this.clientKey,
    required this.privateKey,
    required this.publicKey,
    required this.useTerminal,
    required this.terminalKey,
    required this.useCreditCard,
    required this.useQrPay,
    required this.refundPin,
    required this.textColor,
    required this.baseColor,
    required this.withImage,
    required this.imgString,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodModel(
        code: json["code"],
        description: json["description"] ?? "",
        paymentType: json["paymentType"],
        rReference: json["r_reference"] ?? false,
        rDrawer: json["r_drawer"] ?? false,
        storeId: json["store_id"] ?? "",
        clientId: json["client_id"] ?? "",
        clientKey: json["client_key"] ?? "",
        privateKey: json["private_key"] ?? "",
        publicKey: json["public_key"] ?? "",
        useTerminal: json["use_terminal"] ?? false,
        terminalKey: json["terminal_key"] ?? "",
        useCreditCard: json["useCreditCard"] ?? false,
        useQrPay: json["useQrPay"] ?? false,
        refundPin: json["refund_pin"] ?? "",
        textColor: json["textColor"],
        baseColor: json["baseColor"],
        withImage: json["withImage"] ?? false,
        imgString: "",
      );

  factory PaymentMethodModel.fromCloud(Map<String, dynamic> json) =>
      PaymentMethodModel(
        code: json["payment_code"],
        description: json["payment_desc"] ?? "",
        paymentType: int.parse((json["payment_type"] ?? 0).toString()),
        rReference: int.parse((json["require_reference"] ?? 0).toString()) == 1,
        rDrawer: int.parse((json["is_open_drawer"] ?? 0).toString()) == 1,
        storeId: json["store_id"] ?? "",
        clientId: json["client_id"] ?? "",
        clientKey: json["client_secret_key"] ?? "",
        privateKey: json["private_key"] ?? "",
        publicKey: json["public_key"] ?? "",
        useTerminal: int.parse((json["is_terminal"] ?? 0).toString()) == 1,
        terminalKey: json["terminal_id"] ?? "",
        useCreditCard: false,
        useQrPay: false,
        refundPin: json["refund_pin"] ?? "",
        textColor: json["textColor"] ?? "#FFFFFF",
        baseColor: json["baseColor"] ?? "#4E6D9C",
        withImage: json["payment_image"] != "",
        imgString: json["payment_image"],
      );

  factory PaymentMethodModel.fromDB(Map<String, dynamic> json) =>
      PaymentMethodModel(
        code: json[DatabaseHelper.paymentCode],
        description: json[DatabaseHelper.paymentDescription] ?? "",
        paymentType: json[DatabaseHelper.paymentType] ?? 0,
        rReference: json[DatabaseHelper.paymentNeedRef] == 1,
        rDrawer: json[DatabaseHelper.paymentOpenDrawer] == 1,
        storeId: json[DatabaseHelper.storeId] ?? "",
        clientId: json[DatabaseHelper.clientId] ?? "",
        clientKey: json[DatabaseHelper.clientKey] ?? "",
        privateKey: json[DatabaseHelper.privateKey] ?? "",
        publicKey: json[DatabaseHelper.publicKey] ?? "",
        useTerminal: json[DatabaseHelper.useTerminal] == 1,
        terminalKey: json[DatabaseHelper.terminalId] ?? "",
        useCreditCard: json[DatabaseHelper.usedCreditCard] == 1,
        useQrPay: json[DatabaseHelper.usedEWallet] == 1,
        refundPin: json[DatabaseHelper.refundPin] ?? "",
        textColor: json[DatabaseHelper.textColor] ?? "",
        baseColor: json[DatabaseHelper.baseColor] ?? "",
        withImage: false,
        imgString: json[DatabaseHelper.paymentImage] ?? "",
      );

  PaymentMethodModel copyWith({
    String? code,
    String? description,
    int? paymentType,
    bool? rReference,
    bool? rDrawer,
    String? storeId,
    String? clientId,
    String? clientKey,
    String? privateKey,
    String? publicKey,
    bool? useTerminal,
    String? terminalKey,
    bool? useCreditCard,
    bool? useQrPay,
    String? refundPin,
    String? textColor,
    String? baseColor,
    bool? withImage,
    String? imgString,
  }) =>
      PaymentMethodModel(
        code: code ?? this.code,
        description: description ?? this.description,
        paymentType: paymentType ?? this.paymentType,
        rReference: rReference ?? this.rReference,
        rDrawer: rDrawer ?? this.rDrawer,
        storeId: storeId ?? this.storeId,
        clientId: clientId ?? this.clientId,
        clientKey: clientKey ?? this.clientKey,
        privateKey: privateKey ?? this.privateKey,
        publicKey: publicKey ?? this.publicKey,
        useTerminal: useTerminal ?? this.useTerminal,
        terminalKey: terminalKey ?? this.terminalKey,
        useCreditCard: useCreditCard ?? this.useCreditCard,
        useQrPay: useQrPay ?? this.useQrPay,
        refundPin: refundPin ?? this.refundPin,
        textColor: textColor ?? this.textColor,
        baseColor: baseColor ?? this.baseColor,
        withImage: withImage ?? this.withImage,
        imgString: imgString ?? this.imgString,
      );
}
