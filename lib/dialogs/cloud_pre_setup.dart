import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/helpers/image_helper.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../globals.dart';
import '../../../language/globalization.dart';
import '../../../models/company_profile_model.dart';
import '../../../models/payment_method_model.dart';
import '../../../models/user_model.dart';
import '../../../themes/color_helper.dart';
import '../../tools/custom_text_button.dart';

class CloudPreSetup extends StatefulWidget {
  const CloudPreSetup({super.key});

  @override
  State<CloudPreSetup> createState() => _CloudPreSetupState();
}

class _CloudPreSetupState extends State<CloudPreSetup> {
  Map<String, dynamic> returnResult = <String, dynamic>{};

  TextEditingController profileController = TextEditingController();
  TextEditingController serverUrlController = TextEditingController();
  TextEditingController tokenController = TextEditingController();
  TextEditingController privateKeyController = TextEditingController();
  TextEditingController publicKeyController = TextEditingController();

  final FocusNode ctrlFocusNode = FocusNode();

  String busyText = "";

  int pageOptions = 0;
  int connType = 1;

  bool isBusy = false;

  final dio = Dio();

  @override
  void initState() {
    super.initState();

    profileController.text = companyKey;
    serverUrlController.text = serverUrl;
    tokenController.text = cloudToken;
    privateKeyController.text = privateKey;
    publicKeyController.text = publicKey;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          backgroundColor: ColorHelper.myDefaultBackColor,
          surfaceTintColor: ColorHelper.myDefaultBackColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Row(
            children: [
              Image.asset("assets/icons/host_conn.png", height: 25),
              const Gap(10),
              const Text(
                "Setup Wizard",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorHelper.myBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          content: Container(
            constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
            width: 500,
            color: ColorHelper.myDefaultBackColor,
            child: contentWidget(),
          ),
          actions: <Widget>[
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: pageOptions == 0
                          ? CustomTextButtonWidget(
                        text: Globalization.back.tr,
                        baseColor: ColorHelper.myDisable2,
                        onTap: () {},
                      )
                          : CustomTextButtonWidget(
                        text: Globalization.back.tr,
                        baseColor: ColorHelper.myDominantColor,
                        onTap: () {
                          backActions();
                        },
                      ),
                    ),
                    const Gap(10),
                    Expanded(child: nextButton()),
                  ],
                ),
                const Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextButtonWidget(
                        text: Globalization.cancel.tr,
                        baseColor: ColorHelper.myRed,
                        onTap: () {
                          Get.back(result: "CANCEL");
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButtonWidget(
                  text: Globalization.cancel.tr,
                  baseColor: ColorHelper.myRed,
                  onTap: () {
                    Get.back(result: "CANCEL");
                  },
                ),
                const Gap(10),
                Row(
                  children: [
                    Visibility(
                      visible: pageOptions != 0,
                      child: CustomTextButtonWidget(
                        text: Globalization.back.tr,
                        baseColor: ColorHelper.myDominantColor,
                        onTap: () {
                          backActions();
                        },
                      ),
                    ),
                    const Gap(10),
                    nextButton(),
                  ],
                ),
              ],
            ),
          ],
        ),
        Visibility(
          visible: isBusy,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: LoadingIndicator(
              message: busyText,
            ),
          ),
        ),
      ],
    );
  }

  Widget contentWidget() {
    switch (pageOptions) {
      case 0:
        return connOptions();
      case 1:
        return registerServerUrl();
      case 2:
        return registerServerKey();
      default:
        return connOptions();
    }
  }

  Widget nextButton() {
    switch (pageOptions) {
      case 0:
        return CustomTextButtonWidget(
          text: Globalization.next.tr,
          baseColor: ColorHelper.myDominantColor,
          onTap: () {
            nextActions();
          },
        );
      case 2:
        return CustomTextButtonWidget(
          text: Globalization.confirm.tr,
          baseColor: ColorHelper.myGreen,
          onTap: () {
            connectServer();
          },
        );
      default:
        return CustomTextButtonWidget(
          text: Globalization.next.tr,
          baseColor: ColorHelper.myDominantColor,
          onTap: () {
            nextActions();
          },
        );
    }
  }

  Widget connOptions() {
    return ListView(
      shrinkWrap: true,
      children: const [
        Text(
          "Welcome",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        Gap(10),
        Text(
          "Welcome! Our setup wizard is here to assist you every step of the way. Follow along with the wizard to easily complete the setup process and get started quickly. Let's begin!",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myBlack),
        ),
      ],
    );
  }

  Widget registerServerUrl() {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          Globalization.serverUrl.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              const Gap(5),
              const Text(
                "https://",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDisable1),
              ),
              Expanded(
                child: TextField(
                  controller: serverUrlController,
                  cursorColor: ColorHelper.myDominantColor,
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    filled: true,
                    fillColor: ColorHelper.myWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide.none,
                    ),
                    errorText: null,
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorHelper.myBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        Text(
          Globalization.profileName.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: profileController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(10),
        Text(
          Globalization.deviceToken.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: tokenController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              color: ColorHelper.myBlack,
            ),
          ),
        ),
      ],
    );
  }

  Widget registerServerKey() {
    return ListView(
      shrinkWrap: true,
      children: [
        Text(
          Globalization.publicKey.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorHelper.myWhite,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 1,
                offset: const Offset(-1, -1),
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: TextField(
            controller: publicKeyController,
            cursorColor: ColorHelper.myDominantColor,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              filled: true,
              fillColor: ColorHelper.myWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide.none,
              ),
              errorText: null,
            ),
            maxLines: 1,
            style: const TextStyle(
              fontSize: 14,
              color: ColorHelper.myBlack,
            ),
          ),
        ),
        const Gap(10),
        Text(
          Globalization.privateKey.tr,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myBlack),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: ColorHelper.myWhite,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 1,
                      offset: const Offset(-1, -1),
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: privateKeyController,
                  cursorColor: ColorHelper.myDominantColor,
                  decoration: const InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    filled: true,
                    fillColor: ColorHelper.myWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide.none,
                    ),
                    errorText: null,
                  ),
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 14,
                    color: ColorHelper.myBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
        const Gap(10),
      ],
    );
  }

  void nextActions() {
    switch (pageOptions) {
      case 0:
        pageOptions = 1;
        break;
      case 1:
        pageOptions = 2;
        break;
      default:
        pageOptions = 0;
    }
    setState(() {});
  }

  void backActions() {
    switch (pageOptions) {
      case 2:
        pageOptions = 1;
        break;
      case 1:
        pageOptions = 0;
        break;
      default:
        pageOptions = 0;
    }
    setState(() {});
  }

  Future<void> connectServer() async {
    try {
      String url =
          "https://${serverUrlController.text.trim()}/api/${profileController.text.trim()}/activate-counter";

      Map<String, dynamic> queryData = {
        "token": tokenController.text.trim(),
        "app_id": appId
      };

      String bearerToken =
          "${publicKeyController.text.trim()}${privateKeyController.text.trim()}";

      var response = await dio.post(url,
          data: queryData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $bearerToken",
          }));

      if (response.statusCode == 200) {
        cloudToken = tokenController.text.trim();
        companyKey = profileController.text.trim();
        serverUrl = serverUrlController.text.trim();
        publicKey = publicKeyController.text.trim();
        privateKey = privateKeyController.text.trim();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("cloudToken", cloudToken);
        await prefs.setString("companyKey", companyKey);
        await prefs.setString("serverUrl", serverUrl);
        await prefs.setString("publicKey", publicKey);
        await prefs.setString("privateKey", privateKey);

        await downloadSettingsFromCloud();

        await Get.dialog(const InformationDialog(content: "System Registered"),
            barrierDismissible: false);
        Get.back(result: "SUCCESS");
      }
    } on DioException catch (e) {
      if(e.response?.data == null) {
        await Get.dialog(const ErrorDialog(content: "Server URL is invalid"),
            barrierDismissible: false);
      } else {
        if (e.response?.statusCode == 403) {
          await Get.dialog(const ErrorDialog(content: "Token Already Register"),
              barrierDismissible: false);
        } else if (e.response?.statusCode == 406) {
          await Get.dialog(const ErrorDialog(content: "Invalid Token"),
              barrierDismissible: false);
        } else {
          await Get.dialog(ErrorDialog(content: e.response?.data['message']),
              barrierDismissible: false);
        }
      }
    } catch (e) {
      await Get.dialog(ErrorDialog(content: e.toString()),
          barrierDismissible: false);
    }
  }

  Future<void> downloadSettingsFromCloud() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingSysSetting.tr;
    });

    String bearerToken = "$publicKey$privateKey";

    String url = "https://$serverUrl/api/$companyKey/get-company-profile";

    Map<String, dynamic> queryData = {"app_id": appId};

    try {
      var response = await dio.post(url,
          data: queryData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $bearerToken",
          }));

      print(response.toString());

      if (response.statusCode == 200) {
        var data = response.data;
        var profile = data['company_profile'];
        var companyLogo = data['company_logo'];

        CompanyProfileModel compProfile =
        CompanyProfileModel.fromCloud(profile);

        if (await DatabaseHelper.instance.dropProfileTable()) {
          if (!await DatabaseHelper.instance
              .insertCompanyProfile(compProfile)) {
            throw (Globalization.failInsertCompanyProfile.tr);
          }

          systemCompanyProfile = compProfile;

          if (companyLogo != null && companyLogo.toString().isNotEmpty) {
            response = await dio.get(companyLogo,
                options: Options(responseType: ResponseType.bytes));
            Uint8List? fileData = response.data;
            if (fileData != null) {
              await DatabaseHelper.instance.insertCompanyLogo(fileData);
            }
          }
        }

        url = "https://$serverUrl/api/$companyKey/get-user-login-account";

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          data = response.data;
          List<dynamic> tempItemList = data['user_list'];

          List<UsersModel> listUsers =
          tempItemList.map((e) => UsersModel.fromCloud(e)).toList();

          if (await DatabaseHelper.instance.dropUserTable()) {
            if (!await DatabaseHelper.instance.insertUserList(listUsers)) {
              throw (Globalization.failInsertPosUser.tr);
            }
          }
        }

        url = "https://$serverUrl/api/$companyKey/get-payment-method";

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          var data = response.data;
          List<dynamic> paymentList = data['payment_method_list'];
          List<PaymentMethodModel> paymentMethod = [];

          final Directory appDocDir = await getApplicationDocumentsDirectory();

          String documentsDirectoryPath =
              "${appDocDir.path}/${ImageHelper.paymentModeImageFolder}";

          await Directory(documentsDirectoryPath).create(recursive: true);

          for (var data in paymentList) {
            PaymentMethodModel payment = PaymentMethodModel.fromCloud(data);

            if (payment.withImage) {
              Uint8List bytes = base64Decode(payment.imgString);

              String encodeItemCode = Uri.encodeComponent(payment.code);

              String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

              File file = File(imagePath);
              await file.writeAsBytes(bytes);

              payment = payment.copyWith(imgString: imagePath);
            }

            paymentMethod.add(payment);
          }

          if (await DatabaseHelper.instance.dropPaymentMethodTable()) {
            if (!await DatabaseHelper.instance
                .insertPaymentMethod(paymentMethod)) {
              throw (Globalization.failInsertPymtMethod.tr);
            }
          }
        }
      }
    } on DioException catch (e) {
      await Get.dialog(
        ErrorDialog(title: Globalization.warning.tr, content: e.toString()),
        barrierDismissible: false,
      );
    } catch (e) {
      await Get.dialog(
        ErrorDialog(title: Globalization.warning.tr, content: e.toString()),
        barrierDismissible: false,
      );
    } finally {
      setState(() {
        isBusy = false;
      });
    }
  }
}
