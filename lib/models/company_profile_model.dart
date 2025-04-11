
import 'package:ezyretail/helpers/sqflite_helper.dart';

class CompanyProfileModel {
  String token;
  String name;
  String tax;
  String tin;
  int counter;
  String label;
  String roc;
  String add1;
  String add2;
  String add3;
  String add4;
  String phone;
  String email;
  String locationCode;
  String postcode;
  String city;
  String state;
  String country;

  // {token: 09A17F2F-B0C8-44A9-B6BC-8136BD57DBBA, name: Johor Bahru, tax: sdsdsd, counter: 4, label: HQ, roc: 200301008596, add1: ddd, add2: ssss, add3: ssss, add4: ssssss, phone: 1234, email: 11111, location: JB, tin: C26273998040, poscode: 81100, city: Johor Bahru, state: Johor, country: MY}

  CompanyProfileModel({
    required this.token,
    required this.name,
    required this.tax,
    required this.tin,
    required this.counter,
    required this.label,
    required this.roc,
    required this.add1,
    required this.add2,
    required this.add3,
    required this.add4,
    required this.phone,
    required this.email,
    required this.locationCode,
    required this.postcode,
    required this.city,
    required this.state,
    required this.country,
  });

  factory CompanyProfileModel.fromJson(Map<String, dynamic> json) =>
      CompanyProfileModel(
        token: json["token"],
        name: json["name"],
        tax: json["tax"],
        tin: json["tin"] ?? "",
        counter: json["counter"],
        label: json["label"],
        roc: json["roc"] ?? "",
        add1: json["add1"] ?? "",
        add2: json["add2"] ?? "",
        add3: json["add3"] ?? "",
        add4: json["add4"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        locationCode: json["location"] ?? "",
        postcode: json["postcode"] ?? "",
        city: json["location"] ?? "",
        state: json["location"] ?? "",
        country: json["location"] ?? "",
      );

  factory CompanyProfileModel.fromCloud(Map<String, dynamic> json) =>
      CompanyProfileModel(
        token: json["id"].toString(),
        name: json["company_name"],
        tax: json["company_tax_no"],
        tin: json["company_tin"] ?? "",
        counter: int.parse(json["counter_no"] ?? 1.toString()),
        label: json["location_label"],
        roc: json["roc"] ?? "",
        add1: json["address1"] ?? "",
        add2: json["address2"] ?? "",
        add3: json["address3"] ?? "",
        add4: json["address4"] ?? "",
        phone: json["contact_number"] ?? "",
        email: json["email"] ?? "",
        locationCode: json["location"] ?? "",
        postcode: json["location"] ?? "",
        city: json["location"] ?? "",
        state: json["location"] ?? "",
        country: json["location"] ?? "",
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["token"] = token;
    data["name"] = name;
    data["tax"] = tax;
    data["tin"] = tin;
    data["counter"] = counter;
    data["label"] = label;
    data["roc"] = roc;
    data["add1"] = add1;
    data["add2"] = add2;
    data["add3"] = add3;
    data["add4"] = add4;
    data["phone"] = phone;
    data["email"] = email;
    return data;
  }

  factory CompanyProfileModel.fromDB(Map<String, dynamic> json) =>
      CompanyProfileModel(
        token: json[DatabaseHelper.token],
        name: json[DatabaseHelper.companyName],
        tax: json[DatabaseHelper.companyTaxNo],
        tin: json[DatabaseHelper.companyTin],
        counter: json[DatabaseHelper.counter],
        label: json[DatabaseHelper.label],
        roc: json[DatabaseHelper.companyRoc],
        add1: json[DatabaseHelper.companyAddress1],
        add2: json[DatabaseHelper.companyAddress2],
        add3: json[DatabaseHelper.companyAddress3],
        add4: json[DatabaseHelper.companyAddress4],
        phone: json[DatabaseHelper.companyPhone],
        email: json[DatabaseHelper.companyEmail],
        locationCode: json[DatabaseHelper.location] ?? "",
        postcode: json[DatabaseHelper.posCode] ?? "",
        city: json[DatabaseHelper.city] ?? "",
        state: json[DatabaseHelper.state] ?? "",
        country: json[DatabaseHelper.country] ?? "",
      );

  Map<String, dynamic> toDB() {
    return {
      DatabaseHelper.token: token,
      DatabaseHelper.companyName: name,
      DatabaseHelper.companyTaxNo: tax,
      DatabaseHelper.companyTin: tin,
      DatabaseHelper.counter: counter,
      DatabaseHelper.label: label,
      DatabaseHelper.companyRoc: roc,
      DatabaseHelper.companyAddress1: add1,
      DatabaseHelper.companyAddress2: add2,
      DatabaseHelper.companyAddress3: add3,
      DatabaseHelper.companyAddress4: add4,
      DatabaseHelper.companyPhone: phone,
      DatabaseHelper.companyEmail: email,
      DatabaseHelper.location: locationCode,
      DatabaseHelper.posCode: postcode,
      DatabaseHelper.city: city,
      DatabaseHelper.state: state,
      DatabaseHelper.country: country,
    };
  }

  CompanyProfileModel copyWith(
          {String? token,
          String? name,
          String? tax,
          String? tin,
          int? counter,
          String? label,
          String? roc,
          String? add1,
          String? add2,
          String? add3,
          String? add4,
          String? phone,
          String? email,
          String? locationCode,
          String? postcode,
          String? city,
          String? state,
          String? country}) =>
      CompanyProfileModel(
          token: token ?? this.token,
          name: name ?? this.name,
          tax: tax ?? this.tax,
          tin: tin ?? this.tin,
          counter: counter ?? this.counter,
          label: label ?? this.label,
          roc: roc ?? this.roc,
          add1: add1 ?? this.add1,
          add2: add2 ?? this.add2,
          add3: add3 ?? this.add3,
          add4: add4 ?? this.add4,
          phone: phone ?? this.phone,
          email: email ?? this.email,
          locationCode: locationCode ?? this.locationCode,
          postcode: locationCode ?? this.locationCode,
          city: city ?? this.city,
          state: state ?? this.state,
          country: country ?? this.country);
}

class CompanyRegisterModel {
  String appId;
  String companyName;
  String customerName;
  String email;
  String contactNumber;
  String roc;
  String address1;
  String address2;
  String address3;
  String address4;
  String postcode;
  String city;
  String state;
  String country;

  CompanyRegisterModel({
    required this.appId,
    required this.companyName,
    required this.customerName,
    required this.email,
    required this.contactNumber,
    required this.roc,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.address4,
    required this.postcode,
    required this.city,
    required this.state,
    required this.country,
  });
}
