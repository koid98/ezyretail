import 'dart:convert';
import 'dart:io';

import 'package:ezyretail/dialogs/check_permission_dialog.dart';
import 'package:ezyretail/dialogs/edit_server_dialog.dart';
import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/dialogs/pair_server_dialog.dart';
import 'package:ezyretail/dialogs/yes_no_dialog.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:ezyretail/tools/main_manu_item_widget.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import '../../globals.dart';
import '../../language/globalization.dart';

import "package:path/path.dart" as path;

class AdvanceOptionsPage extends StatefulWidget {
  const AdvanceOptionsPage({super.key});

  @override
  State<AdvanceOptionsPage> createState() => _AdvanceOptionsPageState();
}

class _AdvanceOptionsPageState extends State<AdvanceOptionsPage> {
  bool isBusy = false;
  String busyMessage = "";
  bool appIsFromPlayStore = false;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    appIsFromPlayStore = await isAppInstalledFromPlayStore();

    setState(() {
      _packageInfo = info;
    });
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
                  child: Image.asset("assets/images/dealer_settings.png"),
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
                      child: Image.asset("assets/images/dealer_settings.png")),
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
          Globalization.advanceOptions.tr,
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        GridView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          children: [
            MainMenuPageItemButtonWidget(
              enabled: true,
              title: Globalization.back.tr,
              icon: "assets/icons/back.png",
              onTab: () {
                Get.back();
              },
            ),
            MainMenuPageItemButtonWidget(
              enabled: licenceMode == 1,
              title: Globalization.serverSettings.tr,
              icon: "assets/icons/edit_server.png",
              onTab: () {
                editServerSettings();
              },
            ),
            MainMenuPageItemButtonWidget(
              enabled: licenceMode == 1,
              title: Globalization.pairServer.tr,
              icon: "assets/icons/link_server.png",
              onTab: () {
                pairServer();
              },
            ),
            MainMenuPageItemButtonWidget(
              enabled: true,
              title: Globalization.resetAdminPassword.tr,
              icon: "assets/icons/reset_password.png",
              onTab: () {
                resetAdminPassword();
              },
            ),
            MainMenuPageItemButtonWidget(
              enabled: true,
              title: Globalization.backupData.tr,
              icon: "assets/icons/data_backup.png",
              onTab: () {
                dataBackup();
              },
            ),
            if (kDebugMode)
              MainMenuPageItemButtonWidget(
                enabled: true,
                title: Globalization.changeMachineId.tr,
                icon: "assets/icons/swap_id.png",
                onTab: () {},
              ),
            MainMenuPageItemButtonWidget(
              enabled: true,
              title: Globalization.checkPermission.tr,
              icon: "assets/icons/permission.png",
              onTab: () {
                getPermissionStatus();
              },
            ),
            if (!appIsFromPlayStore)
              MainMenuPageItemButtonWidget(
                enabled: true,
                title: Globalization.checkPermission.tr,
                icon: "assets/icons/app_download.png",
                onTab: () {
                  // Get.to(() => const DownloadUpdatePage(
                  //   isSettingPage: true,
                  // ));
                },
              ),
          ],
        ),
      ],
    );
  }

  Future<void> editServerSettings() async {
    await Get.dialog(const EditServerDialog(), barrierDismissible: false);
  }

  Future<void> pairServer() async {
    await Get.dialog(const PairServerDialog(), barrierDismissible: false);
  }

  Future<void> resetAdminPassword() async {
    bool confirmReset = false;

    await Get.dialog(
        YesNoDialog(
            content:
            "Are you sure you want to reset ADMIN to default password?",
            onConfirm: () {
              confirmReset = true;
              Get.back();
            },
            onCancel: () {
              Get.back();
            }),
        barrierDismissible: false);

    if (confirmReset) {
      if (await DatabaseHelper.instance.resetAdminPassword("Admin")) {
        await Get.dialog(
            const InformationDialog(content: "Password has been reset"),
            barrierDismissible: false);
      }
    }
  }

  Future<void> dataBackup() async {
    bool backupImgs = false;
    final Directory rootPath = Directory("storage/emulated/0/");

    String? backupPath = await FilesystemPicker.openDialog(
        contextActions: [
          FilesystemPickerNewFolderContextAction(),
        ],
        title: 'Backup folder',
        context: context,
        rootDirectory: rootPath,
        fsType: FilesystemType.folder,
        pickText: 'Save to this folder',
        theme: FilesystemPickerTheme(
          fileList: FilesystemPickerFileListThemeData(
            folderTextStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          pickerAction: FilesystemPickerActionThemeData(
            foregroundColor: ColorHelper.myDominantColor,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          topBar: FilesystemPickerTopBarThemeData(
            backgroundColor: ColorHelper.myDominantColor,
            foregroundColor: Colors.white,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        folderIconColor: ColorHelper.myAccentColor);

    if (backupPath == null) {
      return;
    }

    await Get.dialog(
        YesNoDialog(
            title: Globalization.areYouSure.tr,
            content: Globalization.confirmBackupImages.tr,
            onConfirm: () {
              setState(() {
                backupImgs = true;
              });
              Get.back();
            },
            onCancel: () {
              setState(() {
                backupImgs = false;
              });
              Get.back();
            }),
        barrierDismissible: false);

    setState(() {
      busyMessage = Globalization.backupData.tr;
      isBusy = true;
    });

    const fileName = "EzyRetail";

    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/${DatabaseHelper.databaseName}');

    var outputFormat = DateFormat('yyMMdd');
    String newBackupFile = path.join(
        '$backupPath/$fileName${outputFormat.format(DateTime.now())}.ezr');

    try {
      if (!await Permission.manageExternalStorage.request().isGranted) {
        await Permission.manageExternalStorage.request();
      }
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      await DatabaseHelper.instance.closeDatabase();

      await source1.copy(newBackupFile);

      await DatabaseHelper.instance.reopenDatabase();

      Database? myDb = await openDatabase(newBackupFile);

      if (myDb.isOpen) {
        await myDb.execute("DROP TABLE IF EXISTS BackupInfo");

        await myDb.execute('''
        CREATE TABLE IF NOT EXISTS BackupInfo(Id INTEGER PRIMARY KEY AUTOINCREMENT, Software TEXT, Version TEXT, BackupTime DEFAULT CURRENT_TIMESTAMP, BackupBy TEXT)''');

        await myDb.rawInsert(
            "INSERT Into BackupInfo(Software, Version, BackupBy)"
                " VALUES (?, ?, ?)",
            ["EzyRetail Pro", _packageInfo.version, loginUserName]);

        if (backupImgs) {
          setState(() {
            busyMessage = Globalization.backupImage.tr;
          });

          List imgs = await DatabaseHelper.instance.getAllItemImage();

          if (imgs.isNotEmpty) {
            for (var img in imgs) {
              String tmpCode = img[DatabaseHelper.itemCode];
              String tmpPath = img[DatabaseHelper.itemImage];

              final bytes = File(tmpPath).readAsBytesSync();
              String img64 = base64Encode(bytes);

              String query =
                  "UPDATE ${DatabaseHelper.imageTable} SET ${DatabaseHelper.itemImage} = ? WHERE ${DatabaseHelper.itemCode} = ?";
              await myDb.rawUpdate(query, [img64, tmpCode]);
            }
          }

          imgs = [];

          imgs = await DatabaseHelper.instance.getAllPaymentImage();

          if (imgs.isNotEmpty) {
            for (var img in imgs) {
              String tmpCode = img[DatabaseHelper.paymentCode];
              String tmpPath = img[DatabaseHelper.paymentImage];

              final bytes = File(tmpPath).readAsBytesSync();
              String img64 = base64Encode(bytes);

              String query =
                  "UPDATE ${DatabaseHelper.paymentMethodTable} SET ${DatabaseHelper.paymentImage} = ? WHERE ${DatabaseHelper.paymentCode} = ?";
              await myDb.rawUpdate(query, [img64, tmpCode]);
            }
          }

          imgs = [];
        }

        await myDb.close();

        await Get.dialog(
            InformationDialog(
              content:
              '${Globalization.backupComplete.tr}\n${Globalization.path.tr}: $newBackupFile',
            ),
            barrierDismissible: false);
      } else {
        throw Exception(Globalization.errorInBackup.tr);
      }
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

  Future<void> getPermissionStatus() async {
    await Get.dialog(const CheckPermissionDialog(), barrierDismissible: false);
  }

  Future<bool> isAppInstalledFromPlayStore() async {
    try {
      // Get the installer package name
      final packageInfo = await PackageInfo.fromPlatform();
      final installerPackageName = packageInfo.installerStore;

      print(installerPackageName);
      // Check if the installer is Google Play Store
      return installerPackageName == 'com.android.vending';
    } catch (e) {
      print('Error checking install source: $e');
      return false;
    }
  }
}
