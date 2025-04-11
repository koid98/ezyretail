import 'package:disk_space_plus/disk_space_plus.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../globals.dart';
import '../../language/globalization.dart';
import '../../models/shift_batch_model.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';

class StatusInfoDialog extends StatefulWidget {
  const StatusInfoDialog({super.key});

  @override
  State<StatusInfoDialog> createState() => _StatusInfoDialogState();
}

class _StatusInfoDialogState extends State<StatusInfoDialog> {
  double availableStorage = 0.0;
  double totalStorage = 0.0;
  Color indicatorColor = ColorHelper.myDominantColor;
  String openCounterUser = "";
  String openCounterTime = "";
  bool appIsFromPlayStore = false;

  @override
  void initState() {
    super.initState();
    _getStorageInfo();
    getShiftInfo();
  }

  Future<void> _getStorageInfo() async {
    try {
      appIsFromPlayStore = await isAppInstalledFromPlayStore();
      // Using disk_space package to get available and total storage space
      final double? tmpAvailableStorage = await DiskSpacePlus.getFreeDiskSpace;
      final double? tmpTotalStorage = await DiskSpacePlus.getTotalDiskSpace;

      if (tmpAvailableStorage != null) {
        availableStorage = tmpAvailableStorage;
      }

      if (tmpTotalStorage != null) {
        totalStorage = tmpTotalStorage;
      }

      if (totalStorage > 0) {
        double tmpCal = availableStorage / totalStorage;

        if (tmpCal >= 0.8 && tmpCal < 0.9) {
          indicatorColor = ColorHelper.myAccentColor;
        } else if (tmpCal >= 0.9) {
          indicatorColor = ColorHelper.myRed;
        }
      }

      setState(() {});
    } catch (e) {
      print('Failed to get storage info: $e');
    }
  }

  Future<void> getShiftInfo() async {
    if (systemBatchKey != "") {
      List<ShiftObject> shiftObjectList = [];

      shiftObjectList =
      await DatabaseHelper.instance.getSingleShift(systemBatchKey);

      if (shiftObjectList.isNotEmpty) {
        for (ShiftObject obj in shiftObjectList) {
          openCounterUser = obj.openUser;
          openCounterTime = systemLongDate.format(obj.openTime);
          print(openCounterUser);
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Image.asset("assets/icons/info_icon.png", height: 30),
          const Text(
            "Counter Info",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorHelper.myBlack,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            "App ID : $appId",
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorHelper.myDominantColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
        width: 400,
        color: ColorHelper.myDefaultBackColor,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              "Company : ${systemCompanyProfile?.name}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "Counter : ${systemCompanyProfile?.label}${systemCompanyProfile?.counter.toString().padLeft(2, '0')}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            Text(
              "User : $loginUserName",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            const Gap(10),
            systemBatchKey == ""
                ? const Text(
              "Counter Status : Close",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            )
                : ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  "Counter Status : Open",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorHelper.myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Counter Start At: $openCounterTime",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorHelper.myBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Open By : $openCounterUser",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorHelper.myBlack,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Gap(20),
            if (totalStorage > 0)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Available Storage",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: ColorHelper.myDominantColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  LinearProgressIndicator(
                    color: indicatorColor,
                    value: availableStorage / totalStorage, // 70% progress
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${availableStorage.toPrecision(2)}/${totalStorage.toPrecision(2)} MB",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                          color: ColorHelper.myDominantColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appIsFromPlayStore
                ? const SizedBox()
                : ZoomTapAnimation(
              onTap: () {
                // Get.to(() => const DownloadUpdatePage(
                //   isSettingPage: false,
                // ));
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: ColorHelper.myWhite,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Image.asset("assets/icons/app_download.png",
                    height: 25),
              ),
            ),
            CustomTextButtonWidget(
              text: Globalization.close.tr,
              baseColor: ColorHelper.myRed,
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<bool> isAppInstalledFromPlayStore() async {
    try {
      // Get the installer package name
      final packageInfo = await PackageInfo.fromPlatform();
      final installerPackageName = packageInfo.installerStore;

      // Check if the installer is Google Play Store
      return installerPackageName == 'com.android.vending';
    } catch (e) {
      print('Error checking install source: $e');
      return false;
    }
  }
}
