import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/helpers/general_helper.dart';
import 'package:ezyretail/helpers/image_helper.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/modules/encryptor.dart';
import 'package:ezyretail/modules/ip_address_input_formatter.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../globals.dart';
import '../../../language/globalization.dart';
import '../../../models/company_profile_model.dart';
import '../../../models/member_server_model.dart';
import '../../../models/payment_method_model.dart';
import '../../../models/tax_object.dart';
import '../../../models/user_model.dart';

import '../../../themes/color_helper.dart';
import '../../tools/custom_text_button.dart';

class EditServerDialog extends StatefulWidget {
  const EditServerDialog({
    super.key,
  });

  @override
  State<EditServerDialog> createState() => _EditServerDialogState();
}

class _EditServerDialogState extends State<EditServerDialog> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  TextEditingController profileController = TextEditingController();
  TextEditingController serverIpController = TextEditingController();
  TextEditingController portController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int pageOptions = 0;
  int connType = 1;

  String myDeviceId = '';

  bool enableCompanyID = true;
  bool enableIP = true;
  bool enablePort = true;
  bool enableKey = true;
  bool isBusy = false;

  String busyText = "";

  final dio = Dio();

  @override
  void initState() {
    super.initState();

    initPlatformState();

    profileController.text = companyId;
    serverIpController.text = serverIp;
    portController.text = serverPort;
    passwordController.text = serverKey;
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    String tempDeviceId = prefs.getString("MachineId") ?? "";

    if (tempDeviceId == "") {
      final prefs = await SharedPreferences.getInstance();
      tempDeviceId = await generateAppId();
      // 'EZYPOS-${generateRandomString(8).toUpperCase()}-${generateRandomNumber(6).toUpperCase()}';
      prefs.setString("MachineId", tempDeviceId);
    }

    setState(() {
      myDeviceId = tempDeviceId;
    });
  }

  Future<void> initPlatformState() async {
    await _read();

    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData =
        await _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo)
        as Map<String, dynamic>;
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Future<Map<String, dynamic>> _readAndroidBuildData(
      AndroidDeviceInfo build) async {
    return <String, dynamic>{
      'Manufacturer': build.manufacturer,
      'Brand': build.brand,
      'Model': build.model,
      'MachineId': myDeviceId.toUpperCase(),
    };
  }

  Future<Map<String, dynamic>> _readIosDeviceInfo(IosDeviceInfo data) async {
    return <String, dynamic>{
      'Manufacturer': 'Apple',
      'Brand': data.localizedModel,
      'Model': data.utsname.machine,
      'MachineId': myDeviceId.toUpperCase(),
    };
  }

  void disableField() {
    setState(() {
      enableCompanyID = false;
      enableIP = false;
      enablePort = false;
      enableKey = false;
      isBusy = true;
    });
  }

  void enableField() {
    enableCompanyID = true;
    enableIP = true;
    enablePort = true;
    enableKey = true;
    isBusy = false;
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
              Text(
                Globalization.serverSettings.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
            child: updateServer(),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButtonWidget(
                  text: Globalization.cancel.tr,
                  baseColor: ColorHelper.myRed,
                  onTap: () {
                    Get.back();
                  },
                ),
                const Gap(10),
                CustomTextButtonWidget(
                  text: Globalization.connect.tr,
                  baseColor: ColorHelper.myDominantColor,
                  onTap: () {
                    saveUpdateSettings();
                  },
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

  Widget updateServer() {
    return ListView(
      shrinkWrap: true,
      children: [
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
            enabled: false,
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
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Globalization.serverIPAdd.tr,
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
                      enabled: enableIP,
                      controller: serverIpController,
                      cursorColor: ColorHelper.myDominantColor,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
                        LengthLimitingTextInputFormatter(15),
                        IpAddressInputFormatter()
                      ],
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
                ],
              ),
            ),
            const Gap(10),
            SizedBox(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Globalization.serverPort.tr,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: ColorHelper.myBlack),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: ColorHelper.myWhite,
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
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
                        enabled: enablePort,
                        controller: portController,
                        cursorColor: ColorHelper.myDominantColor,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^\d+\.?\d{0,2}")),
                        ],
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
                          color: ColorHelper.myBlack,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
        const Gap(10),
        Text(
          Globalization.hostPassword.tr,
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
            enabled: enableKey,
            controller: passwordController,
            cursorColor: ColorHelper.myDominantColor,
            obscureText: true,
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
              color: ColorHelper.myBlack,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> decodeQr(String qrString) async {
    if (qrString.isNotEmpty) {
      try {
        String resultStr = await decryptMyData(qrString);

        debugPrint('resultStr: $resultStr');
        Map<String, dynamic> _serveInfo = jsonDecode(resultStr);

        profileController.text = _serveInfo['COMP_ID'];
        serverIpController.text = _serveInfo['IPADD'];
        portController.text = _serveInfo['PORT'].toString();
        passwordController.text = _serveInfo['PASSWORD'];
      } on Exception catch (_) {
        // toastHelper.errorToast('Invalid Barcode');
        print(Globalization.invalidQrCode.tr);
      }
    }
  }

  Future<void> saveUpdateSettings() async {
    if (!isBusy) {
      String? token = "";

      if (systemCompanyProfile == null) {
        await Get.dialog(
            WarningDialog(
              content: Globalization.noRegisterTokenUpdateAbort.tr,
            ),
            barrierDismissible: false);
        setState(() {
          isBusy = false;
        });
        return;
      } else {
        token = systemCompanyProfile?.token;
      }

      if (profileController.text.trim() == "") {
        await Get.dialog(
            WarningDialog(
              content: Globalization.emptyProfileName.tr,
            ),
            barrierDismissible: false);
        setState(() {
          isBusy = false;
        });
        return;
      }

      if (serverIpController.text.trim() == "") {
        await Get.dialog(
            WarningDialog(
              content: Globalization.emptyServerIPAdd.tr,
            ),
            barrierDismissible: false);
        setState(() {
          isBusy = false;
        });
        return;
      }

      if (portController.text.trim() == "") {
        await Get.dialog(
            WarningDialog(
              content: Globalization.emptyPort.tr,
            ),
            barrierDismissible: false);
        setState(() {
          isBusy = false;
        });
        return;
      }

      if (passwordController.text.trim() == "") {
        await Get.dialog(
            WarningDialog(
              content: Globalization.emptyHostPassword.tr,
            ),
            barrierDismissible: false);
        setState(() {
          isBusy = false;
        });
        return;
      }

      setState(() {
        busyText = Globalization.connectingToServer.tr;
        isBusy = true;
      });

      disableField();

      String _serverUrl = int.parse(portController.text) == 0
          ? serverIpController.text
          : "http://${serverIpController.text}:${portController.text}";

      String url =
          "$_serverUrl/api/posterminal/?host=${profileController.text}&keys=${passwordController.text}&token=$token&deviceId=$myDeviceId";
      Map jsonMap = _deviceData;

      try {
        final response = await dio.get(url);

        if (response.statusCode == 201 || response.statusCode == 202) {
          String tmpCompanyId = profileController.text.trim();
          String tmpServerIp = serverIpController.text.trim();
          String tmpServerPort = portController.text.trim();
          String tmpServerKey = passwordController.text.trim();
          String tempDeviceId = myDeviceId;

          final prefs = await SharedPreferences.getInstance();
          prefs.setString("companyId", tmpCompanyId);
          prefs.setString("serverIpAdd", tmpServerIp);
          prefs.setString("serverPort", tmpServerPort);
          prefs.setString("serverKey", tmpServerKey);
          prefs.setString("MachineId", tempDeviceId);

          companyId = tmpCompanyId;
          serverIp = tmpServerIp;
          serverPort = tmpServerPort;
          serverKey = tmpServerKey;
          appId = tempDeviceId;

          await Future.delayed(const Duration(milliseconds: 500));

          await getSystemData();
        } else {
          var error = jsonDecode(response.data);
          var message = error['Message'];

          await Get.dialog(
            WarningDialog(content: message),
            barrierDismissible: false,
          );
        }
      } on DioException catch (e) {
        await Get.dialog(
          ErrorDialog(
              title: Globalization.warning.tr,
              content:
              "${e.response?.statusCode} ${Globalization.connectionFail.tr}"),
          barrierDismissible: false,
        );
      } finally {
        setState(() {
          enableField();
          isBusy = false;
        });
      }
    }
  }

  Future<void> getSystemData() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingSysSetting.tr;
    });

    String _serverUrl =
    int.parse(serverPort) == 0 ? serverIp : "http://$serverIp:$serverPort";

    var url =
        '$_serverUrl/api/posterminal/?keys=$serverKey&deviceId=$appId&host=$companyId';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 202) {
        var data = response.data;
        var profile = data['profile'][0];
        var userList = data['users'];
        var paymentList = data['payment'];
        var taxList = data['tax'];
        var memberSetting = data['member'];
        counter = data['profile'][0]['counter'];
        wareHouse = data['profile'][0]['label'];

        CompanyProfileModel compProfile = CompanyProfileModel.fromJson(profile);

        if (memberSetting != null) {
          MemberServerModel memberServerSettings =
          MemberServerModel.fromJson(memberSetting);

          memberServerId = memberServerSettings.servId;
          memberCompanyId = memberServerSettings.compId;
          memberServerUrl = memberServerSettings.servUrl;
          memberPublicKey = memberServerSettings.publicKey;
          memberPrivateKey = memberServerSettings.privateKey;
          memberIsActive = memberServerSettings.isactive;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("memberServerSetting",
              jsonEncode(memberServerSettings.toJson(memberServerSettings)));
        } else {
          memberServerId = "";
          memberCompanyId = "";
          memberServerUrl = "";
          memberPublicKey = "";
          memberPrivateKey = "";
          memberIsActive = false;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("memberServerSetting", "");
        }

        List<UsersModel> listUsers = [];
        for (var data in userList) {
          UsersModel user = UsersModel.fromJson(data);
          listUsers.add(user);
        }

        List<PaymentMethodModel> paymentMethod = [];
        for (var data in paymentList) {
          PaymentMethodModel payment = PaymentMethodModel.fromJson(data);
          if (payment.withImage) {
            String token = compProfile.token;
            var imageUrl =
                '$_serverUrl/api/posterminal/GetPaymentPictures?host=$companyId&key=$serverKey&terminal=$appId&token=$token&paymentCode=${payment.code}';
            final Directory appDocDir =
            await getApplicationDocumentsDirectory();

            String documentsDirectoryPath =
                "${appDocDir.path}/${ImageHelper.paymentModeImageFolder}";

            String encodeItemCode = Uri.encodeComponent(payment.code);

            String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

            // Ensure the directory exists before writing the file
            await Directory(documentsDirectoryPath).create(recursive: true);

            await dio.download(
              imageUrl,
              imagePath,
            );

            payment = payment.copyWith(imgString: imagePath);
          }
          paymentMethod.add(payment);
        }

        if (taxList != null) {
          if (await DatabaseHelper.instance.dropTaxTable()) {
            List<TaxObject> taxModelList = [];
            for (var data in taxList) {
              TaxObject taxObj = TaxObject.fromJson(data);
              taxModelList.add(taxObj);
            }

            if (!await DatabaseHelper.instance.batchInsertTax(taxModelList)) {
              throw ("Fail to insert Tax List");
            }
          } else {
            throw ("Fail to insert Tax List");
          }
        }

        setState(() {
          busyText = Globalization.saveSysSetting.tr;
        });

        if (await DatabaseHelper.instance.dropProfileTable()) {
          if (!await DatabaseHelper.instance
              .insertCompanyProfile(compProfile)) {
            throw (Globalization.failInsertCompanyProfile.tr);
          }
        }

        if (await DatabaseHelper.instance.dropUserTable()) {
          if (!await DatabaseHelper.instance.insertUserList(listUsers)) {
            throw (Globalization.failInsertPosUser.tr);
          }
        }

        if (await DatabaseHelper.instance.dropPaymentMethodTable()) {
          if (!await DatabaseHelper.instance
              .insertPaymentMethod(paymentMethod)) {
            throw (Globalization.failInsertPymtMethod.tr);
          }
        }

        systemCompanyProfile = compProfile;

        Get.back(result: "Success");
        await Get.dialog(
          InformationDialog(
              title: Globalization.information.tr,
              content: Globalization.updateSuccessful.tr),
          barrierDismissible: false,
        );
      }
    } on DioException catch (e) {
      await Get.dialog(
        ErrorDialog(
            title: Globalization.warning.tr,
            content:
            "${e.response?.statusCode} ${Globalization.connectionFail.tr}"),
        barrierDismissible: false,
      );
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        enableField();
        isBusy = false;
      });
    }
  }
}
