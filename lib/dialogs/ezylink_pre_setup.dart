import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:ezyretail/dialogs/barcode_scan_dialog.dart';
import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/dialogs/yes_no_dialog.dart';
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
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../globals.dart';
import '../../../language/globalization.dart';
import '../../../models/cash_io_model.dart';
import '../../../models/company_profile_model.dart';
import '../../../models/item_barcode_model.dart';
import '../../../models/item_master_model.dart';
import '../../../models/item_menu_model.dart';
import '../../../models/member_server_model.dart';
import '../../../models/payment_method_model.dart';
import '../../../models/tax_object.dart';
import '../../../models/user_model.dart';
import '../../../themes/color_helper.dart';
import '../../tools/custom_text_button.dart';
import 'pair_server_dialog.dart';

class EzyLinkSetupDialog extends StatefulWidget {
  const EzyLinkSetupDialog({
    super.key,
  });

  @override
  State<EzyLinkSetupDialog> createState() => _EzyLinkSetupDialogState();
}

class _EzyLinkSetupDialogState extends State<EzyLinkSetupDialog> {
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

  bool downloadItem = false;
  bool downloadImg = false;

  bool fromClient = false;
  PosLabelModel? tempLocationInfo;

  @override
  void initState() {
    super.initState();

    initPlatformState();

    profileController.text = companyId;
    serverIpController.text = serverIp;
    portController.text = serverPort;
    passwordController.text = serverKey;
    myDeviceId = appId;
  }

  Future<void> initPlatformState() async {
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
      case 2:
        return registerServer();
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
            saveRegisterSettings();
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

  Widget registerServer() {
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
                  enabled: enableCompanyID,
                  controller: profileController,
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
            Visibility(
              visible: true,
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                child: ZoomTapAnimation(
                  onTap: () async {
                    var scanResult = await Get.dialog(
                      const BarcodeDialog(),
                      barrierDismissible: false,
                    );

                    if (scanResult != null) {
                      decodeQr(scanResult.toString());
                    }
                  },
                  child: Image.asset(
                    "assets/icons/camera_scan.png",
                    height: 30,
                  ),
                ),
              ),
            ),
          ],
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

  void nextActions() {
    setState(() {
      pageOptions = 2;
    });
  }

  void backActions() {
    setState(() {
      pageOptions = 0;
    });
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
        fromClient = _serveInfo['fromClient'] ?? false;

        if (fromClient) {
          tempLocationInfo = PosLabelModel(
              parentId: _serveInfo['id'] ?? 0,
              key: _serveInfo['key'] ?? "",
              label: _serveInfo['label'] ?? "");
        }
      } on Exception catch (_) {
        // toastHelper.errorToast('Invalid Barcode');
        print(Globalization.invalidQrCode.tr);
      }
    }
  }

  Future<void> saveRegisterSettings() async {
    if (!isBusy) {
      if (profileController.text.trim() == "") {
        Get.dialog(
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
        Get.dialog(
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
        Get.dialog(
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
        Get.dialog(
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
          "$_serverUrl/api/posterminal/PostRegisterTerminal?host=${profileController.text}&keys=${passwordController.text}";

      Map jsonMap = _deviceData;

      if (fromClient) {
        url =
        "$_serverUrl/api/EzyLinkClient/PostRegisterTerminal?host=${profileController.text}&keys=${passwordController.text}";

        Map tempMap = {
          "deviceInfo": jsonMap,
          "parentId": tempLocationInfo?.parentId,
          "locKey": tempLocationInfo?.key,
          "label": tempLocationInfo?.label
        };

        jsonMap = tempMap;
      }

      var data = jsonEncode(jsonMap);

      try {
        final response = await dio.post(url,
            data: data,
            options: Options(headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            }));

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

          await Future.delayed(const Duration(milliseconds: 100));

          return await getSystemData();
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
      var response = await dio.get(url);

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

        String token = compProfile.token;

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

        url =
        '$_serverUrl/api/posterminal/PostLogo?host=$companyId&key=$serverKey&terminal=$appId';

        try {
          response = await dio.get(url,
              options: Options(responseType: ResponseType.bytes));

          if (response.statusCode == 200) {
            Uint8List? fileData = response.data;
            if (fileData != null) {
              await DatabaseHelper.instance.insertCompanyLogo(fileData);
            }
          }
        } on DioException catch (e) {
          debugPrint("No Company Logo");
        }

        url =
        '$_serverUrl/api/CashInOutReason/?host=$companyId&key=$serverKey&terminal=$appId&token=$token';

        response = await dio.get(url);

        if (response.statusCode == 200) {
          List<dynamic> tempItemList = response.data;

          List<CashIoReasonModel> items =
          tempItemList.map((e) => CashIoReasonModel.fromJson(e)).toList();

          await DatabaseHelper.instance.dropCashInOutReasonTable();

          await DatabaseHelper.instance.insertCashIReason(items);
        }

        downloadItem = false;
        downloadImg = false;

        await Get.dialog(
          YesNoDialog(
              title: Globalization.downloadItemMaster.tr,
              content: Globalization.confirmDownloadItemData.tr,
              onConfirm: () {
                downloadItem = true;
                Get.back();
              },
              onCancel: () {
                Get.back();
              }),
          barrierDismissible: false,
        );

        if (downloadItem) {
          await Get.dialog(
            YesNoDialog(
                title: Globalization.downloadItemImage.tr,
                content: Globalization.confirmDownloadItemImage.tr,
                onConfirm: () {
                  downloadImg = true;
                  Get.back();
                },
                onCancel: () {
                  Get.back();
                }),
            barrierDismissible: false,
          );

          await fullSyncSystemItem();
        }

        Get.back(result: "SUCCESS");
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

  Future<void> fullSyncSystemItem() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingItemMaster.tr;
    });

    final prefs = await SharedPreferences.getInstance();

    //Sync Item Master

    String token = systemCompanyProfile?.token ?? '';

    try {
      String _serverUrl = int.parse(serverPort) == 0
          ? serverIp
          : "http://$serverIp:$serverPort";

      String url =
          '$_serverUrl/api/PosItem/GetFullItemsList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&items=0';

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        //Drop Table
        await DatabaseHelper.instance.dropItemTbl();
        await DatabaseHelper.instance.dropBarcodeTbl();
        await DatabaseHelper.instance.dropMenuHeaderTable();
        await DatabaseHelper.instance.dropMenuDetailTable();

        var data = response.data;
        List<dynamic> tempItemList = data['ItemList'];

        List<ItemMasterModel> items =
        tempItemList.map((e) => ItemMasterModel.fromJson(e)).toList();

        int totalBatch = data['CountInfo']['TotalBatch'];

        if (items.isNotEmpty) {
          if (!await DatabaseHelper.instance.insertItem(items)) {
            throw Exception(Globalization.errorInsertItemMaster.tr);
          }
        }

        if (totalBatch > 0) {
          for (var i = 0; i <= totalBatch; i++) {
            double counter = ((i + 1) / totalBatch) * 100;

            setState(() {
              busyText = "${Globalization.downloadingItemMaster.tr} $counter %";
            });

            await Future.delayed(const Duration(seconds: 1));

            url =
            '$_serverUrl/api/PosItem/GetFullItemsList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&items=${i + 1}';

            response = await dio.get(url);

            if (response.statusCode == 200) {
              data = response.data;
              tempItemList = data['ItemList'];

              items =
                  tempItemList.map((e) => ItemMasterModel.fromJson(e)).toList();

              if (!await DatabaseHelper.instance.insertItem(items)) {
                throw Exception(Globalization.errorInsertItemMaster.tr);
              }
            } else {
              throw Exception('${response.statusCode} ${response.data}');
            }
          }
        }
      } else {
        throw Exception('${response.statusCode} ${response.data}');
      }

      //Sync Barcode
      setState(() {
        busyText = Globalization.downloadingItemBarcode.tr;
      });

      await Future.delayed(const Duration(milliseconds: 100));

      url =
      '$_serverUrl/api/PosBarcode/GetFullBarcodeList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&barcode=0';

      response = await dio.get(url);

      if (response.statusCode == 200) {
        var data = response.data;
        List<dynamic> tempItemList = data['BarcodeList'];

        List<ItemBarcodeModel> items =
        tempItemList.map((e) => ItemBarcodeModel.fromJson(e)).toList();

        int totalBatch = data['CountInfo']['TotalBatch'];

        if (items.isNotEmpty) {
          if (!await DatabaseHelper.instance.insertItemBarcode(items)) {
            throw Exception(Globalization.insertItemMasterBarcode.tr);
          }
        }

        if (totalBatch > 0) {
          for (var i = 0; i <= totalBatch; i++) {
            double counter = ((i + 1) / totalBatch) * 100;

            setState(() {
              busyText =
              "${Globalization.downloadingItemBarcode.tr} $counter %";
            });

            await Future.delayed(const Duration(seconds: 1));

            url =
            '$_serverUrl/api/PosBarcode/GetFullBarcodeList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&barcode=${i + 1}';

            response = await dio.get(url);

            if (response.statusCode == 200) {
              data = response.data;
              tempItemList = data['BarcodeList'];

              items = tempItemList
                  .map((e) => ItemBarcodeModel.fromJson(e))
                  .toList();

              if (!await DatabaseHelper.instance.insertItemBarcode(items)) {
                throw Exception(Globalization.insertItemMasterBarcode.tr);
              }
            } else {
              throw Exception('${response.statusCode} ${response.data}');
            }
          }
        }
      } else {
        throw Exception('${response.statusCode} ${response.data}');
      }

      lastSyncItemDate = DateTime.now();

      String dateString = lastSyncItemDate.toIso8601String();
      await prefs.setString("LastSyncItemDate", dateString);

      //Item Menu
      setState(() {
        busyText = Globalization.downloadingItemMenu.tr;
      });

      await Future.delayed(const Duration(milliseconds: 100));

      url =
      '$_serverUrl/api/PosMenu/GetMenu?host=$companyId&key=$serverKey&terminal=$appId&token=$token';

      response = await dio.get(url);

      if (response.statusCode == 200) {
        var data = response.data;
        List<dynamic> tempHeaderList = data['MenuHeaderList'];
        List<dynamic> tempDetailsList = data['MenuDetailList'];

        List<ItemMenuModel> itemHdr =
        tempHeaderList.map((e) => ItemMenuModel.fromJson(e)).toList();
        List<ItemMenuModel> itemDtl =
        tempDetailsList.map((e) => ItemMenuModel.fromJson(e)).toList();

        if (!await DatabaseHelper.instance.insertItemMenuHeader(itemHdr)) {
          throw Exception(Globalization.insertItemMenuHdr.tr);
        }

        if (!await DatabaseHelper.instance.insertItemMenuDetail(itemDtl)) {
          throw Exception(Globalization.insertItemMenuDtl.tr);
        }
      } else {
        throw Exception('${response.statusCode} ${response.data}');
      }

      //Download Image
      await Future.delayed(const Duration(milliseconds: 100));

      if (downloadImg) {
        setState(() {
          busyText = Globalization.downloadingItemImage.tr;
        });

        String imgFolder = ImageHelper.itemImageFolder;
        await ImageHelper.clearItemFolder(imgFolder);
        await DatabaseHelper.instance.dropImageTbl();

        String baseUrl = '$_serverUrl/api/ItemImage/GetFullImageList';
        Map<String, String> queryParams = {
          'host': companyId,
          'key': serverKey,
          'terminal': appId,
          'token': token,
          'image': '0',
        };

        url = '$baseUrl${Uri(queryParameters: queryParams)}';

        response = await dio.get(url);

        if (response.statusCode == 200) {
          var data = response.data;
          List<dynamic> itemImageList = data['ImageList'];

          int totalBatch = data['CountInfo']['TotalBatch'];

          if (itemImageList.isNotEmpty) {
            for (var i = 0; i <= totalBatch; i++) {
              queryParams['image'] = '$i';
              url = '$baseUrl${Uri(queryParameters: queryParams)}';
              response = await dio.get(url);

              if (response.statusCode == 200) {
                data = response.data;
                itemImageList = data['ImageList'];

                if (itemImageList.isNotEmpty) {
                  await downloadItemImage(itemImageList, token);
                }
              } else {
                throw Exception('${response.statusCode} ${response.data}');
              }
            }
          }
        } else {
          throw Exception('${response.statusCode} ${response.data}');
        }

        lastSyncImgDate = DateTime.now();

        dateString = lastSyncImgDate.toIso8601String();
        await prefs.setString("LastSyncImgDate", dateString);
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
      await Get.dialog(
        ErrorDialog(title: Globalization.warning.tr, content: e.toString()),
        barrierDismissible: false,
      );
    } finally {
      setState(() {
        busyText = Globalization.updateSuccessful.tr;
      });
    }
  }

  Future<bool> downloadItemImage(
      List<dynamic> itemImageList, String token) async {
    bool result = false;

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String documentsDirectoryPath =
        "${appDocDir.path}/${ImageHelper.itemImageFolder}";

    await Directory(documentsDirectoryPath).create(recursive: true);

    for (String itemCode in itemImageList) {
      try {
        String _serverUrl = int.parse(serverPort) == 0
            ? serverIp
            : "http://$serverIp:$serverPort";

        String imageUrl =
            '$_serverUrl/api/ItemImage/GetPictures?host=$companyId&key=$serverKey&terminal=$appId&token=$token&itemCode=$itemCode';

        String encodeItemCode = Uri.encodeComponent(itemCode);

        String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

        /* String imageBase64 = const Base64Encoder().convert(data.bodyBytes);

          String imagePath =
              await ImageHelper.storeImageToFile(itemCode, imageBase64);*/

        await dio.download(
          imageUrl,
          imagePath,
        );

        bool insertResult =
        await DatabaseHelper.instance.insertItemImage(itemCode, imagePath);

/*          if (!insertResult) {
            throw Exception('Insert Item Image Error - $itemCode');
          } else {
            completeImage = completeImage + 1;
            ref.read(downloadImageProgressProvider.notifier).state =
                completeImage / totalImage;

            result = true;
          }*/
        result = true;
      } on DioException catch (e) {
        /* Get.dialog(
          ErrorDialog(content: "${e.response?.statusCode} Connection Fail"),
          barrierDismissible: false,
        );*/
      } catch (e) {
        await Get.dialog(
          ErrorDialog(title: Globalization.warning.tr, content: e.toString()),
          barrierDismissible: false,
        );
      }
    }

    return result;
  }
}
