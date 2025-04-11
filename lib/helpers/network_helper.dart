import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart';
import '../models/company_profile_model.dart';
import '../models/dealer_model.dart';
import '../models/user_model.dart';

class NetWorkHelper {
  final dio = Dio();

  Future<String> checkLicenceKey(String deviceInfo) async {
    String result = "";

    dio.options.connectTimeout = const Duration(seconds: 10);

    try {
      String url =
          "https://ezypos.ezysolutions.com.my/api/check-ezypos-license";

      Map<String, dynamic> queryParams = jsonDecode(deviceInfo);

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resData = response.data;
        String tmpLicenceType = resData["license_type"];

        final prefs = await SharedPreferences.getInstance();
        switch (tmpLicenceType.toLowerCase()) {
          case "standalone":
            prefs.setInt("licenceMode", 0);
            licenceMode = 0;
            break;
          case "local":
            prefs.setInt("licenceMode", 1);
            licenceMode = 1;
            break;
          case "online":
            prefs.setInt("licenceMode", 3);
            licenceMode = 3;
            break;
          default:
            prefs.setInt("licenceMode", 5);
            licenceMode = 5;
        }

        String jsonString = jsonEncode(resData["customer"]);

        result = jsonString;
      } else if (response.statusCode == 203) {
        Map<String, dynamic> resData = response.data;
        result = resData["status"];
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String> activateLicenceOnly(String appID, String licenseKey) async {
    String result = "";
    try {
      String url =
          "https://ezypos.ezysolutions.com.my/api/check-ezypos-license";

      Map<String, String> queryParams = {
        'app_id': appID,
        'license_key': licenseKey,
      };

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("MachineId", appID);
        prefs.setString("LicenseKey", licenseKey);

        Map<String, dynamic> resData = response.data;

        String tempLicenseType = resData["license_type"];

        switch (tempLicenseType.toLowerCase()) {
          case "standalone":
            prefs.setInt("licenceMode", 0);
            licenceMode = 0;
            break;
          case "local":
            prefs.setInt("licenceMode", 1);
            licenceMode = 1;
            break;
          case "online":
            prefs.setInt("licenceMode", 3);
            licenceMode = 3;
            break;
          default:
            prefs.setInt("licenceMode", 5);
            licenceMode = 5;
        }

        Map<String, dynamic> customerData = resData["customer"];

        CompanyProfileModel compProfile = CompanyProfileModel(
          token: customerData["customer_id"],
          name: customerData["company_name"],
          tax: '',
          tin: '',
          counter: 1,
          label: 'EZ',
          roc: customerData["roc"],
          add1: customerData["address1"],
          add2: customerData["address2"],
          add3: customerData["address3"],
          add4: customerData["address4"],
          phone: customerData["contact_number"],
          email: customerData["email"],
          locationCode: "-",
          postcode: customerData["posCode"] ?? "",
          city: customerData["city"] ?? "",
          state: customerData["state"] ?? "",
          country: customerData["country"] ?? "",
        );

        if (await DatabaseHelper.instance.dropProfileTable()) {
          await DatabaseHelper.instance.insertCompanyProfile(compProfile);
        }

        systemCompanyProfile = compProfile;

        result = "SUCCESS";
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> activateLicenceAndReset(
      String appID, String licenseKey) async {
    String result = "";
    try {
      String url =
          "https://ezypos.ezysolutions.com.my/api/check-ezypos-license";

      Map<String, String> queryParams = {
        'app_id': appID,
        'license_key': licenseKey,
      };

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        prefs.setString("MachineId", appID);
        prefs.setString("LicenseKey", licenseKey);

        List<UsersModel> userList = [];

        await DatabaseHelper.instance.dropAllTable();

        UsersModel defaultUser = UsersModel(
            userKey: 'ADMIN',
            name: 'ADMIN',
            password: 'Admin',
            access: 1,
            pin: '1234');

        userList.add(defaultUser);

        await DatabaseHelper.instance.insertUserList(userList);

        Map<String, dynamic> resData = response.data;

        String tempLicenseType = resData["license_type"];

        switch (tempLicenseType.toLowerCase()) {
          case "standalone":
            prefs.setInt("licenceMode", 0);
            licenceMode = 0;
            break;
          case "local":
            prefs.setInt("licenceMode", 1);
            licenceMode = 1;
            break;
          case "online":
            prefs.setInt("licenceMode", 3);
            licenceMode = 3;
            break;
          default:
            prefs.setInt("licenceMode", 5);
            licenceMode = 5;
        }

        Map<String, dynamic> customerData = resData["customer"];

        CompanyProfileModel compProfile = CompanyProfileModel(
          token: customerData["customer_id"],
          name: customerData["company_name"],
          tax: '',
          tin: customerData["tin"],
          counter: 1,
          label: 'EZ',
          roc: customerData["roc"],
          add1: customerData["address1"],
          add2: customerData["address2"],
          add3: customerData["address3"],
          add4: customerData["address4"],
          phone: customerData["contact_number"],
          email: customerData["email"],
          locationCode: "-",
          postcode: customerData["postcode"],
          city: customerData["city"],
          state: customerData["state"],
          country: customerData["country"],
        );

        if (await DatabaseHelper.instance.dropProfileTable()) {
          await DatabaseHelper.instance.insertCompanyProfile(compProfile);
        }

        systemCompanyProfile = compProfile;

        result = "SUCCESS";
      } else {
        // result = "${response.statusCode} ${response.data}";
        result = "${response.data['message']}";
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  Future<String> checkValidDealer(DealerModel dealerInfo) async {
    String result = "";

    try {
      String url =
          "https://ezypos.ezysolutions.com.my/api/check-delear-account";

      Map<String, String> queryParams = {
        "email": dealerInfo.dealerId,
        "password": dealerInfo.dealerPassword,
        "app_id": dealerInfo.appId,
        "license_key": dealerInfo.licenceKey
      };

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        result = "SUCCESS";
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String> changeAppEdition(
      DealerModel dealerInfo, String appEdition) async {
    String result = "";

    try {
      String url = "https://ezypos.ezysolutions.com.my/api/verify-dealer";

      Map<String, String> queryParams = {
        "email": dealerInfo.dealerId,
        "password": dealerInfo.dealerPassword,
        "app_id": dealerInfo.appId,
        "license_key": dealerInfo.licenceKey,
        "license_type": appEdition
      };

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        result = "SUCCESS";
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String> registerTrial(
      CompanyRegisterModel companyRegisterModelInfo) async {
    String result = "";

    try {
      String url = "https://ezypos.ezysolutions.com.my/api/registerTrialEzyPos";

      Map<String, String> queryParams = {
        "app_id": companyRegisterModelInfo.appId,
        "company_name": companyRegisterModelInfo.companyName,
        "customer_name": companyRegisterModelInfo.customerName,
        "email": companyRegisterModelInfo.email,
        "contact_number": companyRegisterModelInfo.contactNumber,
        "roc": "",
        "address1": companyRegisterModelInfo.address1,
        "address2": companyRegisterModelInfo.address2,
        "address3": companyRegisterModelInfo.address3,
        "address4": companyRegisterModelInfo.address4,
        "postcode": companyRegisterModelInfo.postcode,
        "city": companyRegisterModelInfo.city,
        "state": companyRegisterModelInfo.state,
        "country": companyRegisterModelInfo.country
      };

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        var returnObj = response.data;
        DateTime expDate = DateTime.parse(returnObj['expired_date']);

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("trialExpDate", expDate.toIso8601String());
        await prefs.setInt("licenceMode", 0);

        licenceMode = 0;

        await DatabaseHelper.instance.dropAllTable();

        CompanyProfileModel compProfile = CompanyProfileModel(
          token: companyRegisterModelInfo.appId,
          name: companyRegisterModelInfo.companyName,
          tax: '',
          tin: '',
          counter: 1,
          label: 'EZ',
          roc: "",
          add1: companyRegisterModelInfo.address1,
          add2: companyRegisterModelInfo.address2,
          add3: companyRegisterModelInfo.address3,
          add4: companyRegisterModelInfo.address4,
          phone: companyRegisterModelInfo.contactNumber,
          email: companyRegisterModelInfo.email,
          locationCode: '-',
          postcode: companyRegisterModelInfo.postcode,
          city: companyRegisterModelInfo.city,
          state: companyRegisterModelInfo.state,
          country: companyRegisterModelInfo.country,
        );

        if (await DatabaseHelper.instance.dropProfileTable()) {
          await DatabaseHelper.instance.insertCompanyProfile(compProfile);
        }

        systemCompanyProfile = compProfile;

        List<UsersModel> userList = [];

        UsersModel defaultUser = UsersModel(
            userKey: 'ADMIN',
            name: 'ADMIN',
            password: 'Admin',
            access: 1,
            pin: '1234');

        userList.add(defaultUser);

        await DatabaseHelper.instance.insertUserList(userList);

        result = returnObj['status'];
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<bool> verifyRegisteredEmail(String deviceInfo, String regEmail) async {
    bool result = false;

    try {
      String url =
          "https://ezypos.ezysolutions.com.my/api/check-ezypos-license";

      Map<String, dynamic> queryParams = jsonDecode(deviceInfo);

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> resData = response.data;
        String validEmail = resData["customer"]["email"];

        if (validEmail.toLowerCase() == regEmail.toLowerCase()) {
          result = true;
        }
      }
    } catch (e) {
      print(e.toString());
    }

    return result;
  }

  Future<String> resetPassword(DealerModel dealerInfo) async {
    String result = "";

    try {
      String url = "https://ezypos.ezysolutions.com.my/api/reset-password";

      Map<String, String> queryParams = {
        "app_id": dealerInfo.appId,
        "license_key": dealerInfo.licenceKey,
        "password": dealerInfo.dealerPassword,
      };

      String param = jsonEncode(queryParams);

      final response = await dio.post(
        url,
        data: param,
      );

      if (response.statusCode == 205) {
        result = "SUCCESS";
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<String> getIPAddress() async {
    for (var interface in await NetworkInterface.list()) {
      for (var address in interface.addresses) {
        // Check if the address is IPv4 and not loopback address
        if (address.type == InternetAddressType.IPv4 && !address.isLoopback) {
          return address.address;
        }
      }
    }
    return '';
  }
}
