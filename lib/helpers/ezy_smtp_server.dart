import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../globals.dart';

SmtpServer ezyMailServer() => SmtpServer('mail.ezysolutions.com.my',
    username: "automailer@ezysolutions.com.my",
    password: "S1gmat3ch^",
    port: 465,
    ssl: true);

Future<dynamic> sendReceipt(String recipient, String attachPath) async {
  String username = 'automailer@ezysolutions.com.my';
  // change your password here
  String password = 'S1gmat3ch@';
  final smtpServer = ezyMailServer();
  final message = Message()
    ..from = Address(username, 'EzySolution Mail Service')
    ..recipients.add(recipient)
    ..subject = "This is your Digital Invoice"
  // ..text = "_bodyController.text"
    ..html =
        '<p>Hi!\nThank you for spending in ${systemCompanyProfile?.name}, Attach is invoice for your purchase.</p>\n<p>We hope we can see you soon in near future.</p>\n\n<h4>Message from EzySolutions Mail Service.\nPlease Do Not Reply</h4>\n<img src="https://ezysolutions.com.my/solutions/ezyretail_pos.png" style="width:150px;"/>\n<p>https://ezysolutions.com.my/</p>'
    ..attachments = [
      FileAttachment(File(attachPath))
        ..location = Location.inline
        ..cid = '<myimg@3.141>'
    ];

  try {
    await send(message, smtpServer).timeout(const Duration(seconds: 10));
    Map<String, dynamic> result = {
      "status": "success",
      "message": "Email Send"
    };

    return result;
  } catch (e) {
    if (e is TimeoutException) {
      Map<String, dynamic> result = {
        "status": "fail",
        "message": "The operation timed out"
      };
      return result;
    } else {
      Map<String, dynamic> result = {"status": "fail", "message": e.toString()};
      return result;
    }
  }
}

Future<dynamic> sentClosingReport(
    List<String> emailList, String attachPath, String shift) async {
  String username = 'automailer@ezysolutions.com.my';
  List<String> emails = emailList;
  final smtpServer = ezyMailServer();
  final message = Message()
    ..from = Address(username, 'EzySolution Mail Service')
    ..recipients = emails
    ..subject =
        "Closing Report ${systemCompanyProfile?.label} Counter ${systemCompanyProfile?.counter}"
    ..html =
        '<p>Location : ${systemCompanyProfile?.label}</p>\n<p>Counter : ${systemCompanyProfile?.counter}</p>\n<p>Shift : $shift</p>\n\n<h4>Message from EzySolutions Mail Service.\nPlease Do Not Reply</h4>\n<img src="https://ezysolutions.com.my/solutions/ezyretail_pos.png" style="width:150px;"/>\n<p>https://ezysolutions.com.my/</p>'
    ..attachments = [
      FileAttachment(File(attachPath))
        ..location = Location.inline
        ..cid = '<myimg@3.141>'
    ];

  try {
    await send(message, smtpServer).timeout(const Duration(seconds: 10));
    Map<String, dynamic> result = {
      "status": "success",
      "message": "Email Send"
    };
    return result;
  } catch (e) {
    if (e is TimeoutException) {
      Map<String, dynamic> result = {
        "status": "fail",
        "message": "The operation timed out"
      };
      return result;
    } else {
      Map<String, dynamic> result = {"status": "fail", "message": e.toString()};
      return result;
    }
  }
}

Future<void> sendWelcomeMsg(String recipient) async {
  String username = 'automailer@ezysolutions.com.my';
  final smtpServer = ezyMailServer();
  final message = Message()
    ..from = Address(username, 'EzySolution Mail Service')
    ..recipients.add(recipient)
    ..subject = "👋 Welcome. Your EzyRetail trial has activated"
    ..html =
        '<p>Hi!\nThank you for choosing EzyRetail, here is you login credential.</p>\n<p>User ID : Admin</p>\n<p>Password : Admin</p>\n\n<h4>Message from EzySolutions Mail Service.\nPlease Do Not Reply</h4>\n<img src="https://ezysolutions.com.my/solutions/ezyretail_pos.png" style="width:150px;"/>\n<p>https://ezysolutions.com.my/</p>';

  try {
    await send(message, smtpServer).timeout(const Duration(seconds: 5));
  } catch (e) {
    if (e is TimeoutException) {
      Map<String, dynamic> result = {
        "status": "fail",
        "message": "The operation timed out"
      };
    } else {
      Map<String, dynamic> result = {"status": "fail", "message": e.toString()};
    }
  }
}

Future<void> sendErrorEmail(Map<String, dynamic> args) async {
  String tempLicenseKey = args["LicenseKey"];
  String tempAppId = args["AppId"];
  String tempError = args["Error"];

  String username = 'automailer@ezysolutions.com.my';
  String recipient = "sigmatechjb@gmail.com";

  final smtpServer = ezyMailServer();
  final message = Message()
    ..from = Address(username, 'EzySolution Mail Service')
    ..recipients.add(recipient)
    ..subject = "Client DB Upgrade Error"
    ..html =
        '<p>License Key : $tempLicenseKey</p>\n<p>App ID : $tempAppId</p>\n<p>Error : $tempError</p>\n\n<h4>Message from EzySolutions Mail Service.\nPlease Do Not Reply</h4>\n<img src="https://ezysolutions.com.my/solutions/ezyretail_pos.png" style="width:150px;"/>\n<p>https://ezysolutions.com.my/</p>';

  try {
    await send(message, smtpServer).timeout(const Duration(seconds: 5));
  } catch (e) {
    debugPrint(e.toString());
  }
}
