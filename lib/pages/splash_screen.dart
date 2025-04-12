import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:ezyretail/dialogs/dealer_login_dialog.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/helpers/general_helper.dart';
import 'package:ezyretail/helpers/network_helper.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/modules/general_function.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/pages/welcome_screen/change_app_version.dart';
import 'package:ezyretail/pages/welcome_screen/expired_screen.dart';
import 'package:ezyretail/pages/welcome_screen/suspend_screen.dart';
import 'package:ezyretail/pages/welcome_screen/welcome_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../globals.dart';
import '../language/globalization.dart';
import '../models/company_profile_model.dart';
import '../models/dealer_model.dart';
import '../models/member_server_model.dart';
import '../models/my_printer.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  bool pauseLoading = false;

  @override
  void initState() {
    super.initState();
    initFunction();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndSetOrientation();
  }

  void _checkAndSetOrientation() {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    final double width = mediaQueryData.size.width;
    final double height = mediaQueryData.size.height;
    final double diagonal = math.sqrt(width * width + height * height);

    const double tabletDiagonalThreshold = 7.0 * 160.0;

    if (diagonal < tabletDiagonalThreshold) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
  }

  Future<void> initFunction() async {
    if (!await Permission.camera.request().isGranted) {
      await Permission.camera.request();
    }

    if (!await Permission.storage.request().isGranted) {
      await Permission.storage.request();
    }

    await createRequireFolder();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String tempDeviceId = prefs.getString("MachineId") ?? "";
    String tempLicenceKey = prefs.getString("LicenseKey") ?? "";

    if (tempDeviceId == "") {
      tempDeviceId = await generateAppId();
      prefs.setString("MachineId", tempDeviceId);
    }

    appId = tempDeviceId;

    String licenceStatus = "ACTIVE";

    if (tempLicenceKey.isNotEmpty) {
      Map<String, dynamic> tmpAppInfo = {
        'app_id': tempDeviceId,
        'license_key': tempLicenceKey,
      };

      String jsonString = jsonEncode(tmpAppInfo);

      final conn = NetWorkHelper();
      licenceStatus = await conn.checkLicenceKey(jsonString);
    }

    //Local Server Settings
    activateStatus = prefs.getBool("SystemIsActivated") ?? false;

    if (activateStatus) {
      switch (licenceStatus) {
        case "INACTIVE":
          Get.offAll(() => const SuspendScreen());
          break;
        case "NOT_FOUND":
          prefs.remove("SystemIsActivated");
          prefs.remove("trialExpDate");
          Get.offAll(() => const WelcomeScreen());
          break;
        default:
          loadUserSettings();
      }
    } else {
      String trialExpDateStr = prefs.getString("trialExpDate") ?? "";

      if (trialExpDateStr.isNotEmpty) {
        try {
          DateTime trialExpDate = DateTime.parse(trialExpDateStr);
          final DateTime currentDate = DateTime.now();

          int daysPassed = trialExpDate.difference(currentDate).inDays;

          if (daysPassed >= 0) {
            loadUserSettings();
          } else {
            Get.offAll(() => const ExpiredScreen());
          }
        } catch (e) {
          await Future.delayed(const Duration(seconds: 2));
          Get.offAll(() => const WelcomeScreen());
        }
      } else {
        await Future.delayed(const Duration(seconds: 2));
        Get.offAll(() => const WelcomeScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: ColorHelper.myDefaultBackColor,
            child: Center(
              child: SizedBox(
                  width: 30.w,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/ezypos_logo.png"),
                      Shimmer.fromColors(
                        baseColor: Colors.white.withOpacity(0.01),
                        highlightColor: Colors.white.withOpacity(0.8),
                        period: const Duration(seconds: 3),
                        child: Image.asset(
                          "assets/images/ezypos_logo.png",
                        ),
                      ),
                    ],
                  )),
            ),
          ),
          Positioned(
            bottom: 20, // Distance from the bottom
            left: 0,
            right: 0, // To center horizontally
            child: GestureDetector(
              onLongPress: () {
                callDealerSettings();
              },
              child: Image.asset(
                'assets/icons/ezy_solutions.png',
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();

    String tmpLanguage = prefs.getString("systemLanguage") ?? "en_US";

    licenceMode = prefs.getInt("licenceMode") ?? 2;

    //Cloud Server Settings
    cloudToken = prefs.getString("cloudToken") ?? "";
    companyKey = prefs.getString("companyKey") ?? "";
    serverUrl = prefs.getString("serverUrl") ?? "";
    publicKey = prefs.getString("publicKey") ?? "";
    privateKey = prefs.getString("privateKey") ?? "";

    //Local Server Settings
    String tmpCompanyId = prefs.getString("companyId") ?? "";
    String tmpServerIp = prefs.getString("serverIpAdd") ?? "";
    String tmpServerPort = prefs.getString("serverPort") ?? "";
    String tmpServerKey = prefs.getString("serverKey") ?? "";

    //Member Server Settings
    String tmpMemberSettings = prefs.getString("memberServerSetting") ?? "";
    String tmpPointSettings = prefs.getString("memberPointSetting") ?? "";
    whatsappVersion = prefs.getString("whatsappVersion") ?? "";

    //General Settings
    mergeDuplicateSales = prefs.getBool("MergeDuplicateSales") ?? false;
    enableUseCameraToScan = prefs.getBool("UseCamera") ?? true;

    //Menu Setting
    showMenuByDefault = prefs.getBool("ShowMenu") ?? false;
    globalMenuHeaderRows = prefs.getInt("MenuHeaderRow") ?? 2;
    globalMenuDetailColumn = prefs.getInt("MenuDetailCol") ?? 4;
    menuTextSize = prefs.getInt("MenuTextSize") ?? 12;

    //Printer Setting
    directlyPrintReceipt = prefs.getBool("DirectPrintReceipt") ?? false;
    useCashDrawer = prefs.getBool("UseCashDrawer") ?? false;
    iminCashDrawer = prefs.getBool("IminCashDrawer") ?? false;
    defaultPrintCopy = prefs.getInt("DefaultPrintCopy") ?? 1;
    printQty = prefs.getBool("PrintQuantity") ?? false;
    printCompanyLogo = prefs.getBool("printCompanyLogo") ?? false;

    keepScreenAwakeOnSales = prefs.getBool("keepScreenAwakeOnSales") ?? false;

    iminBuildInDisplay = prefs.getBool("IminBuildInDisplay") ?? false;
    if (iminBuildInDisplay) {
      // initiMinDisplay();
      // iMinLoadingScreen();
    }

    //Second Screen Display
    dualScreenDisplay = prefs.getBool("DualScreenDisplay") ?? false;
    secondDisplayIndex = prefs.getInt("SecondDisplayIndex") ?? -1;
    secondDisplayName = prefs.getString("SecondDisplayName") ?? "";

    if (dualScreenDisplay) {
      // await initSecondDisplay();
    }

    String tempSelectedPrinter = prefs.getString("selectedPrinter") ?? "";
    // selectedGlobalPrinter = tempSelectedPrinter.isNotEmpty
    //     ? MyPrinter.fromJson(jsonDecode(tempSelectedPrinter))
    //     : null;

    String tempPaperSize = prefs.getString("selectedPaperSize") ?? "";
    // selectedGlobalPaperSize = tempPaperSize.isNotEmpty
    //     ? PrinterHelper.paperSizeFromJson(jsonDecode(tempPaperSize))
    //     : PaperSize.mm58;

    String tmpCurrencySymbol = prefs.getString("CurrencySymbol") ?? "RM";
    String tempCurrencyPosition = prefs.getString("CurrencyPosition") ?? "LEFT";
    unitPriceDecPlace = prefs.getInt("UnitPriceDecPlace") ?? 2;
    quantityDecPlace = prefs.getInt("QuantityDecPlace") ?? 1;
    usePinLogin = prefs.getBool("usePinLogin") ?? false;
    requireRemarkOnHoldBil = prefs.getBool("RemarkOnHoldBil") ?? false;
    allowZeroOpenCounter = prefs.getBool("allowZeroOpenCounter") ?? false;
    allowZeroItemPrice = prefs.getBool("allowZeroItemPrice") ?? false;
    promptOnZeroPriceItem = prefs.getBool("promptOnZeroPriceItem") ?? true;
    cashOutAttachment = prefs.getBool("cashOutAttachment") ?? false;
    allowCrossDay = prefs.getBool("allowCrossDay") ?? false;

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

    //Einvoice
    eInvoiceUrl = prefs.getString("eInvoiceUrl") ?? "";
    eInvoiceKey = prefs.getString("eInvoiceKey") ?? "";
    eInvoiceExpired = prefs.getString("eInvoiceExpired") ?? "";
    eInvoiceClientId = prefs.getString("eInvoiceClientId") ?? "";

    if (await validateEInvoice(
        eInvoiceKey, eInvoiceUrl, eInvoiceClientId, eInvoiceExpired)) {
      eInvoiceEnable = true;
    } else {
      eInvoiceEnable = false;
    }

    //Email Settings
    enableEzyMail = prefs.getBool("enableEmail") ?? false;
    autoSendClosingReport = prefs.getBool("autoSendClosingReport") ?? false;

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

    if (tmpMemberSettings.isNotEmpty) {
      MemberServerModel memSettings =
      MemberServerModel.fromJson(jsonDecode(tmpMemberSettings));

      memberServerId = memSettings.servId;
      memberCompanyId = memSettings.compId;
      memberServerUrl = memSettings.servUrl;
      memberPublicKey = memSettings.publicKey;
      memberPrivateKey = memSettings.privateKey;
      memberIsActive = memSettings.isactive;
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

    // await d1SecondDisplayHelper.initDisplay();

    if (tempProfile != null) {
      systemCompanyProfile = tempProfile;
      // await d1SecondDisplayHelper.sendWelcomePage(systemCompanyProfile?.name);
    }

    if (licenceMode != 1 && licenceMode != 3) {
      await DatabaseHelper.instance
          .clearPendingLog()
          .timeout(const Duration(seconds: 3), onTimeout: () {
        throw TimeoutException('The operation has timed out');
      });
    }

    await Future.delayed(const Duration(seconds: 2));
    Get.offAll(() => const LoginScreen());
  }

  Future<void> createRequireFolder() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      String documentsDirectoryPath = "${appDocDir.path}/StockItemImage";
      final itemImagePath = Directory(documentsDirectoryPath);

      if (await itemImagePath.exists() == false) {
        await itemImagePath.create();
      }
    }
  }

  Future<void> callDealerSettings() async {
    setState(() {
      pauseLoading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmpLicenseKey = prefs.getString("LicenseKey") ?? "";

    if (tmpLicenseKey.isEmpty) {
      return;
    }

    DealerModel? dealerInfo =
    await Get.dialog(const DealerLoginDialog(), barrierDismissible: false);

    if (dealerInfo != null) {
      final conn = NetWorkHelper();
      String result = await conn.checkValidDealer(dealerInfo);

      if (result == "SUCCESS") {
        var page = await Get.to(() => ChangeVersionPage(
          dealerInfo: dealerInfo,
        ));

        Get.offAll(() => const SplashScreen());
      } else {
        await Get.dialog(
            WarningDialog(title: Globalization.warning.tr, content: result),
            barrierDismissible: false);
        setState(() {
          pauseLoading = false;
        });
      }
    } else {
      setState(() {
        pauseLoading = false;
      });
    }
  }
}
