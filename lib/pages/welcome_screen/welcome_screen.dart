import 'dart:io';

import 'package:ezyretail/dialogs/app_activation_dialog.dart';
import 'package:ezyretail/dialogs/ezylink_pre_setup.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/dialogs/yes_no_dialog.dart';
import 'package:ezyretail/helpers/image_helper.dart';
import 'package:ezyretail/helpers/license_file_handle.dart';
import 'package:ezyretail/helpers/network_helper.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/pages/welcome_screen/sign_up_screen.dart';
import 'package:ezyretail/pages/welcome_screen/version_options.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../globals.dart';
import '../../language/globalization.dart';
import '../../models/company_profile_model.dart';
import '../../models/user_model.dart';
import "package:path/path.dart" as path;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isBusy = false;
  String busyMessage = "";
  // final iminViceScreenPlugin = IminViceScreen();

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
                  child: Image.asset("assets/images/welcome.png"),
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
            const Gap(10),
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
                      child: Image.asset("assets/images/welcome.png")),
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
          Globalization.welcome.tr,
          style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(20),
        Text(
          Globalization.choosingEzyRetailProAndBegin.tr,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myBlack),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            activateDevice();
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
                Globalization.activate.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              subtitle: Text(
                Globalization.licenseAlreadyActivateInDevice.tr,
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
            Get.to(() => const SignUpScreen());
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
                Globalization.registerTrial.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              subtitle: Text(
                Globalization.interestedTrialPeriodToTest.tr,
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
          onTap: () async {
            // await iminViceScreenPlugin.doubleScreenCancel();
            restoreSampleDb();
            // clearAndCreateEmptyDb();
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
                Globalization.trySampleData.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              subtitle: Text(
                Globalization.interestedSampleData.tr,
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
      ],
    );
  }

  Future<void> activateDevice() async {
    var result = await Get.dialog(const AppActivationDialog(),
        barrierDismissible: false);

    if (result != null) {
      String licenceKey = result.toString();

      if (licenceKey != "" && appId != "") {
        setState(() {
          isBusy = true;
          busyMessage = Globalization.connectingToHost.tr;
        });

        final conn = NetWorkHelper();
        result = await conn.activateLicenceAndReset(appId.trim(), licenceKey);

        if (result.toString() == "SUCCESS") {
          await deleteLicenseFile();
          await writeLicenseKey(licenceKey.trim());

          setState(() {
            isBusy = false;
            busyMessage = "";
          });

          if (licenceMode == 5) {
            Get.to(() => const VersionOptionsPage());
          } else {
            if (licenceMode == 1) {
              enableUseCameraToScan = true;

              bool validConn = false;

              while (!validConn) {
                var connResult = await Get.dialog(const EzyLinkSetupDialog(),
                    barrierDismissible: false);

                if (connResult != null) {
                  if (connResult.toString() == "SUCCESS") {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool("SystemIsActivated", true);
                    activateStatus = true;
                    prefs.remove("trialExpDate");

                    validConn = true;
                  } else if (connResult.toString() == "CANCEL") {
                    await Get.dialog(
                        YesNoDialog(
                            content: Globalization
                                .confirmCancelSetupUnableLoginUntilComplete.tr,
                            onConfirm: () async {
                              SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                              await prefs.setBool("SystemIsActivated", true);
                              activateStatus = true;
                              validConn = true;
                              Get.back();
                            },
                            onCancel: () {
                              Get.back();
                            }),
                        barrierDismissible: false);
                  }
                }
              }

              await Future.delayed(const Duration(milliseconds: 500));
              Get.offAll(() => const LoginScreen());
            } else {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool("SystemIsActivated", true);
              activateStatus = true;
              prefs.remove("trialExpDate");

              await Future.delayed(const Duration(milliseconds: 500));
              Get.offAll(() => const LoginScreen());
            }
          }
        } else {
          await Get.dialog(WarningDialog(content: result.toString()),
              barrierDismissible: false);
        }

        setState(() {
          isBusy = false;
          busyMessage = "";
        });
      }
    }
  }

  Future<void> clearAndCreateEmptyDb() async {
    setState(() {
      isBusy = true;
      busyMessage = Globalization.generateDatabase.tr;
    });

    List<UsersModel> userList = [];

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    await DatabaseHelper.instance.dropAllTable();

    UsersModel defaultUser = UsersModel(
        userKey: 'ADMIN',
        name: 'ADMIN',
        password: 'Admin',
        access: 1,
        pin: '1234');

    userList.add(defaultUser);

    licenceMode = 0;

    await DatabaseHelper.instance.insertUserList(userList);

    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(() => const LoginScreen());

    setState(() {
      isBusy = false;
      busyMessage = "";
    });
  }

  Future<void> restoreSampleDb() async {
    setState(() {
      isBusy = true;
      busyMessage = Globalization.generateSampleDatabase.tr;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    await DatabaseHelper.instance.closeDatabase();
    // Get the path to the device's local storage directory
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, DatabaseHelper.databaseName);

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String itemImgDirectoryPath =
        "${appDocDir.path}/${ImageHelper.itemImageFolder}";

    if (await Directory(itemImgDirectoryPath).exists()) {
      //Delete the directory if exist
      await Directory(itemImgDirectoryPath).delete(recursive: true);
    }

    await Directory(itemImgDirectoryPath).create(recursive: true);

    ByteData data = await rootBundle.load('assets/sampleDB.db');
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write the database to the local storage
    await File(dbPath).writeAsBytes(bytes);

    await DatabaseHelper.instance.reopenDatabase();

    List imgs = await DatabaseHelper.instance.getAllItemImage();

    if (imgs.isNotEmpty) {
      for (var img in imgs) {
        String tmpCode = img[DatabaseHelper.itemCode];
        String tmpImgStr = img[DatabaseHelper.itemImage];

        String tmpPath = await ImageHelper.storeImageToFile(
            ImageHelper.itemImageFolder, tmpCode, tmpImgStr);

        await DatabaseHelper.instance.updateImageTable(tmpCode, tmpPath);
      }
    }

    imgs = [];

    imgs = await DatabaseHelper.instance.getAllPaymentImage();

    if (imgs.isNotEmpty) {
      for (var img in imgs) {
        String tmpCode = img[DatabaseHelper.paymentCode];
        String tmpImgStr = img[DatabaseHelper.paymentImage];

        String tmpPath = await ImageHelper.storeImageToFile(
            ImageHelper.paymentModeImageFolder, tmpCode, tmpImgStr);

        await DatabaseHelper.instance.updatePaymentImage(tmpCode, tmpPath);
      }
    }

    imgs = [];

    CompanyProfileModel? tempProfile =
    await DatabaseHelper.instance.getCompanyProfile();

    if (tempProfile != null) {
      systemCompanyProfile = tempProfile;
    }

    licenceMode = 2;

    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(() => const LoginScreen());

    setState(() {
      isBusy = false;
      busyMessage = "";
    });
  }
}
