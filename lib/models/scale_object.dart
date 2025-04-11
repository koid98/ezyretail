class IminScaleObj {
  final String weight;
  final String weightStatus;

  IminScaleObj(this.weight, this.weightStatus);

  factory IminScaleObj.fromJson(Map<String, dynamic> json) {
    return IminScaleObj(json["weight"], json["weightStatus"]);
  }
}

class ScaleObject {
  final int? decimalDigit;
  final int barcodeLength;
  final bool enableDeptCode;
  final int codeStart;
  final int codeEnd;
  final bool enableQty;
  final int qtyStart;
  final int qtyEnd;
  final int qtyDecimalDigit;
  final bool enablePrice;
  final bool isUnitPrice;
  final int priceStart;
  final int priceEnd;
  final int priceDecimalDigit;

  ScaleObject({
    this.decimalDigit,
    required this.barcodeLength,
    required this.enableDeptCode,
    required this.codeStart,
    required this.codeEnd,
    required this.enableQty,
    required this.qtyStart,
    required this.qtyEnd,
    required this.qtyDecimalDigit,
    required this.enablePrice,
    required this.isUnitPrice,
    required this.priceStart,
    required this.priceEnd,
    required this.priceDecimalDigit,
  });

  factory ScaleObject.fromJson(Map<String, dynamic> json) => ScaleObject(
    decimalDigit: json["decimal_digit"],
    barcodeLength: json["barcode_length"],
    enableDeptCode: json["enable_dept_code"],
    codeStart: json["code_start"],
    codeEnd: json["code_end"],
    enableQty: json["enable_qty"],
    qtyStart: json["qty_start"],
    qtyEnd: json["qty_end"],
    qtyDecimalDigit: json["qty_decimal_digit"],
    enablePrice: json["enable_price"],
    isUnitPrice: json["is_unit_price"],
    priceStart: json["price_start"],
    priceEnd: json["price_end"],
    priceDecimalDigit: json["price_decimal_digit"],
  );
}
