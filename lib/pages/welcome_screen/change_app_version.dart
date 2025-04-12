import 'dart:convert';
import 'dart:io';

import 'package:ezyretail/dialogs/cloud_pre_setup.dart';
import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/dialogs/ezylink_pre_setup.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/dialogs/yes_no_dialog.dart';
import 'package:ezyretail/helpers/image_helper.dart';
import 'package:ezyretail/helpers/network_helper.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/pages/welcome_screen/advance_options.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../globals.dart';
import '../../language/globalization.dart';
import '../../models/company_profile_model.dart';
import '../../models/dealer_model.dart';
import '../../models/user_model.dart';
import "package:path/path.dart" as path;

class ChangeVersionPage extends StatefulWidget {
  final DealerModel dealerInfo;
  const ChangeVersionPage({super.key, required this.dealerInfo});

  @override
  State<ChangeVersionPage> createState() => _ChangeVersionPageState();
}

class _ChangeVersionPageState extends State<ChangeVersionPage> {
  bool isBusy = false;
  String busyMessage = "";

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
                  child: Image.asset("assets/images/choose.png"),
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
                      child: Image.asset("assets/images/choose.png")),
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
          Globalization.changeEdition.tr,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        Text(
          Globalization.warningBeforeChangeEdition.tr,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myBlack),
        ),
        /*const Gap(10),
        ZoomTapAnimation(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.remove("SystemIsActivated");
            prefs.remove("trialExpDate");
            // Get.off(() => const ServerSettings());
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
                Globalization.directToServerPage.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),*/
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
              title: Text(
                Globalization.generateNewEzyLinkToolsEdition.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            onlineCloudSetup();
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
                Globalization.generateCloudEdition.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            clearAndCreateEmptyDb();
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
                Globalization.generateEmptyStandaloneEdition.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            restoreSampleDb();
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
                Globalization.generateStandaloneWithSample.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            restoreFunction();
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
                Globalization.restoreOwnBackupEdition.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
        const Gap(10),
        ZoomTapAnimation(
          onTap: () {
            Get.to(() => const AdvanceOptionsPage());
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
                Globalization.advanceOptions.tr,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorHelper.myDominantColor),
              ),
              trailing: const Icon(Icons.chevron_right,
                  color: ColorHelper.myDominantColor),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> clearAndCreateEmptyDb() async {
    bool confirmCreate = false;

    await Get.dialog(
        YesNoDialog(
            title: Globalization.areYouSure.tr,
            content: Globalization.confirmResetCreateNewDb.tr,
            onConfirm: () {
              confirmCreate = true;
              Get.back();
            },
            onCancel: () {
              Get.back();
            }),
        barrierDismissible: false);

    if (!confirmCreate) return;

    setState(() {
      isBusy = true;
      busyMessage = Globalization.connectingToServer.tr;
    });

    await resetGlobalValue();

    if (await notifyServerOnVersionChange("Standalone") == false) {
      setState(() {
        isBusy = false;
        busyMessage = "";
      });

      return;
    }

    setState(() {
      busyMessage = Globalization.generateDatabase.tr;
    });

    List<UsersModel> userList = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String tmpMachineId = prefs.getString("MachineId") ?? "";
    String tmpLicenseKey = prefs.getString("LicenseKey") ?? "";

    licenceMode = 0;
    prefs.setInt("licenceMode", licenceMode);

    await DatabaseHelper.instance.dropAllTable();

    UsersModel defaultUser = UsersModel(
        userKey: 'ADMIN',
        name: 'ADMIN',
        password: 'Admin',
        access: 1,
        pin: '1234');

    userList.add(defaultUser);

    await DatabaseHelper.instance.insertUserList(userList);

    await Future.delayed(const Duration(milliseconds: 500));

    Map<String, dynamic> tmpAppInfo = {
      'app_id': tmpMachineId,
      'license_key': tmpLicenseKey,
    };

    String jsonString = jsonEncode(tmpAppInfo);

    final conn = NetWorkHelper();
    String licenceStatus = await conn.checkLicenceKey(jsonString);

    if (licenceStatus.isNotEmpty) {
      Map<String, dynamic> customerData = jsonDecode(licenceStatus);

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
        postcode: customerData["postcode"] ?? "",
        city: customerData["city"] ?? "",
        state: customerData["state"] ?? "",
        country: customerData["country"] ?? "",
      );

      // if (await DatabaseHelper.instance.dropProfileTable()) {
      await DatabaseHelper.instance.updateCompanyProfileWhenCheck(compProfile);
      // }

      systemCompanyProfile = compProfile;
    }

    Get.offAll(() => const LoginScreen());

    setState(() {
      isBusy = false;
      busyMessage = "";
    });
  }

  Future<void> restoreSampleDb() async {
    bool confirmCreate = false;

    await Get.dialog(
        YesNoDialog(
            title: Globalization.areYouSure.tr,
            content: Globalization.confirmResetCreateNewDb.tr,
            onConfirm: () {
              confirmCreate = true;
              Get.back();
            },
            onCancel: () {
              Get.back();
            }),
        barrierDismissible: false);

    if (!confirmCreate) return;

    setState(() {
      isBusy = true;
      busyMessage = Globalization.connectingToServer.tr;
    });

    if (await notifyServerOnVersionChange("Standalone") == false) {
      setState(() {
        isBusy = false;
        busyMessage = "";
      });

      return;
    }

    await resetGlobalValue();

    setState(() {
      busyMessage = Globalization.generateSampleDatabase.tr;
    });

    licenceMode = 0;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("licenceMode", licenceMode);

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

    await Future.delayed(const Duration(milliseconds: 500));
    Get.offAll(() => const LoginScreen());

    setState(() {
      isBusy = false;
      busyMessage = "";
    });
  }

  Future<void> ezyLinkToolsSetup() async {
    bool confirmCreate = false;

    await Get.dialog(
        YesNoDialog(
            title: Globalization.areYouSure.tr,
            content: Globalization.confirmResetCreateNewDb.tr,
            onConfirm: () {
              confirmCreate = true;
              Get.back();
            },
            onCancel: () {
              Get.back();
            }),
        barrierDismissible: false);

    if (!confirmCreate) return;

    setState(() {
      isBusy = true;
      busyMessage = Globalization.connectingToServer.tr;
    });

    if (await notifyServerOnVersionChange("Local") == false) {
      setState(() {
        isBusy = false;
        busyMessage = "";
      });

      return;
    }

    licenceMode = 1;
    await resetGlobalValue();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("licenceMode", licenceMode);

    await DatabaseHelper.instance.dropAllTable();

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String itemImgDirectoryPath =
        "${appDocDir.path}/${ImageHelper.itemImageFolder}";

    if (await Directory(itemImgDirectoryPath).exists()) {
      //Delete the directory if exist
      await Directory(itemImgDirectoryPath).delete(recursive: true);
    }

    await Directory(itemImgDirectoryPath).create(recursive: true);

    bool validConn = false;

    while (!validConn) {
      var connResult = await Get.dialog(const EzyLinkSetupDialog(),
          barrierDismissible: false);

      if (connResult != null) {
        if (connResult.toString() == "SUCCESS") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("SystemIsActivated", true);
          activateStatus = true;

          validConn = true;
        } else if (connResult.toString() == "CANCEL") {
          await Get.dialog(
              YesNoDialog(
                  content: Globalization
                      .confirmCancelSetupUnableLoginUntilComplete.tr,
                  //"This will cancel setup and you will not able to login until you complete the setup\nDo you want to continue?",
                  onConfirm: () {
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

    setState(() {
      isBusy = false;
      busyMessage = "";
    });

    await Future.delayed(const Duration(milliseconds: 300));
    Get.offAll(() => const LoginScreen());
  }

  Future<void> onlineCloudSetup() async {
    bool confirmCreate = false;

    await Get.dialog(
        YesNoDialog(
            title: Globalization.areYouSure.tr,
            content: Globalization.confirmResetCreateNewDb.tr,
            onConfirm: () {
              confirmCreate = true;
              Get.back();
            },
            onCancel: () {
              Get.back();
            }),
        barrierDismissible: false);

    if (!confirmCreate) return;

    setState(() {
      isBusy = true;
      busyMessage = Globalization.connectingToServer.tr;
    });

    if (await notifyServerOnVersionChange("Online") == false) {
      setState(() {
        isBusy = false;
        busyMessage = "";
      });

      return;
    }

    licenceMode = 3;
    await resetGlobalValue();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("licenceMode", licenceMode);

    await DatabaseHelper.instance.dropAllTable();

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String itemImgDirectoryPath =
        "${appDocDir.path}/${ImageHelper.itemImageFolder}";

    if (await Directory(itemImgDirectoryPath).exists()) {
      //Delete the directory if exist
      await Directory(itemImgDirectoryPath).delete(recursive: true);
    }

    await Directory(itemImgDirectoryPath).create(recursive: true);

    bool validConn = false;

    while (!validConn) {
      var connResult =
      await Get.dialog(const CloudPreSetup(), barrierDismissible: false);

      if (connResult != null) {
        if (connResult.toString() == "SUCCESS") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("SystemIsActivated", true);
          activateStatus = true;

          validConn = true;
        } else if (connResult.toString() == "CANCEL") {
          await Get.dialog(
              YesNoDialog(
                  content: Globalization
                      .confirmCancelSetupUnableLoginUntilComplete.tr,
                  //"This will cancel setup and you will not able to login until you complete the setup\nDo you want to continue?",
                  onConfirm: () {
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

    setState(() {
      isBusy = false;
      busyMessage = "";
    });

    await Future.delayed(const Duration(milliseconds: 300));
    Get.offAll(() => const LoginScreen());
  }

  Future<void> restoreFunction() async {
    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;
    const fileName = "EzyRetail";
    const folderName = "EzyRetail Backup";
    final checkPath = Directory("storage/emulated/0/Documents");
    final folderPath = Directory("storage/emulated/0/Documents/$folderName");
    final fullFolderPath =
    Directory("storage/emulated/0/Documents/$folderName/");
    final dbFolder = await getDatabasesPath();
    const dbName = DatabaseHelper.databaseName;
    final fullDbName = "$dbFolder/$dbName";

    try {
      if (!await Permission.storage.request().isGranted) {
        await Permission.storage.request();
      }

      if (await checkPath.exists() == false) {
        await checkPath.create();
      }

      if (await folderPath.exists() == false) {
        await folderPath.create();
      }

      setState(() {
        busyMessage = Globalization.restoreData.tr;
        isBusy = true;
      });

      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        initialDirectory: folderPath.toString(),
      );
      // if no file is picked
      if (result == null) {
        setState(() {
          busyMessage = "";
          isBusy = false;
        });
        return;
      }

      String sourcePath = result.files.first.path.toString();

      String extension = result.files.first.extension.toString();

      if (extension.toLowerCase() != 'ezr') {
        await Get.dialog(
            WarningDialog(content: Globalization.invalidBackupFile.tr),
            barrierDismissible: false);

        setState(() {
          busyMessage = "";
          isBusy = false;
        });
        return;
      }

      Database? myDb = await openDatabase(sourcePath);

      final chkResult = await myDb.rawQuery(
          '''SELECT name FROM sqlite_master WHERE type='table' AND name='BackupInfo' ''');

      if (chkResult.isEmpty) {
        await Get.dialog(
            WarningDialog(content: Globalization.invalidBackupFile.tr),
            barrierDismissible: false);

        setState(() {
          busyMessage = "";
          isBusy = false;
        });

        await myDb.close();
        return;
      }

      List<Map<String, dynamic>> temp =
      await myDb.rawQuery("SELECT * FROM BackupInfo");

      if (temp.isEmpty) {
        await Get.dialog(
            WarningDialog(content: Globalization.invalidBackupFile.tr),
            barrierDismissible: false);

        setState(() {
          busyMessage = "";
          isBusy = false;
        });

        await myDb.close();
        return;
      }

      if (temp[0]['Software'] != "EzyRetail Pro") {
        await Get.dialog(
            WarningDialog(content: Globalization.invalidBackupFile.tr),
            barrierDismissible: false);

        setState(() {
          busyMessage = "";
          isBusy = false;
        });

        return;
      }

      await myDb.close();

      await DatabaseHelper.instance.closeDatabase();

      File source1 = File(sourcePath);

      await source1.copy(fullDbName);

      await DatabaseHelper.instance.reopenDatabase();

      String imgFolder = ImageHelper.itemImageFolder;
      await ImageHelper.clearItemFolder(imgFolder);

      List imgs = await DatabaseHelper.instance.getAllItemImage();

      if (imgs.isNotEmpty) {
        for (var img in imgs) {
          String tmpCode = img[DatabaseHelper.itemCode];
          String tmpImgStr = img[DatabaseHelper.itemImage];

          String encodeItemCode = Uri.encodeComponent(tmpCode);

          String tmpPath = await ImageHelper.storeImageToFile(
              ImageHelper.itemImageFolder, encodeItemCode, tmpImgStr);

          await DatabaseHelper.instance.updateImageTable(tmpCode, tmpPath);
        }
      }

      imgs = [];

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

      await Future.delayed(const Duration(milliseconds: 500));

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(
          ErrorDialog(content: "${Globalization.error.tr} : ${e.toString()}"),
          barrierDismissible: false);
    }

    setState(() {
      busyMessage = "";
      isBusy = false;
    });
  }

  Future<bool> notifyServerOnVersionChange(String appVersion) async {
    bool returnResult = false;
    final conn = NetWorkHelper();

    String result = await conn.changeAppEdition(widget.dealerInfo, appVersion);

    if (result == "SUCCESS") {
      returnResult = true;
    } else {
      await Get.dialog(
          WarningDialog(title: Globalization.warning.tr, content: result),
          barrierDismissible: false);
    }

    return returnResult;
  }

  Future<void> resetGlobalValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String tmpMachineId = prefs.getString("MachineId") ?? "";
    String tmpLicenseKey = prefs.getString("LicenseKey") ?? "";
    bool tmpActivateStatus = prefs.getBool("SystemIsActivated") ?? false;

    await prefs.clear();

    prefs.setString("MachineId", tmpMachineId);
    prefs.setString("LicenseKey", tmpLicenseKey);
    prefs.setBool("SystemIsActivated", tmpActivateStatus);

    //Auto Sync
    syncInProgress = false;
    autoSynchronizeTime = 0;
    autoSyncItem = false;
    autoSyncImage = false;

    systemCompanyProfile = null;
    systemBatchKey = "";

    globalMenuHeaderRows = 2;
    globalMenuDetailColumn = 4;
    menuTextSize = 12;

    maxPayment = 1;
    paymentMenuColumn = 3;
    paymentCompleteDelay = 3;

    usePinLogin = false;

    cent1 = 0;
    cent2 = 0;
    cent3 = 0;
    cent4 = 5;
    cent5 = 5;
    cent6 = 5;
    cent7 = 5;
    cent8 = 10;
    cent9 = 10;

    counter = 0;
    wareHouse = "";
    loginUserKey = "";
    userAccess = 1;
    loginUserName = "";
    loginUserPin = "";
    loginPass = "";
    accessQty = false;
    accessCost = false;

    companyId = "";
    serverIp = "";
    serverPort = "";
    serverKey = "";

    memberServerId = "";
    memberCompanyId = "";
    memberServerUrl = "";
    memberPublicKey = "";
    memberPrivateKey = "";
    memberIsActive = false;

    ezyMemberEarnPoint = 0;
    ezyMemberEarnPrice = 0;
    ezyMemberRedeemPoint = 0;
    ezyMemberRedeemPrice = 0;
    ezyMemberRoundingMethod = 0;

    lastLogin = "";
    lastSync = "";
    lastImgSync = "";

    currencyPosition = CurrencyPosition.left;

    enableUseCameraToScan = true;
    showMenuByDefault = true;
    mergeDuplicateSales = false;
    requireRemarkOnHoldBil = false;
    allowZeroOpenCounter = false;
    allowZeroItemPrice = false;
    promptOnZeroPriceItem = true;
    cashOutAttachment = false;
    allowCrossDay = false;

    unitPriceDecPlace = 2;
    quantityDecPlace = 1;

    defaultBackupPath = "";

    whatsappVersion = "";

    enableEzyMail = false;
    autoSendClosingReport = false;

    eInvoiceUrl = "";
    eInvoiceKey = "";
    eInvoiceExpired = "";
    eInvoiceClientId = "";
    eInvoiceEnable = false;

    setState(() {});
  }
}
