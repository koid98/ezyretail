class SecondScreenHeader {
  double subtotal;
  String authorizeUserKey;
  List<SecondScreenDetails> salesDetails;

  SecondScreenHeader({
    required this.subtotal,
    required this.authorizeUserKey,
    required this.salesDetails,
  });

  factory SecondScreenHeader.fromInitValue() => SecondScreenHeader(
    subtotal: 0.0,
    authorizeUserKey: "",
    salesDetails: [],
  );

  factory SecondScreenHeader.fromJson(Map<String, dynamic> json) =>
      SecondScreenHeader(
        subtotal: json['subtotal'] ?? 0.0,
        authorizeUserKey: json['authorizeUserKey'] ?? "",
        salesDetails: json['salesDetails'] ?? [],
      );

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "authorizeUserKey": authorizeUserKey,
    "salesDetails": salesDetails,
  };
}

class SecondScreenCounterInfo {
  String companyName;
  String userName;
  String customerCode;
  String customerName;

  SecondScreenCounterInfo({
    required this.companyName,
    required this.userName,
    required this.customerCode,
    required this.customerName,
  });
}

class SecondScreenDetails {
  String salesDetailKey;
  String salesKey;
  String invoiceDoc;
  String itemCode;
  String itemDesc;
  String itemDesc2;
  double quantity;
  double price;
  double totalAmount;
  String uom;
  double discountValue;
  int discountPercent;
  int isDiscountInPercent;
  String taxCode;
  double taxAmount;
  int taxRate;
  String fromSalesKey;
  String fromSalesDetailKey;
  String promotionKey;
  String promotionType;
  String promotionDetailKey;
  double promotionDiscount;
  String itemImage;

  SecondScreenDetails(
      {required this.salesDetailKey,
        required this.salesKey,
        required this.invoiceDoc,
        required this.itemCode,
        required this.itemDesc,
        required this.itemDesc2,
        required this.quantity,
        required this.price,
        required this.totalAmount,
        required this.uom,
        required this.discountValue,
        required this.discountPercent,
        required this.isDiscountInPercent,
        required this.taxCode,
        required this.taxAmount,
        required this.taxRate,
        required this.fromSalesKey,
        required this.fromSalesDetailKey,
        required this.promotionKey,
        required this.promotionType,
        required this.promotionDetailKey,
        required this.promotionDiscount,
        required this.itemImage});

  factory SecondScreenDetails.fromJson(Map<String, dynamic> json) =>
      SecondScreenDetails(
          salesDetailKey: json['salesDetailKey'] ?? "",
          salesKey: json['salesKey'] ?? "",
          invoiceDoc: json['invoiceDoc'] ?? "",
          itemCode: json['itemCode'],
          itemDesc: json['itemDesc'],
          itemDesc2: json['itemDesc2'],
          quantity: json['quantity'] ?? 0.0,
          price: json['price'] ?? 0.0,
          totalAmount: json['totalAmount'] ?? 0.0,
          uom: json['uom'] ?? "",
          discountValue: json['discountValue'] ?? 0.0,
          discountPercent: json['discountPercent'] ?? 0,
          isDiscountInPercent: json['isDiscountInPercent'] ?? 0,
          taxCode: json['taxCode'] ?? "",
          taxAmount: json['taxAmount'] ?? 0.0,
          taxRate: json['taxRate'] ?? 0,
          fromSalesKey: json['fromSalesKey'] ?? "",
          fromSalesDetailKey: json['fromSalesDetailKey'] ?? "",
          promotionKey: json['promotionKey'] ?? "",
          promotionType: json['promotionType'] ?? "",
          promotionDetailKey: json['promotionDetailKey'] ?? "",
          promotionDiscount: json['promotionDiscount'] ?? 0.0,
          itemImage: json['itemImage'] ?? '');

  Map<String, dynamic> toJson() => {
    'salesDetailKey': salesDetailKey,
    'salesKey': salesKey,
    'invoiceDoc': invoiceDoc,
    'itemCode': itemCode,
    'itemDesc': itemDesc,
    'itemDesc2': itemDesc2,
    'quantity': quantity,
    'price': price,
    'totalAmount': totalAmount,
    'uom': uom,
    'discountValue': discountValue,
    'discountPercent': discountPercent,
    'isDiscountInPercent': isDiscountInPercent,
    'taxCode': taxCode,
    'taxAmount': taxAmount,
    'taxRate': taxRate,
    'fromSalesKey': fromSalesKey,
    'fromSalesDetailKey': fromSalesDetailKey,
    'promotionKey': promotionKey,
    'promotionType': promotionType,
    'promotionDetailKey': promotionDetailKey,
    'promotionDiscount': promotionDiscount,
    'itemImage': itemImage,
  };
}
