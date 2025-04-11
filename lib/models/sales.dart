import 'package:ezyretail/globals.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:intl/intl.dart';

import "../globals.dart" as globals;

class SalesHeader {
  String salesKey;
  String batchKey;
  String userKey;
  String invoiceDoc;
  String customerKey;
  String transactionId;
  double taxAmount;
  String status;
  String createdAt;
  String transactionAt;
  String voucher;
  double voucherAmount;
  int footerDiscountPercent;
  double footerDiscountValue;
  int isFooterDiscountPercent;
  double subtotal;
  double total;
  double roundedAmount;
  String lastSync;
  String returnUserKey;
  String authorizeUserKey;
  String returnSalesAt;
  String customerName;
  String customerAddress1;
  String customerAddress2;
  String customerAddress3;
  String customerAddress4;

  String customerPhone;
  String customerEmail;
  String customerTin;
  String customerIcNum;
  String customerSST;

  double ezyPointEarnPoint;
  double ezyPointRedeemPoint;
  double ezyPointRedeemValue;
  double ezyCreditValue;

  SalesHeader({
    required this.salesKey,
    required this.batchKey,
    required this.userKey,
    required this.invoiceDoc,
    required this.customerKey,
    required this.transactionId,
    required this.status,
    required this.createdAt,
    required this.transactionAt,
    required this.taxAmount,
    required this.voucher,
    required this.voucherAmount,
    required this.footerDiscountPercent,
    required this.footerDiscountValue,
    required this.isFooterDiscountPercent,
    required this.subtotal,
    required this.total,
    required this.roundedAmount,
    required this.lastSync,
    required this.returnUserKey,
    required this.authorizeUserKey,
    required this.returnSalesAt,
    required this.customerName,
    required this.customerAddress1,
    required this.customerAddress2,
    required this.customerAddress3,
    required this.customerAddress4,
    required this.customerPhone,
    required this.customerEmail,
    required this.customerTin,
    required this.customerIcNum,
    required this.customerSST,
    required this.ezyPointEarnPoint,
    required this.ezyPointRedeemPoint,
    required this.ezyPointRedeemValue,
    required this.ezyCreditValue,
  });

  factory SalesHeader.fromInitValue() => SalesHeader(
    salesKey: "",
    batchKey: "",
    userKey: "",
    invoiceDoc: "",
    customerKey: "",
    transactionId: "",
    taxAmount: 0.0,
    status: "T",
    createdAt: "",
    transactionAt: "",
    voucher: "",
    voucherAmount: 0.0,
    footerDiscountPercent: 0,
    footerDiscountValue: 0.0,
    isFooterDiscountPercent: 0,
    subtotal: 0.0,
    total: 0.0,
    roundedAmount: 0.0,
    lastSync: "",
    returnUserKey: "",
    authorizeUserKey: "",
    returnSalesAt: "",
    customerName: "",
    customerAddress1: "",
    customerAddress2: "",
    customerAddress3: "",
    customerAddress4: "",
    customerPhone: "",
    customerEmail: "",
    customerTin: "",
    customerIcNum: "",
    customerSST: "",
    ezyPointEarnPoint: 0.0,
    ezyPointRedeemPoint: 0.0,
    ezyPointRedeemValue: 0.0,
    ezyCreditValue: 0.0,
  );

  SalesHeader copyWith({
    String? salesKey,
    String? batchKey,
    String? userKey,
    String? invoiceDoc,
    String? customerKey,
    String? transactionId,
    double? taxAmount,
    String? status,
    String? createdAt,
    String? transactionAt,
    String? voucher,
    double? voucherAmount,
    int? footerDiscountPercent,
    double? footerDiscountValue,
    int? isFooterDiscountPercent,
    double? subtotal,
    double? total,
    double? roundedAmount,
    String? lastSync,
    String? returnUserKey,
    String? authorizeUserKey,
    String? returnSalesAt,
    String? customerName,
    String? customerAddress1,
    String? customerAddress2,
    String? customerAddress3,
    String? customerAddress4,
    String? customerPhone,
    String? customerEmail,
    String? customerTin,
    String? customerIcNum,
    String? customerSST,
    double? ezyPointEarnPoint,
    double? ezyPointRedeemPoint,
    double? ezyPointRedeemValue,
    double? ezyCreditValue,
  }) =>
      SalesHeader(
        salesKey: salesKey ?? this.salesKey,
        batchKey: batchKey ?? this.batchKey,
        userKey: userKey ?? this.userKey,
        invoiceDoc: invoiceDoc ?? this.invoiceDoc,
        customerKey: customerKey ?? this.customerKey,
        transactionId: transactionId ?? this.transactionId,
        taxAmount: taxAmount ?? this.taxAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        transactionAt: transactionAt ?? this.transactionAt,
        voucher: voucher ?? this.voucher,
        voucherAmount: voucherAmount ?? this.voucherAmount,
        footerDiscountPercent:
        footerDiscountPercent ?? this.footerDiscountPercent,
        footerDiscountValue: footerDiscountValue ?? this.footerDiscountValue,
        isFooterDiscountPercent:
        isFooterDiscountPercent ?? this.isFooterDiscountPercent,
        subtotal: subtotal ?? this.subtotal,
        total: total ?? this.total,
        roundedAmount: roundedAmount ?? this.roundedAmount,
        lastSync: lastSync ?? this.lastSync,
        returnUserKey: returnUserKey ?? this.returnUserKey,
        authorizeUserKey: authorizeUserKey ?? this.authorizeUserKey,
        returnSalesAt: returnSalesAt ?? this.returnSalesAt,
        customerName: customerName ?? this.customerName,
        customerAddress1: customerAddress1 ?? this.customerAddress1,
        customerAddress2: customerAddress2 ?? this.customerAddress2,
        customerAddress3: customerAddress3 ?? this.customerAddress3,
        customerAddress4: customerAddress4 ?? this.customerAddress4,
        customerPhone: customerPhone ?? this.customerPhone,
        customerEmail: customerEmail ?? this.customerEmail,
        customerTin: customerTin ?? this.customerTin,
        customerIcNum: customerIcNum ?? this.customerIcNum,
        customerSST: customerSST ?? this.customerSST,
        ezyPointEarnPoint: ezyPointEarnPoint ?? this.ezyPointEarnPoint,
        ezyPointRedeemPoint: ezyPointRedeemPoint ?? this.ezyPointRedeemPoint,
        ezyPointRedeemValue: ezyPointRedeemValue ?? this.ezyPointRedeemValue,
        ezyCreditValue: ezyCreditValue ?? this.ezyCreditValue,
      );

  factory SalesHeader.fromDB(Map<String, dynamic> json) => SalesHeader(
    salesKey: json[DatabaseHelper.salesKey] ?? "",
    batchKey: json[DatabaseHelper.batchKey] ?? "",
    userKey: json[DatabaseHelper.userKey],
    invoiceDoc: json[DatabaseHelper.invoiceDoc],
    customerKey: json[DatabaseHelper.customerKey],
    transactionId: json[DatabaseHelper.transactionId] ?? "",
    taxAmount: json[DatabaseHelper.taxAmount] ?? 0.0,
    status: json[DatabaseHelper.status] ?? 0,
    createdAt: json[DatabaseHelper.createdAt] ?? "",
    transactionAt: json[DatabaseHelper.transactionAt] ?? "",
    voucher: json[DatabaseHelper.voucher] ?? "",
    voucherAmount: json[DatabaseHelper.voucherAmount] ?? 0.0,
    footerDiscountPercent: json[DatabaseHelper.footerDiscountPercent] ?? 0,
    footerDiscountValue: json[DatabaseHelper.footerDiscountValue] ?? 0.0,
    isFooterDiscountPercent:
    json[DatabaseHelper.isFooterDiscountPercent] ?? 0,
    subtotal: json[DatabaseHelper.subtotal] ?? 0.0,
    total: json[DatabaseHelper.total] ?? 0.0,
    roundedAmount: json[DatabaseHelper.roundedAmount] ?? 0.0,
    lastSync: json[DatabaseHelper.lastSync] ?? "",
    returnUserKey: json[DatabaseHelper.returnUserKey] ?? "",
    authorizeUserKey: json[DatabaseHelper.authorizeUserKey] ?? "",
    returnSalesAt: json[DatabaseHelper.returnSalesAt] ?? "",
    customerName: json[DatabaseHelper.customerName] ?? "",
    customerAddress1: json[DatabaseHelper.customerAddress1] ?? "",
    customerAddress2: json[DatabaseHelper.customerAddress2] ?? "",
    customerAddress3: json[DatabaseHelper.customerAddress3] ?? "",
    customerAddress4: json[DatabaseHelper.customerAddress4] ?? "",
    customerPhone: json[DatabaseHelper.customerPhone] ?? "",
    customerEmail: json[DatabaseHelper.customerEmail] ?? "",
    customerTin: json[DatabaseHelper.customerTin] ?? "",
    customerIcNum: json[DatabaseHelper.customerIcNum] ?? "",
    customerSST: json[DatabaseHelper.customerSST] ?? "",
    ezyPointEarnPoint: json[DatabaseHelper.ezyPointEarnPoint] ?? 0.0,
    ezyPointRedeemPoint: json[DatabaseHelper.ezyPointRedeemPoint] ?? 0.0,
    ezyPointRedeemValue: json[DatabaseHelper.ezyPointRedeemValue] ?? 0.0,
    ezyCreditValue: json[DatabaseHelper.ezyCreditValue] ?? 0.0,
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.salesKey: salesKey,
      DatabaseHelper.batchKey: batchKey,
      DatabaseHelper.userKey: userKey,
      DatabaseHelper.invoiceDoc: invoiceDoc,
      DatabaseHelper.customerKey: customerKey,
      DatabaseHelper.transactionId: transactionId,
      DatabaseHelper.taxAmount: taxAmount,
      DatabaseHelper.status: status,
      DatabaseHelper.createdAt: createdAt,
      DatabaseHelper.transactionAt: transactionAt,
      DatabaseHelper.voucher: voucher,
      DatabaseHelper.voucherAmount: voucherAmount,
      DatabaseHelper.footerDiscountPercent: footerDiscountPercent,
      DatabaseHelper.footerDiscountValue: footerDiscountValue,
      DatabaseHelper.isFooterDiscountPercent: isFooterDiscountPercent,
      DatabaseHelper.subtotal: subtotal,
      DatabaseHelper.total: total,
      DatabaseHelper.roundedAmount: roundedAmount,
      DatabaseHelper.lastSync: lastSync,
      DatabaseHelper.returnUserKey: returnUserKey,
      DatabaseHelper.authorizeUserKey: authorizeUserKey,
      DatabaseHelper.returnSalesAt: returnSalesAt,
      DatabaseHelper.customerName: customerName,
      DatabaseHelper.customerAddress1: customerAddress1,
      DatabaseHelper.customerAddress2: customerAddress2,
      DatabaseHelper.customerAddress3: customerAddress3,
      DatabaseHelper.customerAddress4: customerAddress4,
      DatabaseHelper.customerPhone: customerPhone,
      DatabaseHelper.customerEmail: customerEmail,
      DatabaseHelper.customerTin: customerTin,
      DatabaseHelper.customerIcNum: customerIcNum,
      DatabaseHelper.customerSST: customerSST,
      DatabaseHelper.ezyPointEarnPoint: ezyPointEarnPoint,
      DatabaseHelper.ezyPointRedeemPoint: ezyPointRedeemPoint,
      DatabaseHelper.ezyPointRedeemValue: ezyPointRedeemValue,
      DatabaseHelper.ezyCreditValue: ezyCreditValue,
    };
  }
}

class SalesDetail {
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
  double baseQty;

  SalesDetail({
    required this.salesDetailKey,
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
    required this.itemImage,
    required this.baseQty,
  });

  SalesDetail copyWith({
    String? salesDetailKey,
    String? salesKey,
    String? invoiceDoc,
    String? itemCode,
    String? itemDesc,
    String? itemDesc2,
    double? quantity,
    double? price,
    double? totalAmount,
    String? uom,
    double? discountValue,
    int? discountPercent,
    int? isDiscountInPercent,
    String? taxCode,
    double? taxAmount,
    int? taxRate,
    String? fromSalesKey,
    String? fromSalesDetailKey,
    String? promotionKey,
    String? promotionType,
    String? promotionDetailKey,
    double? promotionDiscount,
    String? itemImage,
    double? baseQty,
  }) =>
      SalesDetail(
        salesDetailKey: salesDetailKey ?? this.salesDetailKey,
        salesKey: salesKey ?? this.salesKey,
        invoiceDoc: invoiceDoc ?? this.invoiceDoc,
        itemCode: itemCode ?? this.itemCode,
        itemDesc: itemDesc ?? this.itemDesc,
        itemDesc2: itemDesc2 ?? this.itemDesc2,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        totalAmount: totalAmount ?? this.totalAmount,
        uom: uom ?? this.uom,
        discountValue: discountValue ?? this.discountValue,
        discountPercent: discountPercent ?? this.discountPercent,
        isDiscountInPercent: isDiscountInPercent ?? this.isDiscountInPercent,
        taxCode: taxCode ?? this.taxCode,
        taxAmount: taxAmount ?? this.taxAmount,
        taxRate: taxRate ?? this.taxRate,
        fromSalesKey: fromSalesKey ?? this.fromSalesKey,
        fromSalesDetailKey: fromSalesDetailKey ?? this.fromSalesDetailKey,
        promotionKey: promotionKey ?? this.promotionKey,
        promotionType: promotionType ?? this.promotionType,
        promotionDetailKey: promotionDetailKey ?? this.promotionDetailKey,
        promotionDiscount: promotionDiscount ?? this.promotionDiscount,
        itemImage: itemImage ?? this.itemImage,
        baseQty: baseQty ?? this.baseQty,
      );

  factory SalesDetail.fromDB(Map<String, dynamic> json) => SalesDetail(
      salesDetailKey: json[DatabaseHelper.salesDetailKey] ?? "",
      salesKey: json[DatabaseHelper.salesKey] ?? "",
      invoiceDoc: json[DatabaseHelper.invoiceDoc] ?? "",
      itemCode: json[DatabaseHelper.itemCode],
      itemDesc: json[DatabaseHelper.itemDesc],
      itemDesc2: json[DatabaseHelper.itemDesc2],
      quantity: json[DatabaseHelper.quantity] ?? 0.0,
      price: json[DatabaseHelper.price] ?? 0.0,
      totalAmount: json[DatabaseHelper.totalAmount] ?? 0.0,
      uom: json[DatabaseHelper.uom] ?? "",
      discountValue: json[DatabaseHelper.discountValue] ?? 0.0,
      discountPercent: json[DatabaseHelper.discountPercent] ?? 0,
      isDiscountInPercent: json[DatabaseHelper.discount] ?? 0,
      taxCode: json[DatabaseHelper.taxCode] ?? "",
      taxAmount: json[DatabaseHelper.taxAmount] ?? 0.0,
      taxRate: json[DatabaseHelper.taxRate] ?? 0,
      fromSalesKey: json[DatabaseHelper.fromSalesKey] ?? "",
      fromSalesDetailKey: json[DatabaseHelper.fromSalesDetailKey] ?? "",
      promotionKey: json[DatabaseHelper.promotionKey] ?? "",
      promotionType: json[DatabaseHelper.promotionType] ?? "",
      promotionDetailKey: json[DatabaseHelper.promotionDetailKey] ?? "",
      promotionDiscount: json[DatabaseHelper.promotionDiscount] ?? 0.0,
      itemImage: json[DatabaseHelper.itemImage] ?? '',
      baseQty: json[DatabaseHelper.baseQty] ?? 0.0);

  factory SalesDetail.fromLocal(Map<String, dynamic> json) => SalesDetail(
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
    itemImage: json['itemImage'] ?? '',
    baseQty: json['baseQty'] ?? '',
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.salesDetailKey: salesDetailKey,
      DatabaseHelper.salesKey: salesKey,
      DatabaseHelper.invoiceDoc: invoiceDoc,
      DatabaseHelper.itemCode: itemCode,
      DatabaseHelper.itemDesc: itemDesc,
      DatabaseHelper.itemDesc2: itemDesc2,
      DatabaseHelper.quantity: quantity,
      DatabaseHelper.price: price,
      DatabaseHelper.totalAmount: totalAmount,
      DatabaseHelper.uom: uom,
      DatabaseHelper.discountValue: discountValue,
      DatabaseHelper.discountPercent: discountPercent,
      DatabaseHelper.isDiscountInPercent: isDiscountInPercent,
      DatabaseHelper.taxCode: taxCode,
      DatabaseHelper.taxAmount: taxAmount,
      DatabaseHelper.taxRate: taxRate,
      DatabaseHelper.fromSalesKey: fromSalesKey,
      DatabaseHelper.fromSalesDetailKey: fromSalesDetailKey,
      DatabaseHelper.promotionKey: promotionKey,
      DatabaseHelper.promotionType: promotionType,
      DatabaseHelper.promotionDetailKey: promotionDetailKey,
      DatabaseHelper.promotionDiscount: promotionDiscount,
      DatabaseHelper.baseQty: baseQty,
    };
  }

  Map<String, dynamic> toJson() => {
    'SalesDetailKey': salesDetailKey,
    'SalesKey': salesKey,
    'InvoiceNum': invoiceDoc,
    'ItemCode': itemCode,
    'Description': itemDesc,
    'Description2': itemDesc2,
    'Quantity': quantity,
    'UnitPrice': price,
    'TotalAmount': totalAmount,
    'Uom': uom,
    'DiscountValue': discountValue,
    'TaxCode': taxCode,
    'TaxAmount': taxAmount,
    'TaxRate': taxRate,
    'Ref': fromSalesKey,
    'FromDtlKey': fromSalesDetailKey,
    'baseQty': baseQty,
  };

  Map<String, dynamic> toLocal() => {
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
    'baseQty': baseQty,
  };

  Map<String, dynamic> toCloud() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sales_detail_key"] = salesDetailKey;
    data["sales_key"] = salesKey;
    data["invoice_doc"] = invoiceDoc;
    data["item_code"] = itemCode;
    data["item_desc"] = itemDesc ?? "";
    data["item_desc2"] = itemDesc2;
    data["quantity"] = quantity;
    data["price"] = price;
    data["total_amount"] = totalAmount;
    data["item_uom"] = uom;
    data["discount_value"] = discountValue;
    data["discount_percent"] = discountPercent;
    data["is_discount_in_percent"] = isDiscountInPercent;
    data["tax_code"] = taxCode;
    data["tax_amount"] = taxAmount;
    data["tax_rate"] = taxRate;
    data["from_sales_key"] = fromSalesKey;
    data["from_sales_detail_key"] = fromSalesDetailKey;
    data["promotion_key"] = promotionKey;
    data["promotion_type"] = promotionType;
    data["promotion_detail_key"] = promotionDetailKey;
    data["promotion_discount"] = promotionDiscount;

    return data;
  }

  Map<String, dynamic> toEInvoice() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["DETAIL_KEY"] = salesDetailKey;
    data["SALES_UUID"] = salesKey;
    data["DOCNO"] = invoiceDoc;
    data["ITEM_CODE"] = itemCode;
    data["ITEM_DESC"] = itemDesc ?? "";
    data["CLASSIFICATION_CODE"] = "022";
    data["QTY"] = quantity;
    data["UNIT_PRICE"] = price;
    data["SUB_TOTAL"] = (quantity * price);
    data["UOM"] = uom;
    data["DISCOUNT"] = discountValue;
    data["TAX_CODE"] = taxCode;
    data["TAX_AMT"] = taxAmount;
    data["TOTAL_AMT"] = totalAmount;
    data["REF"] = fromSalesKey;
    data["FROMDTLKEY"] = fromSalesDetailKey;

    return data;
  }

  Map<String, dynamic> toEInvoiceReturn() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["DETAIL_KEY"] = salesDetailKey;
    data["RETURN_UUID"] = salesKey;
    data["DOCNO"] = invoiceDoc;
    data["ITEM_CODE"] = itemCode;
    data["ITEM_DESC"] = itemDesc ?? "";
    data["CLASSIFICATION_CODE"] = "022";
    data["QTY"] = quantity;
    data["UNIT_PRICE"] = price;
    data["SUB_TOTAL"] = (quantity * price);
    data["UOM"] = uom;
    data["DISCOUNT"] = discountValue;
    data["TAX_CODE"] = taxCode;
    data["TAX_AMT"] = taxAmount;
    data["TOTAL_AMT"] = totalAmount;
    data["REF"] = fromSalesKey;
    data["FROMDTLKEY"] = fromSalesDetailKey;

    return data;
  }
}

class SalesPaymentRecord {
  String salesKey;
  String invoiceDoc;
  double totalAmount;
  double knockOffAmount;
  double paidAmount;
  double changeAmount;
  String paymentCode;
  String reference;
  int paymentType;
  bool isOpenDrawer;

  SalesPaymentRecord(
      {required this.salesKey,
        required this.invoiceDoc,
        required this.totalAmount,
        required this.knockOffAmount,
        required this.paidAmount,
        required this.changeAmount,
        required this.paymentCode,
        required this.reference,
        required this.paymentType,
        required this.isOpenDrawer});

  factory SalesPaymentRecord.fromDB(Map<String, dynamic> json) =>
      SalesPaymentRecord(
          salesKey: json[DatabaseHelper.salesKey] ?? "",
          invoiceDoc: json[DatabaseHelper.invoiceDoc] ?? "",
          totalAmount: json[DatabaseHelper.totalAmount] ?? 0.0,
          knockOffAmount: json[DatabaseHelper.knockOffAmount] ?? 0.0,
          paidAmount: json[DatabaseHelper.paidAmount] ?? 0.0,
          changeAmount: json[DatabaseHelper.changeAmount] ?? 0.0,
          paymentCode: json[DatabaseHelper.paymentCode] ?? "",
          reference: json[DatabaseHelper.reference] ?? "",
          paymentType: json[DatabaseHelper.paymentType] ?? "",
          isOpenDrawer: false);

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.salesKey: salesKey,
      DatabaseHelper.invoiceDoc: invoiceDoc,
      DatabaseHelper.totalAmount: totalAmount,
      DatabaseHelper.knockOffAmount: knockOffAmount,
      DatabaseHelper.paidAmount: paidAmount,
      DatabaseHelper.changeAmount: changeAmount,
      DatabaseHelper.paymentCode: paymentCode,
      DatabaseHelper.reference: reference,
      DatabaseHelper.paymentType: paymentType
    };
  }

  SalesPaymentRecord copyWith(
      {String? salesKey,
        String? invoiceDoc,
        double? totalAmount,
        double? knockOffAmount,
        double? paidAmount,
        double? changeAmount,
        String? paymentCode,
        String? reference,
        int? paymentType,
        bool? isOpenDrawer}) =>
      SalesPaymentRecord(
          salesKey: salesKey ?? this.salesKey,
          invoiceDoc: invoiceDoc ?? this.invoiceDoc,
          totalAmount: totalAmount ?? this.totalAmount,
          knockOffAmount: knockOffAmount ?? this.knockOffAmount,
          paidAmount: paidAmount ?? this.paidAmount,
          changeAmount: changeAmount ?? this.changeAmount,
          paymentCode: paymentCode ?? this.paymentCode,
          reference: reference ?? this.reference,
          paymentType: paymentType ?? this.paymentType,
          isOpenDrawer: isOpenDrawer ?? this.isOpenDrawer);

  Map<String, dynamic> toJson() => {
    'SalesKey': salesKey,
    'InvoiceDoc': invoiceDoc,
    'TotalAmount': totalAmount,
    'KnockOffAmount': knockOffAmount,
    'PaidAmount': paidAmount,
    'ChangeAmount': changeAmount,
    'PaymentCode': paymentCode,
    'Reference': reference,
    'PaymentType': paymentType
  };

  Map<String, dynamic> toCloud() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["invoice_doc"] = invoiceDoc;
    data["total_amount"] = totalAmount;
    data["knock_off_amount"] = knockOffAmount;
    data["paid_amount"] = paidAmount;
    data["change_amount"] = changeAmount;
    data["payment_code"] = paymentCode;
    data["reference"] = reference;

    return data;
  }
}

class SalesCheckOutObject {
  String invoiceDoc;
  double totalAmount;
  double paidAmount;
  double changeAmount;

  SalesCheckOutObject({
    required this.invoiceDoc,
    required this.totalAmount,
    required this.paidAmount,
    required this.changeAmount,
  });
}

class FullSalesDoc {
  String salesKey;
  String batchKey;
  String batchDate;
  String batchEnd;
  String userKey;
  String userName;
  String invoiceDoc;
  String customerKey;
  String transactionId;
  double taxAmount;
  String status;
  String createdAt;
  String transactionAt;
  String voucher;
  double voucherAmount;
  int footerDiscountPercent;
  double footerDiscountValue;
  int isFooterDiscountPercent;
  double subtotal;
  double total;
  double roundedAmount;
  String lastSync;
  String returnUserKey;
  String authorizeUserKey;
  String returnSalesAt;
  String customerName;
  String customerAddress1;
  String customerAddress2;
  String customerAddress3;
  String customerAddress4;

  String customerPhone;
  String customerEmail;
  String customerTin;
  String customerIcNum;
  String customerSST;

  double ezyPointEarnPoint;
  double ezyPointRedeemPoint;
  double ezyPointRedeemValue;
  double ezyCreditValue;

  List<SalesDetail> salesDetails;
  List<SalesPaymentRecord> salesPayment;

  FullSalesDoc(
      {required this.salesKey,
        required this.batchKey,
        required this.batchDate,
        required this.batchEnd,
        required this.userKey,
        required this.userName,
        required this.invoiceDoc,
        required this.customerKey,
        required this.transactionId,
        required this.status,
        required this.createdAt,
        required this.transactionAt,
        required this.taxAmount,
        required this.voucher,
        required this.voucherAmount,
        required this.footerDiscountPercent,
        required this.footerDiscountValue,
        required this.isFooterDiscountPercent,
        required this.subtotal,
        required this.total,
        required this.roundedAmount,
        required this.lastSync,
        required this.returnUserKey,
        required this.authorizeUserKey,
        required this.returnSalesAt,
        required this.customerName,
        required this.customerAddress1,
        required this.customerAddress2,
        required this.customerAddress3,
        required this.customerAddress4,
        required this.customerPhone,
        required this.customerEmail,
        required this.customerTin,
        required this.customerIcNum,
        required this.customerSST,
        required this.ezyPointEarnPoint,
        required this.ezyPointRedeemPoint,
        required this.ezyPointRedeemValue,
        required this.ezyCreditValue,
        required this.salesDetails,
        required this.salesPayment});

  DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');

  Map<String, dynamic> toJson() => {
    'SalesKey': salesKey,
    'BatchKey': batchKey,
    'BatchDate': batchDate,
    'BatchEnd': batchEnd,
    'SalesPerson': userKey,
    'UserName': userName,
    'InvoiceNum': invoiceDoc,
    'DocDate': dateFormat.format(DateTime.parse(createdAt)),
    'Customer': customerKey,
    'Subtotal': subtotal,
    'TaxAmount': taxAmount,
    'FooterDiscount': footerDiscountValue,
    'Rounding': roundedAmount,
    'DocTotal': total,
    'CustomerName': customerName,
    'CustomerPhone': customerPhone,
    'CustomerEmail': customerEmail,
    'CustomerAddress1': customerAddress1,
    'CustomerAddress2': customerAddress2,
    'CustomerAddress3': customerAddress3,
    'CustomerAddress4': customerAddress4,
    'CustomerTaxNum': customerSST,
    'CustomerTin': customerTin,
    'CustomerIdentification': customerIcNum,
    'EzyPointEarnPoint': ezyPointEarnPoint,
    'EzyPointRedeemPoint': ezyPointRedeemPoint,
    'EzyPointRedeemValue': ezyPointRedeemValue,
    'EzyVoucherCode': "",
    'EzyVoucherAmount': "",
    'EzyCreditValue': ezyCreditValue,
    'EzySalesDetails': salesDetails,
    'EzySalesPayment': salesPayment
  };

  Map<String, dynamic> toCloud() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["sales_key"] = salesKey.toString();
    data["batch_key"] = batchKey.toString();
    data["batch_start"] =
        dateFormat.format(DateTime.parse(batchDate)); //batchDate.toString();
    data["user_key"] = userKey.toString();
    data["invoice_doc"] = invoiceDoc.toString();
    data["invoice_date"] = dateFormat.format(DateTime.parse(createdAt));
    data["customer_key"] = customerKey.toString();
    data["sub_total"] = subtotal.toString();
    data["tax_amount"] = taxAmount.toString();
    data["footer_discount_percent"] = footerDiscountPercent.toString();
    data["footer_discount_value"] = footerDiscountValue.toString();
    data["is_footer_discount_percent"] = isFooterDiscountPercent.toString();
    data["rounded_amount"] = roundedAmount.toString();
    data["total"] = total.toString();
    data["customer_name"] = customerName.toString();
    data["customer_phone"] = customerPhone.toString();
    data["customer_email"] = customerEmail.toString();
    data["customer_address1"] = customerAddress1.toString();
    data["customer_address2"] = customerAddress2.toString();
    data["customer_address3"] = customerAddress3.toString();
    data["customer_address4"] = customerAddress4.toString();
    data["customer_sst"] = customerSST;
    data["customer_tin"] = customerTin;
    data["customer_ic_num"] = customerIcNum;
    data["ezy_earn_point"] = ezyPointEarnPoint;
    data["ezy_redeem_point"] = ezyPointRedeemPoint;
    data["ezy_redeem_value"] = ezyPointRedeemValue;
    data["voucher"] = voucher.toString();
    data["voucher_amount"] = voucherAmount;
    data["ezy_credit_value"] = ezyCreditValue;
    data["sales_detail"] =
        salesDetails.map((details) => details.toCloud()).toList();
    data["sales_payment"] =
        salesPayment.map((payment) => payment.toCloud()).toList();
    return data;
  }

  Map<String, dynamic> toEInvoice() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["SUP_UUID"] = batchKey.toString();
    data["SALES_UUID"] = salesKey.toString();
    data["APP_ID"] = appId;
    data["COUNTER_NO"] =
    "${systemCompanyProfile?.label}${systemCompanyProfile?.counter.toString().padLeft(2, '0')}";
    data["DOCNO"] = invoiceDoc.toString();
    data["DOCDATE"] = dateFormat.format(DateTime.parse(createdAt));
    data["SUBTOTAL"] = subtotal.toString();
    data["TAXAMOUNT"] = taxAmount.toString();
    data["FOOTERDISCOUNT"] = footerDiscountValue.toString();
    data["ROUNDING"] = roundedAmount.toString();
    data["TOTAL"] = total.toString();
    data["CUST_CODE"] = customerKey.toString();
    data["CUST_NAME"] = customerName.toString();
    data["CUST_PHONE"] = customerPhone.toString();
    data["CUST_EMAIL"] = customerEmail.toString();
    data["CUST_ADD1"] = customerAddress1.toString();
    data["CUST_ADD2"] = customerAddress2.toString();
    data["CUST_ADD3"] = customerAddress3.toString();

    data["POINT_EARN"] = ezyPointEarnPoint;
    data["POINT_REDEEM"] = ezyPointRedeemPoint;
    data["REDEEM_VALUE"] = ezyPointRedeemValue;
    data["VOUCHER_CODE"] = voucher.toString();
    data["VOUCHER_VALUE"] = voucherAmount;
    data["CREDIT_VALUE"] = ezyCreditValue;
    data["SALES_DTL"] =
        salesDetails.map((details) => details.toEInvoice()).toList();

    return data;
  }

  Map<String, dynamic> toEInvoiceReturn() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["SUP_UUID"] = batchKey.toString();
    data["RETURN_UUID"] = salesKey.toString();
    data["SALES_UUID"] = returnSalesAt.toString();
    data["APP_ID"] = appId;
    data["COUNTER_NO"] =
    "${systemCompanyProfile?.label}${systemCompanyProfile?.counter.toString().padLeft(2, '0')}";
    data["DOCNO"] = invoiceDoc.toString();
    data["DOCDATE"] = dateFormat.format(DateTime.parse(createdAt));
    data["SUBTOTAL"] = subtotal.toString();
    data["TAXAMOUNT"] = taxAmount.toString();
    data["FOOTERDISCOUNT"] = footerDiscountValue.toString();
    data["ROUNDING"] = roundedAmount.toString();
    data["TOTAL"] = total.toString();
    data["CUST_CODE"] = customerKey.toString();
    data["CUST_NAME"] = customerName.toString();
    data["CUST_PHONE"] = customerPhone.toString();
    data["CUST_EMAIL"] = customerEmail.toString();
    data["CUST_ADD1"] = customerAddress1.toString();
    data["CUST_ADD2"] = customerAddress2.toString();
    data["CUST_ADD3"] = customerAddress3.toString();

    data["POINT_EARN"] = ezyPointEarnPoint;
    data["POINT_REDEEM"] = ezyPointRedeemPoint;
    data["REDEEM_VALUE"] = ezyPointRedeemValue;
    data["VOUCHER_CODE"] = voucher.toString();
    data["VOUCHER_VALUE"] = voucherAmount;
    data["CREDIT_VALUE"] = ezyCreditValue;
    data["SALES_DTL"] =
        salesDetails.map((details) => details.toEInvoiceReturn()).toList();

    return data;
  }

  factory FullSalesDoc.fromInitValue() => FullSalesDoc(
    salesKey: "",
    batchKey: "",
    batchDate: "",
    batchEnd: "",
    userKey: "",
    userName: "",
    invoiceDoc: "",
    customerKey: "",
    transactionId: "",
    taxAmount: 0.0,
    status: "T",
    createdAt: "",
    transactionAt: "",
    voucher: "",
    voucherAmount: 0.0,
    footerDiscountPercent: 0,
    footerDiscountValue: 0.0,
    isFooterDiscountPercent: 0,
    subtotal: 0.0,
    total: 0.0,
    roundedAmount: 0.0,
    lastSync: "",
    returnUserKey: "",
    authorizeUserKey: "",
    returnSalesAt: "",
    customerName: "",
    customerAddress1: "",
    customerAddress2: "",
    customerAddress3: "",
    customerAddress4: "",
    customerPhone: "",
    customerEmail: "",
    customerTin: "",
    customerIcNum: "",
    customerSST: "",
    ezyPointEarnPoint: 0.0,
    ezyPointRedeemPoint: 0.0,
    ezyPointRedeemValue: 0.0,
    ezyCreditValue: 0.0,
    salesDetails: [],
    salesPayment: [],
  );

  factory FullSalesDoc.fromDB(Map<String, dynamic> json) => FullSalesDoc(
      salesKey: json[DatabaseHelper.salesKey] ?? "",
      batchKey: json[DatabaseHelper.batchKey] ?? "",
      batchDate: json[DatabaseHelper.startCounter] ?? "",
      batchEnd: json[DatabaseHelper.endCounter] ?? "",
      userKey: json[DatabaseHelper.userKey],
      userName: json[DatabaseHelper.userName] ?? '',
      invoiceDoc: json[DatabaseHelper.invoiceDoc],
      customerKey: json[DatabaseHelper.customerKey],
      transactionId: json[DatabaseHelper.transactionId] ?? "",
      taxAmount: json[DatabaseHelper.taxAmount] ?? 0.0,
      status: json[DatabaseHelper.status] ?? 0,
      createdAt: json[DatabaseHelper.createdAt] ?? "",
      transactionAt: json[DatabaseHelper.transactionAt] ?? "",
      voucher: json[DatabaseHelper.voucher] ?? "",
      voucherAmount: json[DatabaseHelper.voucherAmount] ?? 0.0,
      footerDiscountPercent: json[DatabaseHelper.footerDiscountPercent] ?? 0,
      footerDiscountValue: json[DatabaseHelper.footerDiscountValue] ?? 0.0,
      isFooterDiscountPercent:
      json[DatabaseHelper.isFooterDiscountPercent] ?? 0,
      subtotal: json[DatabaseHelper.subtotal] ?? 0.0,
      total: json[DatabaseHelper.total] ?? 0.0,
      roundedAmount: json[DatabaseHelper.roundedAmount] ?? 0.0,
      lastSync: json[DatabaseHelper.lastSync] ?? "",
      returnUserKey: json[DatabaseHelper.returnUserKey] ?? "",
      authorizeUserKey: json[DatabaseHelper.authorizeUserKey] ?? "",
      returnSalesAt: json[DatabaseHelper.returnSalesAt] ?? "",
      customerName: json[DatabaseHelper.customerName] ?? "",
      customerAddress1: json[DatabaseHelper.customerAddress1] ?? "",
      customerAddress2: json[DatabaseHelper.customerAddress2] ?? "",
      customerAddress3: json[DatabaseHelper.customerAddress3] ?? "",
      customerAddress4: json[DatabaseHelper.customerAddress4] ?? "",
      customerPhone: json[DatabaseHelper.customerPhone] ?? "",
      customerEmail: json[DatabaseHelper.customerEmail] ?? "",
      customerTin: json[DatabaseHelper.customerTin] ?? "",
      customerIcNum: json[DatabaseHelper.customerIcNum] ?? "",
      customerSST: json[DatabaseHelper.customerSST] ?? "",
      ezyPointEarnPoint: json[DatabaseHelper.ezyPointEarnPoint] ?? 0.0,
      ezyPointRedeemPoint: json[DatabaseHelper.ezyPointRedeemPoint] ?? 0.0,
      ezyPointRedeemValue: json[DatabaseHelper.ezyPointRedeemValue] ?? 0.0,
      ezyCreditValue: json[DatabaseHelper.ezyCreditValue] ?? 0.0,
      salesDetails: [],
      salesPayment: []);
}

class SalesDetailWithReturn {
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
  double passReturnQty;
  double currentReturnQty;
  double baseQty;

  SalesDetailWithReturn({
    required this.salesDetailKey,
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
    required this.itemImage,
    required this.passReturnQty,
    required this.currentReturnQty,
    required this.baseQty,
  });

  SalesDetailWithReturn copyWith({
    String? salesDetailKey,
    String? salesKey,
    String? invoiceDoc,
    String? itemCode,
    String? itemDesc,
    String? itemDesc2,
    double? quantity,
    double? price,
    double? totalAmount,
    String? uom,
    double? discountValue,
    int? discountPercent,
    int? isDiscountInPercent,
    String? taxCode,
    double? taxAmount,
    int? taxRate,
    String? fromSalesKey,
    String? fromSalesDetailKey,
    String? promotionKey,
    String? promotionType,
    String? promotionDetailKey,
    double? promotionDiscount,
    String? itemImage,
    double? passReturnQty,
    double? currentReturnQty,
    double? baseQty,
  }) =>
      SalesDetailWithReturn(
        salesDetailKey: salesDetailKey ?? this.salesDetailKey,
        salesKey: salesKey ?? this.salesKey,
        invoiceDoc: invoiceDoc ?? this.invoiceDoc,
        itemCode: itemCode ?? this.itemCode,
        itemDesc: itemDesc ?? this.itemDesc,
        itemDesc2: itemDesc2 ?? this.itemDesc2,
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        totalAmount: totalAmount ?? this.totalAmount,
        uom: uom ?? this.uom,
        discountValue: discountValue ?? this.discountValue,
        discountPercent: discountPercent ?? this.discountPercent,
        isDiscountInPercent: isDiscountInPercent ?? this.isDiscountInPercent,
        taxCode: taxCode ?? this.taxCode,
        taxAmount: taxAmount ?? this.taxAmount,
        taxRate: taxRate ?? this.taxRate,
        fromSalesKey: fromSalesKey ?? this.fromSalesKey,
        fromSalesDetailKey: fromSalesDetailKey ?? this.fromSalesDetailKey,
        promotionKey: promotionKey ?? this.promotionKey,
        promotionType: promotionType ?? this.promotionType,
        promotionDetailKey: promotionDetailKey ?? this.promotionDetailKey,
        promotionDiscount: promotionDiscount ?? this.promotionDiscount,
        itemImage: itemImage ?? this.itemImage,
        passReturnQty: passReturnQty ?? this.passReturnQty,
        currentReturnQty: currentReturnQty ?? this.currentReturnQty,
        baseQty: baseQty ?? this.baseQty,
      );

  factory SalesDetailWithReturn.fromLocal(Map<String, dynamic> json) =>
      SalesDetailWithReturn(
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
        itemImage: json['itemImage'] ?? '',
        passReturnQty: 0.0,
        currentReturnQty: 0.0,
        baseQty: json['baseQty'] ?? 0.0,
      );

  Map<String, dynamic> toReturn() => {
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
    'fromSalesKey': salesKey,
    'fromSalesDetailKey': salesDetailKey,
    'promotionKey': promotionKey,
    'promotionType': promotionType,
    'promotionDetailKey': promotionDetailKey,
    'promotionDiscount': promotionDiscount,
    'itemImage': itemImage,
    'baseQty': baseQty,
  };
}

class CloudWrap {
  String appID;
  String token;
  String location;
  List<FullSalesDoc> salesDocsList;

  CloudWrap({
    required this.appID,
    required this.token,
    required this.location,
    required this.salesDocsList,
  });

  Map<String, dynamic> toCloud() => {
    "app_id": appID,
    "token": token,
    "location": location,
    "sales_list": salesDocsList.map((details) => details.toCloud()).toList()
  };
}

class EInvoiceHeaderModel {
  String SUP_UUID;
  String SALES_UUID;
  String RETURN_UUID;
  String APP_ID;
  String COUNTER_NO;
  String DOCNO;
  String DOCDATE;
  double SUBTOTAL;
  double TAXAMOUNT;
  double FOOTERDISCOUNT;
  double ROUNDING;
  double TOTAL;
  String CUST_NAME;
  String CUST_PHONE;
  String CUST_EMAIL;
  String CUST_ADD1;
  String CUST_ADD2;
  String CUST_ADD3;
  String CITY_NAME;
  String POSTCODE;
  String STATE;
  String TIN_NO;
  String REGISTRATION_SCHEME_ID;
  String REGISTRATION_NO;
  String SST_REGISTRATION_NO;
  double POINT_EARN;
  double POINT_REDEEM;
  double REDEEM_VALUE;
  String VOUCHER_CODE;
  double VOUCHER_VALUE;
  double CREDIT_VALUE;
  String IS_CONSOLIDATED_EINVOICE;
  String EINVOICE_DOC_NO;
  String EINVOICE_SUBMISSION_DATE;
  String EINVOICE_SUBMISSION_UID;
  String EINVOICE_DOCUMENT_UUID;
  String EINVOICE_STATUS;
  String EINVOICE_ERROR_LOG;
  String EINVOICE_REJECT_DATE;
  String EINVOICE_CANCEL_DATE;
  String EINVOICE_CANCEL_REASON;
  String URL_Link;
  String LOC_CODE;

  EInvoiceHeaderModel({
    required this.SUP_UUID,
    required this.SALES_UUID,
    required this.RETURN_UUID,
    required this.APP_ID,
    required this.COUNTER_NO,
    required this.DOCNO,
    required this.DOCDATE,
    required this.SUBTOTAL,
    required this.TAXAMOUNT,
    required this.FOOTERDISCOUNT,
    required this.ROUNDING,
    required this.TOTAL,
    required this.CUST_NAME,
    required this.CUST_PHONE,
    required this.CUST_EMAIL,
    required this.CUST_ADD1,
    required this.CUST_ADD2,
    required this.CUST_ADD3,
    required this.CITY_NAME,
    required this.POSTCODE,
    required this.STATE,
    required this.TIN_NO,
    required this.REGISTRATION_SCHEME_ID,
    required this.REGISTRATION_NO,
    required this.SST_REGISTRATION_NO,
    required this.POINT_EARN,
    required this.POINT_REDEEM,
    required this.REDEEM_VALUE,
    required this.VOUCHER_CODE,
    required this.VOUCHER_VALUE,
    required this.CREDIT_VALUE,
    required this.IS_CONSOLIDATED_EINVOICE,
    required this.EINVOICE_DOC_NO,
    required this.EINVOICE_SUBMISSION_DATE,
    required this.EINVOICE_SUBMISSION_UID,
    required this.EINVOICE_DOCUMENT_UUID,
    required this.EINVOICE_STATUS,
    required this.EINVOICE_ERROR_LOG,
    required this.EINVOICE_REJECT_DATE,
    required this.EINVOICE_CANCEL_DATE,
    required this.EINVOICE_CANCEL_REASON,
    required this.URL_Link,
    required this.LOC_CODE
  });

  factory EInvoiceHeaderModel.fromJson(Map<String, dynamic> json) => EInvoiceHeaderModel(
      SUP_UUID: json["SUP_UUID"] ?? '',
      SALES_UUID: json["SALES_UUID"] ?? '',
      RETURN_UUID: json["RETURN_UUID"] ?? '',
      APP_ID: json["APP_ID"] ?? '',
      COUNTER_NO: json["COUNTER_NO"] ?? '',
      DOCNO: json["DOCNO"] ?? '',
      DOCDATE: json["DOCDATE"] ?? '',
      SUBTOTAL: json["SUBTOTAL"] ?? 0.0,
      TAXAMOUNT: json["TAXAMOUNT"] ?? 0.0,
      FOOTERDISCOUNT: json["FOOTERDISCOUNT"] ?? 0.0,
      ROUNDING: json["ROUNDING"] ?? 0.0,
      TOTAL: json["TOTAL"] ?? 0.0,
      CUST_NAME: json["CUST_NAME"] ?? '',
      CUST_PHONE: json["CUST_PHONE"] ?? '',
      CUST_EMAIL: json["CUST_EMAIL"] ?? '',
      CUST_ADD1: json["CUST_ADD1"] ?? '',
      CUST_ADD2: json["CUST_ADD2"] ?? '',
      CUST_ADD3: json["CUST_ADD3"] ?? '',
      CITY_NAME: json["CITY_NAME"] ?? '',
      POSTCODE: json["POSTCODE"] ?? '',
      STATE: json["STATE"] ?? '',
      TIN_NO: json["TIN_NO"] ?? '',
      REGISTRATION_SCHEME_ID: json["REGISTRATION_SCHEME_ID"] ?? '',
      REGISTRATION_NO: json["REGISTRATION_NO"] ?? '',
      SST_REGISTRATION_NO: json["SST_REGISTRATION_NO"] ?? '',
      POINT_EARN: json["POINT_EARN"] ?? '',
      POINT_REDEEM: json["POINT_REDEEM"] ?? '',
      REDEEM_VALUE: json["REDEEM_VALUE"] ?? '',
      VOUCHER_CODE: json["VOUCHER_CODE"] ?? '',
      VOUCHER_VALUE: json["VOUCHER_VALUE"] ?? '',
      CREDIT_VALUE: json["CREDIT_VALUE"] ?? '',
      IS_CONSOLIDATED_EINVOICE: json["IS_CONSOLIDATED_EINVOICE"] ?? "N",
      EINVOICE_DOC_NO: json["EINVOICE_DOC_NO"] ?? '',
      EINVOICE_SUBMISSION_DATE: json["EINVOICE_SUBMISSION_DATE"] ?? '',
      EINVOICE_SUBMISSION_UID: json["EINVOICE_SUBMISSION_UID"] ?? '',
      EINVOICE_DOCUMENT_UUID: json["EINVOICE_DOCUMENT_UUID"] ?? '',
      EINVOICE_STATUS: json["EINVOICE_STATUS"] ?? '',
      EINVOICE_ERROR_LOG: json["EINVOICE_ERROR_LOG"] ?? '',
      EINVOICE_REJECT_DATE: json["EINVOICE_REJECT_DATE"] ?? '',
      EINVOICE_CANCEL_DATE: json["EINVOICE_CANCEL_DATE"] ?? '',
      EINVOICE_CANCEL_REASON: json["EINVOICE_CANCEL_REASON"] ?? '',
      URL_Link: json["URL_Link"] ?? '',
      LOC_CODE: json["LOC_CODE"] ?? ''
  );

  factory EInvoiceHeaderModel.fromDB(Map<String, dynamic> json) => EInvoiceHeaderModel(
      SUP_UUID: eInvoiceClientId,
      SALES_UUID: json['SalesKey'] ?? '',
      RETURN_UUID: json['SalesKey'] ?? '',
      APP_ID: appId,
      COUNTER_NO: systemCompanyProfile?.counter.toString().padLeft(2, '0') ?? '',
      DOCNO: json['InvoiceNum'] ?? '',
      DOCDATE: json['DocDate'] ?? '',
      SUBTOTAL: json["Subtotal"] ?? 0.0,
      TAXAMOUNT: json["TaxAmount"] ?? 0.0,
      FOOTERDISCOUNT: json["FooterDiscount"] ?? 0.0,
      ROUNDING: json["Rounding"] ?? 0.0,
      TOTAL: json["DocTotal"] ?? 0.0,
      CUST_NAME: json["CustomerName"] ?? '',
      CUST_PHONE: json["CustomerPhone"] ?? '',
      CUST_EMAIL: json["CustomerEmail"] ?? '',
      CUST_ADD1: json["CustomerAddress1"] ?? '',
      CUST_ADD2: json["CustomerAddress2"] ?? '',
      CUST_ADD3: json["CustomerAddress3"] ?? '',
      CITY_NAME: '',
      POSTCODE: '',
      STATE: '',
      TIN_NO: json["CustomerTin"] ?? '',
      REGISTRATION_SCHEME_ID: '',
      REGISTRATION_NO: json["CustomerIdentification"] ?? '',
      SST_REGISTRATION_NO: '',
      POINT_EARN: 0.0,
      POINT_REDEEM: 0.0,
      REDEEM_VALUE: 0.0,
      VOUCHER_CODE: '',
      VOUCHER_VALUE: 0.0,
      CREDIT_VALUE: 0.0,
      IS_CONSOLIDATED_EINVOICE: "N",
      EINVOICE_DOC_NO: '',
      EINVOICE_SUBMISSION_DATE: '',
      EINVOICE_SUBMISSION_UID: '',
      EINVOICE_DOCUMENT_UUID: '',
      EINVOICE_STATUS: '',
      EINVOICE_ERROR_LOG: '',
      EINVOICE_REJECT_DATE: '',
      EINVOICE_CANCEL_DATE: '',
      EINVOICE_CANCEL_REASON: '',
      URL_Link: '',
      LOC_CODE: systemCompanyProfile!.locationCode
  );

  Map<String, dynamic> toJson() => {
    'SUP_UUID': SUP_UUID,
    'SALES_UUID': SALES_UUID,
    'RETURN_UUID': RETURN_UUID,
    'APP_ID': APP_ID,
    'COUNTER_NO': COUNTER_NO,
    'DOCNO': DOCNO,
    'DOCDATE': DOCDATE,
    'SUBTOTAL': SUBTOTAL,
    'TAXAMOUNT': TAXAMOUNT,
    'FOOTERDISCOUNT': FOOTERDISCOUNT,
    'ROUNDING': ROUNDING,
    'TOTAL': TOTAL,
    'CUST_NAME': CUST_NAME,
    'CUST_PHONE': CUST_PHONE,
    'CUST_EMAIL': CUST_EMAIL,
    'CUST_ADD1': CUST_ADD1,
    'CUST_ADD2': CUST_ADD2,
    'CUST_ADD3': CUST_ADD3,
    'CITY_NAME': CITY_NAME,
    'POSTCODE': POSTCODE,
    'STATE': STATE,
    'TIN_NO': TIN_NO,
    'REGISTRATION_SCHEME_ID': REGISTRATION_SCHEME_ID,
    'REGISTRATION_NO': REGISTRATION_NO,
    'SST_REGISTRATION_NO': SST_REGISTRATION_NO,
    'POINT_EARN': POINT_EARN,
    'POINT_REDEEM': POINT_REDEEM,
    'REDEEM_VALUE': REDEEM_VALUE,
    'VOUCHER_CODE': VOUCHER_CODE,
    'VOUCHER_VALUE': VOUCHER_VALUE,
    'CREDIT_VALUE': CREDIT_VALUE,
    'IS_CONSOLIDATED_EINVOICE': IS_CONSOLIDATED_EINVOICE,
    'EINVOICE_DOC_NO': EINVOICE_DOC_NO,
    'EINVOICE_SUBMISSION_DATE': EINVOICE_SUBMISSION_DATE,
    'EINVOICE_SUBMISSION_UID': EINVOICE_SUBMISSION_UID,
    'EINVOICE_DOCUMENT_UUID': EINVOICE_DOCUMENT_UUID,
    'EINVOICE_STATUS': EINVOICE_STATUS,
    'EINVOICE_ERROR_LOG': EINVOICE_ERROR_LOG,
    'EINVOICE_REJECT_DATE': EINVOICE_REJECT_DATE,
    'EINVOICE_CANCEL_DATE': EINVOICE_CANCEL_DATE,
    'EINVOICE_CANCEL_REASON': EINVOICE_CANCEL_REASON,
    'URL_Link': URL_Link,
    'LOC_CODE': LOC_CODE
  };
}
