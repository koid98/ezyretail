import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/cash_io_model.dart';
import '../models/sales.dart';
import 'image_upload_api.dart';

import "package:path/path.dart" as path;

//*************************************
// UPLOAD SALES DOCUMENT
//*************************************

Future<String> uploadSalesDocToCloud(
    String url, String bearerToken, CloudWrap salesDocs) async {
  final dio = Dio();

  String result = "";

  try {
    final response = await dio.post(url,
        data: salesDocs.toCloud(),
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $bearerToken",
        }));

    if (response.statusCode == 200) {
      result = "SUCCESS";
    } else {
      result = "${response.statusCode} ${response.data}";
    }
  } on DioException catch (e) {
    result = e.response?.data['message'];
  } catch (e) {
    result = e.toString();
  }

  return result;
}

//*************************************
// UPLOAD CASH IO
//*************************************

Future<String> uploadCashIoRec(String url, String imgUrl, String host,
    String key, List<CashIoUploadModel> docList, Directory tempDir) async {
  log("isolate cash io is running");

  final dio = Dio();

  String result = "";
  String salesHeaderListString = jsonEncode(docList);

  try {
    final response = await dio.post(
      url,
      data: salesHeaderListString,
    );

    if (response.statusCode == 200) {
      // Directory tempDir = await getTemporaryDirectory();

      for (CashIoUploadModel temp in docList) {
        try {
          if (temp.attachment != null) {
            final String filePath =
            path.join(tempDir.path, "${temp.docNo}.png");

            final File file = File(filePath);
            await file.writeAsBytes(temp.attachment!);

            await uploadAtchToLinkToolsFunction(
                imgUrl, host, key, temp.docNo, file);

            if (await file.exists()) {
              await file.delete();
            }

            await Future.delayed(const Duration(milliseconds: 100));
          }
        } catch (ex) {
          debugPrint(ex.toString());
        }
      }

      result = "SUCCESS";
    } else {
      result = "${response.statusCode} ${response.data}";
    }
  } catch (e) {
    result = e.toString();
  }

  return result;
}

Future<String> uploadCashIoRecToCloud(
    String url,
    String imgUrl,
    String bearerToken,
    List<CashIoUploadModel> docList,
    Directory tempDir) async {
  final dio = Dio();

  String result = "";
  String salesHeaderListString = jsonEncode(docList);

  try {
    var response = await dio.post(url,
        data: salesHeaderListString,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $bearerToken",
        }));

    if (response.statusCode == 200) {
      result = "SUCCESS";

      for (CashIoUploadModel temp in docList) {
        try {
          if (temp.attachment != null) {
            final String filePath =
            path.join(tempDir.path, "${temp.docNo}.png");

            final File file = File(filePath);
            await file.writeAsBytes(temp.attachment!);

            await uploadAtchToCloudFunction(imgUrl, temp.docNo, file);

            if (await file.exists()) {
              await file.delete();
            }
          }
        } catch (ex) {
          debugPrint(ex.toString());
        }
      }
    } else {
      result = "${response.statusCode} ${response.data}";
    }
  } catch (e) {
    result = e.toString();
  }

  return result;
}

//******************** Run in isolate *****************************************
//*****************LINK TOOLS********************************
Future<dynamic> postCashIoInIsolateLinkTools(
    String url,
    String imgUrl,
    String companyId,
    String serverKey,
    List<CashIoUploadModel> cashIoDocList,
    Directory tempDir) async {
  // Pack arguments into a single object (map or list)
  final args = {
    'url': url,
    'imgUrl': imgUrl,
    'companyId': companyId,
    'serverKey': serverKey,
    'cashIoDocList': cashIoDocList,
    'tempDir': tempDir,
  };

  // Run the function in an isolate
  return await Isolate.run(() => postCashIoIsolateLinkTools(args));
}

// Function executed inside the isolate
dynamic postCashIoIsolateLinkTools(Map<String, dynamic> args) {
  // Extract arguments
  String url = args['url'];
  String imgUrl = args['imgUrl'];
  String companyId = args['companyId'];
  String serverKey = args['serverKey'];
  List<CashIoUploadModel> cashIoDocList =
  List<CashIoUploadModel>.from(args['cashIoDocList']);
  Directory tempDir = args['tempDir'];

  // Call the actual postSales function
  return uploadCashIoRec(
      url, imgUrl, companyId, serverKey, cashIoDocList, tempDir);
}
//*****************LINK TOOLS********************************

//***************** Cloud ********************************
Future<dynamic> postCashIoInIsolateCloud(
    String url,
    String imgUrl,
    String bearerToken,
    List<CashIoUploadModel> cashIoDocList,
    Directory tempDir) async {
  // Pack arguments into a single object (map or list)

  final args = {
    'url': url,
    'imgUrl': imgUrl,
    'bearerToken': bearerToken,
    'cashIoDocList': cashIoDocList,
    'tempDir': tempDir,
  };

  log("In Isolate Pre Call $args");

  // Run the function in an isolate
  return await Isolate.run(() => postCashIoIsolateCloud(args));
}

// Function executed inside the isolate
dynamic postCashIoIsolateCloud(Map<String, dynamic> args) {
  log("Isolate $args");
  // Extract arguments
  String url = args['url'];
  String imgUrl = args['imgUrl'];
  String bearerToken = args['bearerToken'];
  List<CashIoUploadModel> cashIoDocList =
  List<CashIoUploadModel>.from(args['cashIoDocList']);
  Directory tempDir = args['tempDir'];

  // Call the actual postSales function
  return uploadCashIoRecToCloud(
      url, imgUrl, bearerToken, cashIoDocList, tempDir);
}
