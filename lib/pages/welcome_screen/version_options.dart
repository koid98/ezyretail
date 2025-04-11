import 'dart:convert';

import 'package:ezyretail/dialogs/ezylink_pre_setup.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../globals.dart';
import '../../language/globalization.dart';
import '../../models/company_profile_model.dart';
import '../../models/member_server_model.dart';
import '../../models/my_printer.dart';

class VersionOptionsPage extends StatefulWidget {
  const VersionOptionsPage({super.key});

  @override
  State<VersionOptionsPage> createState() => _VersionOptionsPageState();
}

class _VersionOptionsPageState extends State<VersionOptionsPage> {
  bool isBusy = false;
  String busyMessage = "";

  var nameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return portraitLayout();
            } else {
              return landscapeLayout();
            }
          },
        ),
        Visibility(
          visible: isBusy,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: LoadingIndicator(
              message: busyMessage,
            ),
          ),
        ),
      ],
    );
  }

  Widget portraitLayout() {
    return Scaffold(
      backgroundColor: ColorHelper.myWhite,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              color: ColorHelper.myDefaultBackColor,
              child: Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 2 * 0.7,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset("assets/images/page_options.png"),
                ),
              ),
            ),
            Container(
              color: ColorHelper.myWhite,
              constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: activeAction(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget landscapeLayout() {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
              child: Container(
                color: ColorHelper.myDefaultBackColor,
                child: Center(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.asset("assets/images/page_options.png")),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: ColorHelper.myWhite,
                child: Center(
                  child: Container(
                    constraints:
                    const BoxConstraints(minWidth: 300, maxWidth: 400),
                    width: MediaQuery.of(context).size.width / 2 * 0.7,
                    child: activeAction(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activeAction() {
    return ListView(
      shrinkWrap: true,
      physics: MediaQuery.of(context).orientation == Orientation.landscape
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        Text(
          Globalization.choosePosEdition.tr,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            licenceMode = 0;
            temporaryLoad();
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorHelper.myWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  offset: const Offset(-1, -1),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                Globalization.standalone.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              subtitle: Text(
                Globalization.operateIndependently.tr,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: ColorHelper.myBlack),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            ezyLinkToolsSetup();
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorHelper.myWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  offset: const Offset(-1, -1),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: ListTile(
              title: const Text(
                'EzyLink tools',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              subtitle: Text(
                Globalization.connectedToEzyLinkToolsServer.tr,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: ColorHelper.myBlack),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            licenceMode = 1;
            temporaryLoad();
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorHelper.myWhite,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 1,
                  offset: const Offset(-1, -1),
                ),
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 1,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                Globalization.dealerUse.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              subtitle: Text(
                Globalization.forInternalUseOnly.tr,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: ColorHelper.myBlack),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
      ],
    );
  }

  Future<void> ezyLinkToolsSetup() async {
    var connResult =
    await Get.dialog(const EzyLinkSetupDialog(), barrierDismissible: false);

    if (connResult != null) {
      if (connResult.toString() == "SUCCESS") {
        licenceMode = 1;

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt("licenceMode", licenceMode);

        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => const LoginScreen());
      }
    }
  }

  Future<void> temporaryLoad() async {
    setState(() {
      busyMessage = Globalization.loadSettings.tr;
      isBusy = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String tmpLanguage = prefs.getString("systemLanguage") ?? "en_US";

    //Local Server Settings
    String tmpCompanyId = prefs.getString("companyId") ?? "";
    String tmpServerIp = prefs.getString("serverIpAdd") ?? "";
    String tmpServerPort = prefs.getString("serverPort") ?? "";
    String tmpServerKey = prefs.getString("serverKey") ?? "";
    String tempDeviceId = prefs.getString("MachineId") ?? "";

    //Member Server Settings
    String tmpMemberSettings = prefs.getString("memberServerSetting") ?? "";
    String tmpPointSettings = prefs.getString("memberPointSetting") ?? "";
    whatsappVersion = prefs.getString("whatsappVersion") ?? "";

    //General Settings
    mergeDuplicateSales = prefs.getBool("MergeDuplicateSales") ?? false;
    enableUseCameraToScan = prefs.getBool("UseCamera") ?? true;
    allowZeroItemPrice = prefs.getBool("allowZeroItemPrice") ?? false;
    promptOnZeroPriceItem = prefs.getBool("promptOnZeroPriceItem") ?? true;
    cashOutAttachment = prefs.getBool("cashOutAttachment") ?? false;
    allowCrossDay = prefs.getBool("allowCrossDay") ?? false;

    //Menu Setting
    showMenuByDefault = prefs.getBool("ShowMenu") ?? false;
    globalMenuHeaderRows = prefs.getInt("MenuHeaderRow") ?? 2;
    globalMenuDetailColumn = prefs.getInt("MenuDetailCol") ?? 4;
    menuTextSize = prefs.getInt("MenuTextSize") ?? 12;

    String tmpCurrencySymbol = prefs.getString("CurrencySymbol") ?? "RM";
    String tempCurrencyPosition = prefs.getString("CurrencyPosition") ?? "LEFT";
    unitPriceDecPlace = prefs.getInt("UnitPriceDecPlace") ?? 2;
    quantityDecPlace = prefs.getInt("QuantityDecPlace") ?? 1;
    usePinLogin = prefs.getBool("usePinLogin") ?? false;
    requireRemarkOnHoldBil = prefs.getBool("RemarkOnHoldBil") ?? false;

    //Printer Setting
    directlyPrintReceipt = prefs.getBool("DirectPrintReceipt") ?? false;
    useCashDrawer = prefs.getBool("UseCashDrawer") ?? false;
    iminCashDrawer = prefs.getBool("IminCashDrawer") ?? false;
    defaultPrintCopy = prefs.getInt("DefaultPrintCopy") ?? 1;
    printQty = prefs.getBool("PrintQuantity") ?? false;
    printCompanyLogo = prefs.getBool("printCompanyLogo") ?? false;

    iminBuildInDisplay = prefs.getBool("IminBuildInDisplay") ?? false;
    if (iminBuildInDisplay) {
      // initIminDisplay();
    }

    //Second Screen Display
    dualScreenDisplay = prefs.getBool("DualScreenDisplay") ?? false;
    secondDisplayIndex = prefs.getInt("SecondDisplayIndex") ?? -1;
    secondDisplayName = prefs.getString("SecondDisplayName") ?? "";

    // if (dualScreenDisplay) {
    //   await initSecondDisplay();
    // }

    String tempSelectedPrinter = prefs.getString("selectedPrinter") ?? "";
    // selectedGlobalPrinter = tempSelectedPrinter.isNotEmpty
    //     ? MyPrinter.fromJson(jsonDecode(tempSelectedPrinter))
    //     : null;

    String tempPaperSize = prefs.getString("selectedPaperSize") ?? "";
    // selectedGlobalPaperSize = tempPaperSize.isNotEmpty
    //     ? PrinterHelper.paperSizeFromJson(jsonDecode(tempPaperSize))
    //     : PaperSize.mm58;

    //Auto Sync
    autoSynchronizeTime = prefs.getInt("AutoSyncDuration") ?? 0;
    autoSyncItem = prefs.getBool("AutoSyncItem") ?? false;
    autoSyncImage = prefs.getBool("AutoSyncImage") ?? false;

    maxPayment = prefs.getInt("maxPayment") ?? 1;
    paymentMenuColumn = prefs.getInt("paymentMenuColumn") ?? 3;
    paymentCompleteDelay = prefs.getInt("paymentCompleteDelay") ?? 3;

    String tmpLastSyncItemDate = prefs.getString("LastSyncItemDate") ?? "";
    String tmpLastSyncImgDate = prefs.getString("LastSyncImgDate") ?? "";

    defaultBackupPath = prefs.getString("DefaultBackupFolder") ?? "";

    enableEzyMail = false;
    autoSendClosingReport = false;

    if (tmpLastSyncItemDate.isEmpty) {
      lastSyncItemDate = DateTime.now();
    } else {
      lastSyncItemDate = DateTime.parse(tmpLastSyncItemDate);
    }

    if (tmpLastSyncImgDate.isEmpty) {
      lastSyncImgDate = DateTime.now();
    } else {
      lastSyncImgDate = DateTime.parse(tmpLastSyncImgDate);
    }

    companyId = tmpCompanyId;
    serverIp = tmpServerIp;
    serverPort = tmpServerPort;
    serverKey = tmpServerKey;
    appId = tempDeviceId;

    if (tmpMemberSettings.isNotEmpty) {
      MemberServerModel memSettings =
      MemberServerModel.fromJson(jsonDecode(tmpMemberSettings));

      memberServerId = memSettings.servId;
      memberCompanyId = memSettings.compId;
      memberServerUrl = memSettings.servUrl;
      memberPublicKey = memSettings.publicKey;
      memberPrivateKey = memSettings.privateKey;
      memberIsActive = true;
    }

    if (tmpPointSettings.isNotEmpty) {
      MemberPointSettings tmpPoint =
      MemberPointSettings.fromJson(jsonDecode(tmpPointSettings));

      ezyMemberEarnPoint = tmpPoint.earnPoint;
      ezyMemberEarnPrice = tmpPoint.earnPrice;
      ezyMemberRedeemPoint = tmpPoint.redeemPoint;
      ezyMemberRedeemPrice = tmpPoint.redeemPrice;
      ezyMemberRoundingMethod = tmpPoint.roundingMethod;
    }

    currencySymbol = tmpCurrencySymbol;

    if (tempCurrencyPosition == "LEFT") {
      currencyPosition = CurrencyPosition.left;
    } else {
      currencyPosition = CurrencyPosition.right;
    }

    systemLanguage = tmpLanguage;

    switch (systemLanguage) {
      case "en_US":
        Get.updateLocale(Globalization.englishLocale);
        break;
      case "zh_CN":
        Get.updateLocale(Globalization.chineseLocale);
        break;
      case "ms_MY":
        Get.updateLocale(Globalization.malayLocale);
        break;
      default:
        Get.updateLocale(Globalization.defaultLocale);
        break;
    }

    //Get Company Profile From DB
    CompanyProfileModel? tempProfile =
    await DatabaseHelper.instance.getCompanyProfile();

    if (tempProfile != null) {
      systemCompanyProfile = tempProfile;
    }

    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(() => const LoginScreen());

    setState(() {
      busyMessage = "";
      isBusy = false;
    });
  }
}
