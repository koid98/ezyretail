import 'package:ezyretail/helpers/sqflite_helper.dart';

class CustomerModel {
  String customerCode;
  String customerName;
  String customerName2;
  String customerPhone;
  String customerMobile;
  String customerEmail;
  String customerAddress1;
  String customerAddress2;
  String customerAddress3;
  String customerAddress4;
  String posCode;
  String city;
  String state;
  String country;
  String customerRegistrationNum;
  String customerMSIC;
  String customerTin;
  String customerSST;
  String customerStatus;
  String priceTag;

  CustomerModel({
    required this.customerCode,
    required this.customerName,
    required this.customerName2,
    required this.customerPhone,
    required this.customerMobile,
    required this.customerEmail,
    required this.customerAddress1,
    required this.customerAddress2,
    required this.customerAddress3,
    required this.customerAddress4,
    required this.posCode,
    required this.city,
    required this.state,
    required this.country,
    required this.customerRegistrationNum,
    required this.customerMSIC,
    required this.customerTin,
    required this.customerSST,
    required this.customerStatus,
    required this.priceTag,
  });

  factory CustomerModel.fromLinkTools(Map<String, dynamic> json) =>
      CustomerModel(
        customerCode: json["CODE"],
        customerName: json["CompanyName"],
        customerName2: json["CompanyName2"] ?? "",
        customerPhone: json["Phone1"] ?? "",
        customerMobile: json["Mobile"] ?? "",
        customerEmail: json["Email"] ?? "",
        customerAddress1: json["Address1"] ?? "",
        customerAddress2: json["Address2"] ?? "",
        customerAddress3: json["Address3"] ?? "",
        customerAddress4: json["Address4"] ?? "",
        posCode: json["Postcode"] ?? "",
        city: json["City"] ?? "",
        state: json["State"] ?? "",
        country: json["Country"] ?? "",
        customerRegistrationNum: json["RRN"] ?? "",
        customerMSIC: json["IndustryCode"] ?? "",
        customerSST: json["TaxID"] ?? "",
        customerTin: json["TinNumber"] ?? "",
        customerStatus: json["Status"] ?? "A",
        priceTag: json["PriceTag"] ?? "",
      );

  factory CustomerModel.fromDB(Map<String, dynamic> json) => CustomerModel(
    customerCode: json[DatabaseHelper.customerCode] ?? "",
    customerName: json[DatabaseHelper.customerName] ?? "",
    customerName2: json[DatabaseHelper.customerName2] ?? "",
    customerPhone: json[DatabaseHelper.customerPhone] ?? "",
    customerMobile: json[DatabaseHelper.customerMobile] ?? "",
    customerEmail: json[DatabaseHelper.customerEmail] ?? "",
    customerAddress1: json[DatabaseHelper.customerAddress1] ?? "",
    customerAddress2: json[DatabaseHelper.customerAddress2] ?? "",
    customerAddress3: json[DatabaseHelper.customerAddress3] ?? "",
    customerAddress4: json[DatabaseHelper.customerAddress4] ?? "",
    posCode: json[DatabaseHelper.posCode] ?? "",
    city: json[DatabaseHelper.city] ?? "",
    state: json[DatabaseHelper.state] ?? "",
    country: json[DatabaseHelper.country] ?? "",
    customerRegistrationNum:
    json[DatabaseHelper.customerRegistrationNum] ?? "",
    customerMSIC: json[DatabaseHelper.industryCode] ?? "",
    customerSST: json[DatabaseHelper.customerSST] ?? "",
    customerTin: json[DatabaseHelper.customerTin] ?? "",
    customerStatus: json[DatabaseHelper.customerStatus] ?? "A",
    priceTag: json[DatabaseHelper.priceTag] ?? "",
  );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.customerCode: customerCode,
      DatabaseHelper.customerName: customerName,
      DatabaseHelper.customerName2: customerName2,
      DatabaseHelper.customerRegistrationNum: customerRegistrationNum,
      DatabaseHelper.industryCode: customerMSIC,
      DatabaseHelper.customerPhone: customerPhone,
      DatabaseHelper.customerMobile: customerMobile,
      DatabaseHelper.customerEmail: customerEmail,
      DatabaseHelper.customerAddress1: customerAddress1,
      DatabaseHelper.customerAddress2: customerAddress2,
      DatabaseHelper.customerAddress3: customerAddress3,
      DatabaseHelper.customerAddress4: customerAddress4,
      DatabaseHelper.posCode: posCode,
      DatabaseHelper.city: city,
      DatabaseHelper.state: state,
      DatabaseHelper.country: country,
      DatabaseHelper.customerTin: customerTin,
      DatabaseHelper.customerSST: customerSST,
      DatabaseHelper.customerStatus: customerStatus,
      DatabaseHelper.priceTag: priceTag,
    };
  }

  Map<String, dynamic> toLinkTools() => {
    'CustomerCode': customerCode,
    'CustomerName': customerName,
    'CustomerName2': customerName2,
    'BRN': customerRegistrationNum,
    'IndustryCode': customerMSIC,
    'CustomerPhone': customerPhone,
    'CustomerMobile': customerMobile,
    'Email': customerEmail,
    'CustomerAddress1': customerAddress1,
    'CustomerAddress2': customerAddress2,
    'CustomerAddress3': customerAddress3,
    'CustomerAddress4': customerAddress4,
    'CustomerPostcode': posCode,
    'CustomerCity': city,
    'CustomerState': state,
    'CustomerCountry': "",
    'TinNumber': customerTin,
    'SalesTax': customerSST
  };
}

class EInvoiceCustomerModel {
  String customerName;
  String customerPhone;
  String customerAddress1;
  String customerAddress2;
  String customerAddress3;
  String customerAddress4;
  String customerEmail;
  String customerTin;
  String customerIcNum;
  String customerSST;

  EInvoiceCustomerModel({
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress1,
    required this.customerAddress2,
    required this.customerAddress3,
    required this.customerAddress4,
    required this.customerEmail,
    required this.customerTin,
    required this.customerIcNum,
    required this.customerSST,
  });
}

class MemberModel {
  String memberCode;
  String memberName;
  String memberType;
  String memberPhone;
  String memberEmail;
  String memberAddress1;
  String memberAddress2;
  String memberAddress3;
  String memberAddress4;
  String memberIdentificationNum;
  String memberTin;
  String memberExpiryDate;
  int memberStatus;
/*  String companyName;
  String companyPhone;
  String companyEmail;
  String companyAddress1;
  String companyAddress2;
  String companyAddress3;
  String companyAddress4;
  String companyRegistrationNum;
  String companyTin;
  String companySST;*/

  MemberModel(
      {required this.memberCode,
        required this.memberName,
        required this.memberType,
        required this.memberPhone,
        required this.memberEmail,
        required this.memberAddress1,
        required this.memberAddress2,
        required this.memberAddress3,
        required this.memberAddress4,
        required this.memberIdentificationNum,
        required this.memberTin,
        required this.memberExpiryDate,
        required this.memberStatus});

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
      memberCode: json["code"] ?? "",
      memberName: json["name"] ?? "",
      memberType: json["card_type"] ?? "",
      memberPhone: json["phone_number1"] ?? "",
      memberEmail: json["email"] ?? "",
      memberAddress1: json["address1"] ?? "",
      memberAddress2: json["address2"] ?? "",
      memberAddress3: json["address3"] ?? "",
      memberAddress4: json["address4"] ?? "",
      memberIdentificationNum: json["personal_registration_number"] ?? "",
      memberTin: json["personal_tin_number"] ?? "",
      memberExpiryDate: DateTime(int.parse(json['member_card_year'] ?? "0"),
          int.parse(json['member_card_month'] ?? "0") + 1, 0)
          .toString(),
      memberStatus: int.parse((json["status"] ?? "1").toString()));

  factory MemberModel.fromDB(Map<String, dynamic> json) => MemberModel(
      memberCode: json[DatabaseHelper.memberId] ?? "",
      memberName: json[DatabaseHelper.memberName] ?? "",
      memberType: json[DatabaseHelper.memberType] ?? "",
      memberPhone: json[DatabaseHelper.memberPhone] ?? "",
      memberEmail: json[DatabaseHelper.memberEmail] ?? "",
      memberAddress1: json[DatabaseHelper.memberAddress1] ?? "",
      memberAddress2: json[DatabaseHelper.memberAddress2] ?? "",
      memberAddress3: json[DatabaseHelper.memberAddress3] ?? "",
      memberAddress4: json[DatabaseHelper.memberAddress4] ?? "",
      memberIdentificationNum:
      json[DatabaseHelper.memberIdentificationNum] ?? "",
      memberTin: json[DatabaseHelper.memberTin] ?? "",
      memberExpiryDate: json[DatabaseHelper.expiryDate] ?? "",
      memberStatus: json[DatabaseHelper.isActive] ?? 1);

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.memberId: memberCode,
      DatabaseHelper.memberName: memberName,
      DatabaseHelper.memberType: memberType,
      DatabaseHelper.memberPhone: memberPhone,
      DatabaseHelper.memberEmail: memberEmail,
      DatabaseHelper.memberAddress1: memberAddress1,
      DatabaseHelper.memberAddress2: memberAddress2,
      DatabaseHelper.memberAddress3: memberAddress3,
      DatabaseHelper.memberAddress4: memberAddress4,
      DatabaseHelper.memberIdentificationNum: memberIdentificationNum,
      DatabaseHelper.memberTin: memberTin,
      DatabaseHelper.expiryDate: memberExpiryDate,
      DatabaseHelper.isActive: memberStatus
    };
  }
}

class PostMember {
  String docNo;
  double docAmount;
  String action;
  String code;
  String point;
  String counterCode;
  String dateTime;
  String status;
  String syncTime;

  PostMember(
      {required this.docNo,
        required this.docAmount,
        required this.action,
        required this.code,
        required this.point,
        required this.counterCode,
        required this.dateTime,
        required this.status,
        required this.syncTime});

  factory PostMember.fromDB(Map<String, dynamic> json) => PostMember(
      docNo: json[DatabaseHelper.docNo] ?? "",
      docAmount: json[DatabaseHelper.docAmount] ?? 0.0,
      action: json[DatabaseHelper.description] ?? "",
      code: json[DatabaseHelper.memberId] ?? "",
      point: json[DatabaseHelper.memberPoint] ?? "",
      counterCode: json[DatabaseHelper.counter] ?? "",
      dateTime: json[DatabaseHelper.docDate] ?? "",
      status: json[DatabaseHelper.status] ?? "",
      syncTime: json[DatabaseHelper.syncTime] ?? "");

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.docNo: docNo,
      DatabaseHelper.docAmount: docAmount,
      DatabaseHelper.description: action,
      DatabaseHelper.memberId: code,
      DatabaseHelper.memberPoint: point,
      DatabaseHelper.counter: counterCode,
      DatabaseHelper.docDate: dateTime,
      DatabaseHelper.status: status,
      DatabaseHelper.syncTime: syncTime
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'DocNo': docNo,
      'doc_amount': docAmount,
      'action': action,
      'code': code,
      'point': point,
      'counter_code': counterCode,
      'date_time': dateTime,
      'syncTime': syncTime
    };
  }
}
