import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezyretail/dialogs/backup_files_dialog.dart';
import 'package:ezyretail/dialogs/date_range_dialog.dart';
import 'package:ezyretail/dialogs/error_dialog.dart';
import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/dialogs/yes_no_dialog.dart';
import 'package:ezyretail/globals.dart';
import 'package:ezyretail/helpers/document_upload_module.dart';
import 'package:ezyretail/helpers/image_helper.dart';
import 'package:ezyretail/helpers/sqflite_helper.dart';
import 'package:ezyretail/language/globalization.dart';
import 'package:ezyretail/models/backup_file_object.dart';
import 'package:ezyretail/models/cash_io_model.dart';
import 'package:ezyretail/models/check_out_model.dart';
import 'package:ezyretail/models/company_profile_model.dart';
import 'package:ezyretail/models/customer_model.dart';
import 'package:ezyretail/models/item_barcode_model.dart';
import 'package:ezyretail/models/item_master_model.dart';
import 'package:ezyretail/models/item_menu_model.dart';
import 'package:ezyretail/models/member_server_model.dart';
import 'package:ezyretail/models/payment_method_model.dart';
import 'package:ezyretail/models/promotion_model.dart';
import 'package:ezyretail/models/sales.dart';
import 'package:ezyretail/models/scale_object.dart';
import 'package:ezyretail/models/tax_object.dart';
import 'package:ezyretail/models/user_model.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/pages/splash_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/custom_check_box_list_tile.dart';
import 'package:ezyretail/tools/custom_text_button.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import "package:path/path.dart" as path;

class DataManagementScreen extends StatefulWidget {
  const DataManagementScreen({super.key});

  @override
  State<DataManagementScreen> createState() => _DataManagementScreenState();
}

class _DataManagementScreenState extends State<DataManagementScreen> {
  List<int> autoDownloadTimeList = <int>[0, 5, 15, 30, 60];

  DateTime uploadFromDate = DateTime.now();
  DateTime uploadToDate = DateTime.now();
  DateTime purgeDate = DateTime.now();

  int selectedPurgeOption = 2;
  int selectedUploadOption = 1;

  bool tmpSystemSettings = false;
  bool tmpSystemCustomer = false;
  bool tmpSystemItem = false;
  bool tmpSystemItemImage = false;

  bool isBusy = false;
  String busyText = "";

  bool isFullDownload = false;

  final dio = Dio();

  List<FileSystemEntity> _folders = [];

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    WakelockPlus.enable();
    syncInProgress = true;

    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);

    purgeDate = firstDayOfMonth;
    uploadFromDate = firstDayOfMonth;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    syncInProgress = false;
    WakelockPlus.disable();
    super.dispose();
  }

  Future<void> getDir(String dir) async {
/*    final directory = await getApplicationDocumentsDirectory();
    final dir = directory.path;*/
    String pdfDirectory = dir;
    final myDir = Directory(pdfDirectory);
    setState(() {
      _folders = myDir.listSync(recursive: true, followLinks: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorHelper.myWhite,
          appBar: AppBar(
            backgroundColor: ColorHelper.myDominantColor,
            centerTitle: true,
            title: SizedBox(
                height: 30,
                child: Image.asset("assets/images/ezypos_logo_w.png")),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorHelper.myWhite,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 0),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorHelper.myWhite,
                        ),
                        child: Column(
                          children: [
                            const Gap(10),
                            if (licenceMode == 1 || licenceMode == 3)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          Globalization.downloadMaster.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ColorHelper.myBlack),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  CheckboxListTile(
                                    title: Text(
                                      Globalization.downloadSysSetting.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: ColorHelper.myBlack),
                                    ),
                                    value: tmpSystemSettings,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        tmpSystemSettings = !tmpSystemSettings;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      Globalization.downloadCustomer.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: ColorHelper.myBlack),
                                    ),
                                    value: tmpSystemCustomer,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        tmpSystemCustomer = !tmpSystemCustomer;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    title: Text(
                                      Globalization.downloadItemMaster.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: ColorHelper.myBlack),
                                    ),
                                    value: tmpSystemItem,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        tmpSystemItem = !tmpSystemItem;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    enabled: tmpSystemItem,
                                    title: Text(
                                      Globalization.downloadItemImage.tr,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          color: ColorHelper.myBlack),
                                    ),
                                    value: tmpSystemItemImage,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        tmpSystemItemImage =
                                        !tmpSystemItemImage;
                                      });
                                    },
                                  ),
                                  const Divider(
                                    height: 30,
                                    color: ColorHelper.myDominantColor,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  ListTile(
                                    title: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: ColorHelper.myWhite,
                                          value: isFullDownload,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isFullDownload = value!;
                                            });
                                          },
                                        ),
                                        Flexible(
                                          child: Text(
                                            Globalization.fullDownload.tr,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: ColorHelper.myBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: CustomTextButtonWidget(
                                      text: Globalization.download.tr,
                                      baseColor: ColorHelper.myDominantColor,
                                      onTap: () async {
                                        if (licenceMode == 1) {
                                          if (isFullDownload) {
                                            if (tmpSystemSettings) {
                                              await syncSystemSettings();
                                            }

                                            if (tmpSystemCustomer) {
                                              await syncSystemCustomer();
                                            }

                                            if (tmpSystemItem) {
                                              await fullSyncSystemItem();
                                            }
                                          } else {
                                            if (tmpSystemSettings) {
                                              await syncSystemSettings();
                                            }

                                            if (tmpSystemCustomer) {}

                                            if (tmpSystemItem) {
                                              fastSyncSystemItem();
                                            }
                                          }
                                        } else {
                                          if (isFullDownload) {
                                            if (tmpSystemSettings) {
                                              await downloadSettingsFromCloud();
                                            }

                                            if (tmpSystemItem) {
                                              await downloadFullItemFromCloud();
                                            }
                                          } else {
                                            if (tmpSystemSettings) {
                                              await downloadSettingsFromCloud();
                                            }

                                            if (tmpSystemItem) {
                                              await fastDownloadItemFromCloud();
                                            }
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  const Gap(20),
                                ],
                              ),

                            if (memberIsActive)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "EzyMember",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ColorHelper.myBlack),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  ListTile(
                                    title: Text(
                                      Globalization.downloadMemberRecord.tr,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorHelper.myBlack),
                                    ),
                                    trailing: CustomTextButtonWidget(
                                      text: Globalization.download.tr,
                                      baseColor: ColorHelper.myDominantColor,
                                      onTap: () {
                                        syncSystemMember();
                                      },
                                    ),
                                  ),
                                  const Gap(20),
                                ],
                              ),

                            /*const Divider(
                              height: 40,
                              color: ColorHelper.myDisable2,
                              thickness: 1,
                            ),*/
                            if (licenceMode == 1 || licenceMode == 3)
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          Globalization.uploadData.tr,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ColorHelper.myBlack),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(10),
                                  ListTile(
                                    title: Text(
                                      Globalization.uploadNewRecord.tr,
                                      style: const TextStyle(
                                        color: ColorHelper.myBlack,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                    leading: Radio<int>(
                                      value: 1,
                                      groupValue: selectedUploadOption,
                                      fillColor: WidgetStateProperty.all(
                                          ColorHelper.myDominantColor),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedUploadOption = value!;
                                        });
                                      },
                                    ),
                                    tileColor: ColorHelper.myWhite,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: const BoxDecoration(
                                      color: ColorHelper.myWhite,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Center(
                                                child: Radio<int>(
                                                  value: 2,
                                                  groupValue:
                                                  selectedUploadOption,
                                                  fillColor:
                                                  WidgetStateProperty.all(
                                                      ColorHelper
                                                          .myDominantColor),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedUploadOption =
                                                      value!;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            const Gap(20),
                                            Expanded(
                                              child: Text(
                                                Globalization
                                                    .uploadRecordBetweenDate.tr,
                                                style: const TextStyle(
                                                  color: ColorHelper.myBlack,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                textStyle: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge,
                                              ),
                                              child: Text(
                                                  "${systemShortDate.format(uploadFromDate)} - ${systemShortDate.format(uploadToDate)} "),
                                              onPressed: () async {
                                                var returnDate =
                                                await Get.dialog(
                                                    DateRangeDialog(
                                                      title: Globalization
                                                          .selectDateRange
                                                          .tr,
                                                      startDate:
                                                      uploadFromDate,
                                                      nextDate:
                                                      uploadToDate,
                                                    ),
                                                    barrierDismissible:
                                                    false);

                                                if (returnDate != null) {
                                                  setState(() {
                                                    uploadFromDate =
                                                    returnDate[0];
                                                    uploadToDate =
                                                    returnDate[1];
                                                  });
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 30,
                                    color: ColorHelper.myDominantColor,
                                    thickness: 1,
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  ListTile(
                                    trailing: CustomTextButtonWidget(
                                      text: Globalization.upload.tr,
                                      baseColor: ColorHelper.myDominantColor,
                                      onTap: () {
                                        if (licenceMode == 1) {
                                          postSalesToLinkTools();
                                        } else if (licenceMode == 3) {
                                          postSalesToCloud();
                                        }
                                      },
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        Globalization.syncData.tr,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorHelper.myBlack),
                                      ),
                                    ],
                                  ),
                                  if (userAccess <= 2) const Gap(10),
                                  if (userAccess <= 2)
                                    ListTile(
                                      title: Text(
                                        Globalization.autoUploadTime.tr,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: ColorHelper.myBlack),
                                      ),
                                      trailing: Container(
                                        width: 120,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            const BorderRadius.all(
                                                Radius.circular(5)),
                                            border: Border.all(
                                                color: ColorHelper
                                                    .myDominantColor)),
                                        child: DropdownButton(
                                          alignment:
                                          AlignmentDirectional.centerEnd,
                                          value: autoSynchronizeTime,
                                          underline: const SizedBox(),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: autoDownloadTimeList
                                              .map((int items) {
                                            switch (items) {
                                              case 0:
                                                return DropdownMenuItem(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .centerEnd,
                                                  value: 0,
                                                  child: Text(
                                                    Globalization.none.tr,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              case 5:
                                                return DropdownMenuItem(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .centerEnd,
                                                  value: 5,
                                                  child: Text(
                                                    "5 ${Globalization.minutes.tr}",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              case 15:
                                                return DropdownMenuItem(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .centerEnd,
                                                  value: 15,
                                                  child: Text(
                                                    "15 ${Globalization.minutes.tr}",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              case 30:
                                                return DropdownMenuItem(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .centerEnd,
                                                  value: 30,
                                                  child: Text(
                                                    "30 ${Globalization.minutes.tr}",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              case 60:
                                                return DropdownMenuItem(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .centerEnd,
                                                  value: 60,
                                                  child: Text(
                                                    "60 ${Globalization.minutes.tr}",
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                              default:
                                                return DropdownMenuItem(
                                                  alignment:
                                                  AlignmentDirectional
                                                      .centerEnd,
                                                  value: 0,
                                                  child: Text(
                                                    Globalization.none.tr,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      color:
                                                      ColorHelper.myBlack,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                );
                                            }
                                          }).toList(),
                                          onChanged: (newValue) async {
                                            final prefs =
                                            await SharedPreferences
                                                .getInstance();
                                            await prefs.setInt(
                                                "AutoSyncDuration", newValue!);

                                            setState(() {
                                              autoSynchronizeTime = newValue;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  if (userAccess <= 2)
                                    CustomCheckBoxListTile(
                                      title:
                                      Globalization.downloadItemMaster.tr,
                                      subTitle: Globalization
                                          .syncItemMastSubtitles.tr,
                                      value: autoSyncItem,
                                      enabled: autoSynchronizeTime != 0,
                                      onChanged: (bool? value) async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setBool(
                                            "AutoSyncItem", value!);

                                        if (!value) {
                                          autoSyncImage = false;
                                        }

                                        setState(() {
                                          autoSyncItem = value;
                                        });
                                      },
                                    ),
                                  if (userAccess <= 2)
                                    CustomCheckBoxListTile(
                                      title: Globalization.downloadItemImage.tr,
                                      subTitle:
                                      Globalization.syncItemImageSubtitles,
                                      value: autoSyncImage,
                                      enabled: autoSynchronizeTime != 0 &&
                                          autoSyncItem,
                                      onChanged: (bool? value) async {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setBool(
                                            "AutoSyncImage", value!);

                                        setState(() {
                                          autoSyncImage = value;
                                        });
                                      },
                                    ),
                                  if (userAccess == 1) const Gap(20),
                                ],
                              ),

                            if (userAccess == 1)
                              Row(
                                children: [
                                  Text(
                                    Globalization.purgeData.tr,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorHelper.myBlack),
                                  ),
                                ],
                              ),
                            /* const Divider(
                              height: 40,
                              color: ColorHelper.myDisable2,
                              thickness: 1,
                            ),*/
                            if (userAccess == 1) const Gap(10),
                            //Todo Purge Before date. require opening
                            /* ListTile(
                              title: Text(
                                Globalization.truncateDateBefore.tr,
                                style: const TextStyle(
                                  color: ColorHelper.myBlack,
                                  fontWeight: FontWeight.normal,

                                  fontSize: 14,
                                ),
                              ),
                              trailing: TextButton(
                                style: TextButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.labelLarge,
                                ),
                                child: Text(systemShortDate.format(purgeDate)),
                                onPressed: () async {
                                  DateTime? newToDate = await Get.dialog(
                                      DateSingleDialog(
                                        title: Globalization.selectDate.tr,
                                        initialDate: DateTime.now(),
                                      ),
                                      barrierDismissible: false);

                                  if (newToDate == null) return;

                                  setState(() {
                                    purgeDate = newToDate;
                                  });
                                },
                              ),
                              leading: Radio<int>(
                                value: 1,
                                groupValue: selectedPurgeOption,
                                fillColor: MaterialStateProperty.all(
                                    ColorHelper.myDominantColor),
                                onChanged: (value) {
                                  setState(() {
                                    selectedPurgeOption = value!;
                                  });
                                },
                              ),
                              tileColor: ColorHelper.myWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),*/
                            if (userAccess == 1)
                              ListTile(
                                title: Text(
                                  Globalization.deleteAllTransaction.tr,
                                  style: const TextStyle(
                                    color: ColorHelper.myBlack,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                leading: Radio<int>(
                                  value: 2,
                                  groupValue: selectedPurgeOption,
                                  fillColor: WidgetStateProperty.all(
                                      ColorHelper.myDominantColor),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPurgeOption = value!;
                                    });
                                  },
                                ),
                                tileColor: ColorHelper.myWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            if (userAccess == 1)
                              ListTile(
                                title: Text(
                                  Globalization.deleteAllData.tr,
                                  style: const TextStyle(
                                    color: ColorHelper.myBlack,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                  ),
                                ),
                                leading: Radio<int>(
                                  value: 3,
                                  groupValue: selectedPurgeOption,
                                  fillColor: WidgetStateProperty.all(
                                      ColorHelper.myDominantColor),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPurgeOption = value!;
                                    });
                                  },
                                ),
                                tileColor: ColorHelper.myWhite,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            if (userAccess == 1)
                              const Divider(
                                height: 30,
                                color: ColorHelper.myDominantColor,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                            if (userAccess == 1)
                              ListTile(
                                trailing: CustomTextButtonWidget(
                                  text: Globalization.confirm.tr,
                                  baseColor: ColorHelper.myDominantColor,
                                  onTap: () {
                                    purgeData();
                                  },
                                ),
                              ),

                            if (userAccess == 1) const Gap(20),
                            if (userAccess <= 2)
                              Row(
                                children: [
                                  Text(
                                    Globalization.backupRestoreData.tr,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorHelper.myBlack),
                                  ),
                                ],
                              ),
                            const Gap(10),
                            ListTile(
                              title: Text(
                                Globalization.defaultBackupFolder.tr,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: ColorHelper.myBlack),
                              ),
                              subtitle: Text(
                                defaultBackupPath,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorHelper.myDominantColor),
                              ),
                              trailing: CustomTextButtonWidget(
                                text: Globalization.select.tr,
                                baseColor: ColorHelper.myDominantColor,
                                onTap: () {
                                  selectDefaultBackupFolder();
                                },
                              ),
                            ),
                            if (userAccess <= 2)
                              ListTile(
                                title: Text(
                                  Globalization.backupData.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: ColorHelper.myBlack),
                                ),
                                trailing: CustomTextButtonWidget(
                                  text: Globalization.backup.tr,
                                  baseColor: ColorHelper.myDominantColor,
                                  onTap: () {
                                    dataBackup();
                                  },
                                ),
                              ),
                            if (userAccess == 1)
                              ListTile(
                                title: Text(
                                  Globalization.restoreData.tr,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: ColorHelper.myBlack),
                                ),
                                trailing: CustomTextButtonWidget(
                                  text: Globalization.restore.tr,
                                  baseColor: ColorHelper.myDominantColor,
                                  onTap: () {
                                    restoreFunction();
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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

  Future<void> syncSystemSettings() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingSysSetting.tr;
    });

    String token = systemCompanyProfile?.token ?? '';

    String _serverUrl =
    int.parse(serverPort) == 0 ? serverIp : "http://$serverIp:$serverPort";

    String url =
        '$_serverUrl/api/posterminal/?host=$companyId&keys=$serverKey&token=$token&deviceId=$appId';

    try {
      var response = await dio.get(url);

      // var data = jsonDecode(response.data.toString());
      if (response.statusCode == 201 || response.statusCode == 202) {
        var data = response.data;
        var profile = data['profile'][0];
        var userList = data['users'];
        var paymentList = data['payment'];
        var taxList = data['tax'];
        var memberSetting = data['member'];

        CompanyProfileModel compProfile = CompanyProfileModel.fromJson(profile);

        MemberServerModel memberServerSettings =
        MemberServerModel.fromJson(memberSetting);

        List<UsersModel> listUsers = [];
        for (var data in userList) {
          UsersModel user = UsersModel.fromJson(data);
          listUsers.add(user);
        }

        List<PaymentMethodModel> paymentMethod = [];

        final Directory appDocDir = await getApplicationDocumentsDirectory();

        String documentsDirectoryPath =
            "${appDocDir.path}/${ImageHelper.paymentModeImageFolder}";

        // Ensure the directory exists before writing the file
        await Directory(documentsDirectoryPath).create(recursive: true);

        for (var data in paymentList) {
          PaymentMethodModel payment = PaymentMethodModel.fromJson(data);
          if (payment.withImage) {
            String token = compProfile.token;
            var imageUrl =
                '$_serverUrl/api/posterminal/GetPaymentPictures?host=$companyId&key=$serverKey&terminal=$appId&token=$token&paymentCode=${payment.code}';

            String encodeItemCode = Uri.encodeComponent(payment.code);

            String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

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

        url =
        '$_serverUrl/api/Scale/?host=$companyId&key=$serverKey&terminal=$appId&token=$token';

        response = await dio.get(url);

        log(response.toString());
        if (response.statusCode == 200) {
          var data = response.data;
          ScaleObject scaleSettings = ScaleObject.fromJson(data["settings"]);
        }

        url =
        '$_serverUrl/api/Promotion/?host=$companyId&key=$serverKey&terminal=$appId&token=$token&promotion=0';

        response = await dio.get(url);

        if (response.statusCode == 200) {
          var data = response.data;
          int batchCount = data["CountInfo"]["TotalBatch"];
          List<dynamic> promo = data["PROMOTIONS"];

          List<PromotionModel> promotionModel =
          promo.map((e) => PromotionModel.fromJson(e)).toList();

          await DatabaseHelper.instance.insertPromotion(promotionModel);
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

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("memberServerSetting",
            jsonEncode(memberServerSettings.toJson(memberServerSettings)));

        if (!tmpSystemItem) {
          await Get.dialog(
              const InformationDialog(content: Globalization.downloadComplete),
              barrierDismissible: false);
        }
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
        isBusy = false;
      });
    }
  }

  Future<void> syncSystemCustomer() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingCustomer.tr;
    });

    String token = systemCompanyProfile?.token ?? '';

    try {
      String _serverUrl = int.parse(serverPort) == 0
          ? serverIp
          : "http://$serverIp:$serverPort";

      String url =
          '$_serverUrl/api/Customer/GetFullCustomerList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&batch=0';

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        await DatabaseHelper.instance.dropCustomerTable();

        var data = response.data;
        print(response);
        List<dynamic> tempCustList = data['CustList'];

        print(tempCustList);

        List<CustomerModel> customers =
        tempCustList.map((e) => CustomerModel.fromLinkTools(e)).toList();

        if (customers.isNotEmpty) {
          if (!await DatabaseHelper.instance.insertCustomers(customers)) {
            throw Exception(Globalization.errorInsertItemMaster.tr);
          }
        }

        int totalBatch = data['CountInfo']['TotalBatch'];

        if (totalBatch > 0) {
          for (var i = 0; i <= totalBatch; i++) {
            double counter = ((i + 1) / totalBatch) * 100;

            setState(() {
              busyText = "${Globalization.downloadingItemMaster.tr} $counter %";
            });

            await Future.delayed(const Duration(seconds: 1));

            url =
            '$_serverUrl/api/Customer/GetFullCustomerList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&batch=${i + 1}';

            response = await dio.get(url);

            if (response.statusCode == 200) {
              data = response.data;
              tempCustList = data['CustList'];

              customers = tempCustList
                  .map((e) => CustomerModel.fromLinkTools(e))
                  .toList();

              if (!await DatabaseHelper.instance.insertCustomers(customers)) {
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
    } on DioException catch (e) {
      await Get.dialog(
        ErrorDialog(
            title: Globalization.warning.tr,
            content:
            "${e.response?.statusCode} ${e.response?.data["Message"]}"),
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

  Future<void> syncSystemMember() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingCustomer.tr;
    });

    try {
      String url =
          "https://$memberServerUrl/api/$memberServerId/allMembers?batch_code=0";

      var response = await dio.get(url,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $memberPublicKey$memberPrivateKey",
          }));

      if (response.statusCode == 200) {
        await DatabaseHelper.instance.dropMemberTable();
        var result = response.data;

        int batchCount = result["totalBatch"];
        List<dynamic> tempItemList = result['member'];
        List<MemberModel> members =
        tempItemList.map((e) => MemberModel.fromJson(e)).toList();

        await DatabaseHelper.instance.insertEzyMember(members);

        if (batchCount > 1) {
          for (var x = 1; x < batchCount; x++) {
            url =
            "https://$memberServerUrl/api/$memberServerId/allMembers?batch_code=$x";

            response = await dio.get(url,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $memberPublicKey$memberPrivateKey",
                }));

            if (response.statusCode == 200) {
              result = response.data;
              tempItemList = result['member'];
              members =
                  tempItemList.map((e) => MemberModel.fromJson(e)).toList();
              await DatabaseHelper.instance.insertEzyMember(members);
            }
          }
        }
        await Get.dialog(
            InformationDialog(
                content: Globalization.downloadMemberCompleted.tr),
            barrierDismissible: false);
      }
    } catch (e) {
      await Get.dialog(
        ErrorDialog(title: Globalization.warning.tr, content: e.toString()),
        barrierDismissible: false,
      );
    } finally {
      setState(() {
        isBusy = false;
        busyText = "";
      });
    }
  }

  Future<void> fastSyncSystemItem() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingItemMaster.tr;
    });

    final prefs = await SharedPreferences.getInstance();

    //Sync Item Master

    String token = systemCompanyProfile?.token ?? '';

    String lastSyncDate = DateFormat('ddMMyyyyHHmm').format(lastSyncItemDate);

    try {
      String _serverUrl = int.parse(serverPort) == 0
          ? serverIp
          : "http://$serverIp:$serverPort";

      String url =
          '$_serverUrl/api/PosItem/GetFastItemsList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&last=$lastSyncDate&items=0';

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        var data = response.data;
        List<dynamic> tempItemList = data['ItemList'];

        List<ItemMasterModel> items =
        tempItemList.map((e) => ItemMasterModel.fromJson(e)).toList();

        int totalBatch = data['CountInfo']['TotalBatch'];

        if (items.isNotEmpty) {
          if (!await DatabaseHelper.instance.fastInsertItem(items)) {
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
            '$_serverUrl/api/PosItem/GetFastItemsList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&last=$lastSyncDate&items=${i + 1}';

            response = await dio.get(url);

            if (response.statusCode == 200) {
              data = response.data;
              tempItemList = data['ItemList'];

              items =
                  tempItemList.map((e) => ItemMasterModel.fromJson(e)).toList();

              if (!await DatabaseHelper.instance.fastInsertItem(items)) {
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
      '$_serverUrl/api/PosBarcode/GetFastBarcodeList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&last=$lastSyncDate&barcode=0';

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
            '$_serverUrl/api/PosBarcode/GetFastBarcodeList?host=$companyId&key=$serverKey&terminal=$appId&token=$token&last=$lastSyncDate&barcode=${i + 1}';

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

      await DatabaseHelper.instance.dropMenuHeaderTable();
      await DatabaseHelper.instance.dropMenuDetailTable();

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

      lastSyncDate = DateFormat('ddMMyyyyHHmm').format(lastSyncImgDate);

      if (tmpSystemItemImage) {
        setState(() {
          busyText = Globalization.downloadingItemImage.tr;
        });

        String imgFolder = ImageHelper.itemImageFolder;

        String baseUrl = '$_serverUrl/api/ItemImage/GetFastImageList';

        Map<String, String> queryParams = {
          'host': companyId,
          'key': serverKey,
          'terminal': appId,
          'token': token,
          'last': lastSyncDate,
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
              await Future.delayed(const Duration(milliseconds: 100));

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
      await Get.dialog(
          InformationDialog(content: Globalization.downloadComplete.tr),
          barrierDismissible: false);
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

      if (tmpSystemItemImage) {
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

      await Get.dialog(
          InformationDialog(content: Globalization.downloadComplete.tr),
          barrierDismissible: false);
    } on DioException catch (e) {
      await Get.dialog(
        ErrorDialog(
            title: Globalization.warning.tr,
            content:
            "${e.response?.statusCode} ${e.response?.data["Message"]}"),
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

  Future<bool> downloadItemImage(
      List<dynamic> itemImageList, String token) async {
    bool result = false;

    final Directory appDocDir = await getApplicationDocumentsDirectory();

    String documentsDirectoryPath =
        "${appDocDir.path}/${ImageHelper.itemImageFolder}";

    await Directory(documentsDirectoryPath).create(recursive: true);

    String _serverUrl =
    int.parse(serverPort) == 0 ? serverIp : "http://$serverIp:$serverPort";

    for (String itemCode in itemImageList) {
      try {
        String encodeItemCode = Uri.encodeComponent(itemCode);

        String imageUrl =
            '$_serverUrl/api/ItemImage/GetPictures?host=$companyId&key=$serverKey&terminal=$appId&token=$token&itemCode=$encodeItemCode';

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

  Future<void> postSalesToLinkTools() async {
    setState(() {
      isBusy = true;
    });

    int chunkSize = 200;

    String _serverUrl =
    int.parse(serverPort) == 0 ? serverIp : "http://$serverIp:$serverPort";

    if (await checkApiConnection(_serverUrl)) {
      //Upload by date range
      if (selectedUploadOption == 2) {
        DateTime firstDate = uploadFromDate;
        DateTime lastHourOfDay = DateTime(uploadToDate.year, uploadToDate.month,
            uploadToDate.day, 23, 59, 59);

        int totalRecords = await DatabaseHelper.instance
            .getTotalUploadRecordsSalesByDate(firstDate, lastHourOfDay);

        if (totalRecords > 0) {
          int numChunks = (totalRecords / chunkSize).ceil();

          for (int i = 0; i < numChunks; i++) {
            List<String> docNumList = [];
            List<FullSalesDoc> salesDocList = await DatabaseHelper.instance
                .getAllSalesDocListByDate(
                i, chunkSize, firstDate, lastHourOfDay);

            for (FullSalesDoc tmp in salesDocList) {
              docNumList.add(tmp.invoiceDoc);
            }

            String? token = systemCompanyProfile?.token;

            if (salesDocList.isNotEmpty && token != null) {
              String url =
                  '$_serverUrl/api/EzySales/PostBatchSales?host=$companyId&key=$serverKey&terminal=$appId&token=$token';
              String returnResult = await uploadSalesRec(url, salesDocList);

              await DatabaseHelper.instance
                  .updateSyncLogRecordsStatus(docNumList, returnResult);
            }
          }
        }

        totalRecords = await DatabaseHelper.instance
            .getTotalUploadReturnRecordsByDate(firstDate, lastHourOfDay);

        if (totalRecords > 0) {
          int numChunks = (totalRecords / chunkSize).ceil();

          for (int i = 0; i < numChunks; i++) {
            List<String> docNumList = [];
            List<FullSalesDoc> returnDocList = await DatabaseHelper.instance
                .getAllReturnDocListByDate(
                i, chunkSize, firstDate, lastHourOfDay);

            for (FullSalesDoc tmp in returnDocList) {
              docNumList.add(tmp.invoiceDoc);
            }

            String? token = systemCompanyProfile?.token;

            if (returnDocList.isNotEmpty && token != null) {
              String url =
                  '$_serverUrl/api/EzyReturn/PostBatchReturn?host=$companyId&key=$serverKey&terminal=$appId&token=$token';
              String returnResult = await uploadSalesRec(url, returnDocList);

              await DatabaseHelper.instance
                  .updateSyncLogRecordsStatus(docNumList, returnResult);
            }
          }
        }

        totalRecords = await DatabaseHelper.instance
            .getTotalUploadCashIoRecordsByDate(firstDate, lastHourOfDay);

        if (totalRecords > 0) {
          List<String> docNumList = [];
          List<CashIoUploadModel> cashIoDocList = await DatabaseHelper.instance
              .getUploadCashIoDocListByDate(firstDate, lastHourOfDay);

          for (CashIoUploadModel tmp in cashIoDocList) {
            docNumList.add(tmp.docNo);
          }

          String? token = systemCompanyProfile?.token;

          if (cashIoDocList.isNotEmpty && token != null) {
            String url =
                '$_serverUrl/api/CashInOut/PostCashIoDetails?host=$companyId&key=$serverKey&terminal=$appId&token=$token';
            String imgUrl = "$_serverUrl/api/cashioatch";

            Directory tempDir = await getTemporaryDirectory();

            String returnResult = await uploadCashIoRec(
                url, imgUrl, companyId, serverKey, cashIoDocList, tempDir);

            await DatabaseHelper.instance
                .updateSyncLogRecordsStatus(docNumList, returnResult);
          }
        }
      } else {
        int totalRecords =
        await DatabaseHelper.instance.getTotalPendingSalesRecords();

        if (totalRecords > 0) {
          int numChunks = (totalRecords / chunkSize).ceil();

          for (int i = 0; i < numChunks; i++) {
            int offset = i * chunkSize;
            List<SyncObject> records = await DatabaseHelper.instance
                .getCSSyncLogLimitRec(chunkSize, offset, "CS");

            if (records.isNotEmpty) {
              List<String> docNumList = [];

              for (SyncObject tmp in records) {
                docNumList.add(tmp.docNo);
              }

              List<FullSalesDoc> salesDocList = await DatabaseHelper.instance
                  .getAllSalesDocByList(docNumList);

              String? token = systemCompanyProfile?.token;

              if (salesDocList.isNotEmpty && token != null) {
                String url =
                    '$_serverUrl/api/EzySales/PostBatchSales?host=$companyId&key=$serverKey&terminal=$appId&token=$token';
                String returnResult = await uploadSalesRec(url, salesDocList);

                await DatabaseHelper.instance
                    .updateSyncLogRecordsStatus(docNumList, returnResult);
              }
            }
          }
        }

        totalRecords =
        await DatabaseHelper.instance.getTotalPendingReturnRecords();

        if (totalRecords > 0) {
          int numChunks = (totalRecords / chunkSize).ceil();

          for (int i = 0; i < numChunks; i++) {
            int offset = i * chunkSize;
            List<SyncObject> records = await DatabaseHelper.instance
                .getCSSyncLogLimitRec(chunkSize, offset, "CN");

            if (records.isNotEmpty) {
              List<String> docNumList = [];

              for (SyncObject tmp in records) {
                docNumList.add(tmp.docNo);
              }

              List<FullSalesDoc> salesDocList = await DatabaseHelper.instance
                  .getAllReturnDocByList(docNumList);

              String? token = systemCompanyProfile?.token;

              if (salesDocList.isNotEmpty && token != null) {
                String url =
                    '$_serverUrl/api/EzyReturn/PostBatchReturn?host=$companyId&key=$serverKey&terminal=$appId&token=$token';
                String returnResult = await uploadSalesRec(url, salesDocList);

                await DatabaseHelper.instance
                    .updateSyncLogRecordsStatus(docNumList, returnResult);
              }
            }
          }
        }

        totalRecords =
        await DatabaseHelper.instance.getTotalPendingCashIoRecords();

        if (totalRecords > 0) {
          int numChunks = (totalRecords / chunkSize).ceil();

          for (int i = 0; i < numChunks; i++) {
            int offset = i * chunkSize;
            List<SyncObject> records = await DatabaseHelper.instance
                .getCSSyncLogLimitRec(chunkSize, offset, "IO");

            if (records.isNotEmpty) {
              List<String> docNumList = [];

              for (SyncObject tmp in records) {
                docNumList.add(tmp.docNo);
              }

              List<CashIoUploadModel> cashIoDocList = await DatabaseHelper
                  .instance
                  .getPendingUploadCashIoRecords(docNumList);

              String? token = systemCompanyProfile?.token;

              if (cashIoDocList.isNotEmpty && token != null) {
                String url =
                    '$_serverUrl/api/CashInOut/PostCashIoDetails?host=$companyId&key=$serverKey&terminal=$appId&token=$token';
                String imgUrl = "$_serverUrl/api/cashioatch";

                Directory tempDir = await getTemporaryDirectory();

                String returnResult = await uploadCashIoRec(
                    url, imgUrl, companyId, serverKey, cashIoDocList, tempDir);

                await DatabaseHelper.instance
                    .updateSyncLogRecordsStatus(docNumList, returnResult);
              }
            }
          }
        }
      }

      await Get.dialog(
          InformationDialog(content: Globalization.uploadCompleted.tr),
          barrierDismissible: false);
    } else {
      await Get.dialog(
          WarningDialog(content: Globalization.failConnectServer.tr),
          barrierDismissible: false);
    }

    setState(() {
      isBusy = false;
    });
  }

  Future<String> uploadSalesRec(
      String url, List<FullSalesDoc> salesDocList) async {
    final dio = Dio();

    String result = "";
    String salesHeaderListString = jsonEncode(salesDocList);

    try {
      final response = await dio.post(
        url,
        data: salesHeaderListString,
      );

      if (response.statusCode == 200) {
        result = "SUCCESS";
      } else {
        result = "${response.statusCode} ${response.data}";
      }
    } catch (e) {
      result = e.toString();
    }

    return result;
  }

  Future<void> purgeData() async {
    switch (selectedPurgeOption) {
      case 1:
      //ToDo delete by date
        await Get.dialog(const WarningDialog(content: "1"));
        break;
      case 2:
        if (systemBatchKey != "") {
          await Get.dialog(
              const WarningDialog(content: "Please close counter first"),
              barrierDismissible: false);
          return;
        }

        bool confirmPurge = false;

        await Get.dialog(
            YesNoDialog(
              title: Globalization.areYouSure.tr,
              content: Globalization.confirmClearPOSTransaction.tr,
              onConfirm: () {
                confirmPurge = true;
                Get.back();
              },
              onCancel: () {
                Get.back();
              },
            ),
            barrierDismissible: false);

        if (confirmPurge) {
          setState(() {
            busyText = Globalization.purgeData.tr;
            isBusy = true;
            isBusy = true;
          });

          if (await DatabaseHelper.instance.deleteTransactionTable()) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('batchKey');

            systemBatchKey = "";

            await Get.dialog(
                InformationDialog(content: Globalization.operationComplete.tr),
                barrierDismissible: false);
          }

          setState(() {
            busyText = "";
            isBusy = false;
          });
        }
        break;
      case 3:
        bool confirmPurge = false;

        await Get.dialog(
            YesNoDialog(
              title: Globalization.areYouSure.tr,
              content: Globalization.confirmClearResetPOSData.tr,
              onConfirm: () {
                confirmPurge = true;
                Get.back();
              },
              onCancel: () {
                Get.back();
              },
            ),
            barrierDismissible: false);

        if (confirmPurge) {
          setState(() {
            busyText = Globalization.purgeData.tr;
            isBusy = true;
          });

          if (licenceMode == 1 || licenceMode == 3) {
            int totalSalesRecords =
            await DatabaseHelper.instance.getTotalPendingSalesRecords();

            int totalReturnRecords =
            await DatabaseHelper.instance.getTotalPendingReturnRecords();

            int totalIoRecords =
            await DatabaseHelper.instance.getTotalPendingCashIoRecords();

            if (totalSalesRecords + totalReturnRecords + totalIoRecords > 0) {
              confirmPurge = false;

              await Get.dialog(
                  YesNoDialog(
                    title: Globalization.areYouSure.tr,
                    content: Globalization.confirmClearWithPendingData.tr,
                    onConfirm: () {
                      confirmPurge = true;
                      Get.back();
                    },
                    onCancel: () {
                      Get.back();
                    },
                  ),
                  barrierDismissible: false);
            }
          }

          if (confirmPurge) {
            if (await DatabaseHelper.instance.dropAllTable()) {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('batchKey');

              systemBatchKey = "";
              systemCompanyProfile = null;
              counter = 0;
              wareHouse = "";

              lastSyncItemDate = DateTime.now();
              lastSyncImgDate = DateTime.now();
              lastSyncCustomerDate = DateTime.now();

              List<UsersModel> userList = [];

              if (licenceMode == 0 || licenceMode == 2) {
                UsersModel defaultUser = UsersModel(
                    userKey: 'ADMIN',
                    name: 'ADMIN',
                    password: 'Admin',
                    access: 1,
                    pin: '1234');

                userList.add(defaultUser);

                await DatabaseHelper.instance.insertUserList(userList);
              }

              Get.offAll(() => const SplashScreen());
            }
          }
          setState(() {
            busyText = "";
            isBusy = false;
          });
        }
    }
  }

  Future<void> dataBackup() async {
    if (systemBatchKey != "") {
      await Get.dialog(
          WarningDialog(content: Globalization.closeCounterBeforeBackup.tr),
          barrierDismissible: false);
      return;
    }

    bool backupImgs = false;

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
      busyText = Globalization.backupData.tr;
      isBusy = true;
    });

    const fileName = "EzyRetail";

    final fullFolderPath = Directory("$defaultBackupPath/");
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/${DatabaseHelper.databaseName}');

    var outputFormat = DateFormat('yyMMdd');
    String newBackupFile = path.join(
        '${fullFolderPath.absolute.path}$fileName${outputFormat.format(DateTime.now())}.ezr');

    try {
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
            busyText = Globalization.backupImage.tr;
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
      await Get.dialog(
          ErrorDialog(content: "${Globalization.error.tr} : ${e.toString()}"),
          barrierDismissible: false);
    }

    setState(() {
      busyText = "";
      isBusy = false;
    });
  }

  Future<void> restoreFunction() async {
    if (systemBatchKey != "") {
      await Get.dialog(
          WarningDialog(content: Globalization.closeCounterBeforeRestore.tr),
          barrierDismissible: false);
      return;
    }

    final fullFolderPath = Directory("$defaultBackupPath/");
    final dbFolder = await getDatabasesPath();
    const dbName = DatabaseHelper.databaseName;
    final fulldbName = "$dbFolder/$dbName";

    try {
      bool confirmRestoreData = false;

      await Get.dialog(
          YesNoDialog(
              title: Globalization.areYouSure.tr,
              content: Globalization.confirmDataRestoreOverwriteAndRestart.tr,
              onConfirm: () {
                confirmRestoreData = true;
                Get.back();
              },
              onCancel: () {
                Get.back();
              }),
          barrierDismissible: false);

      if (confirmRestoreData) {
        setState(() {
          busyText = Globalization.dataRestore.tr;
          isBusy = true;
        });

        List<FileSystemEntity> listFilesInDocuments = fullFolderPath.listSync();
        List<BackupFilesObject> backupFilesList = [];

        if (listFilesInDocuments.isNotEmpty) {
          for (FileSystemEntity files in listFilesInDocuments) {
            if (files is File) {
              FileStat fileStat = await FileStat.stat(files.path);
              if (path.extension(files.path) == '.ezr') {
                BackupFilesObject backupFile = BackupFilesObject(
                    fileName: files.path.split("/").last,
                    filePath: files.absolute.path,
                    createDate: fileStat.changed);

                backupFilesList.add(backupFile);
              }
            }
          }
        }

        BackupFilesObject? result = await Get.dialog(
            BackupFilesDialog(
              folderPath: fullFolderPath.path,
              backupFilesList: backupFilesList,
            ),
            barrierDismissible: false);

        // if no file is picked
        if (result == null) {
          setState(() {
            busyText = "";
            isBusy = false;
          });
          return;
        }

        String sourcePath = result.filePath;

        Database? myDb = await openDatabase(sourcePath);

        var chkResult = await myDb.query('sqlite_master',
            where: 'name = ?', whereArgs: [DatabaseHelper.companyProfileTable]);

        if (chkResult.isEmpty) {
          await Get.dialog(
              WarningDialog(content: Globalization.invalidBackupFile.tr),
              barrierDismissible: false);

          setState(() {
            busyText = "";
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
            busyText = "";
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
            busyText = "";
            isBusy = false;
          });

          return;
        }

        await myDb.close();

        await DatabaseHelper.instance.closeDatabase();

        File source1 = File(sourcePath);

        await source1.copy(fulldbName);

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

        await Get.dialog(
            InformationDialog(
              content: Globalization.restoreCompleteLogout.tr,
            ),
            barrierDismissible: false);

        await Future.delayed(const Duration(milliseconds: 100));

        Get.offAll(() => const LoginScreen());
        // Restart.restartApp();
      }
    } catch (e) {
      debugPrint(e.toString());
      await Get.dialog(ErrorDialog(content: "Error : ${e.toString()}"),
          barrierDismissible: false);
    }

    setState(() {
      busyText = "";
      isBusy = false;
    });
  }

  Future<void> selectDefaultBackupFolder() async {
    Directory rootPath = Directory("storage/emulated/0/");

    var status = await Permission.storage.status;
    if (!status.isGranted) {
      // If not we will ask for permission first
      await Permission.storage.request();
    }

    if (Platform.isAndroid) {
      rootPath = Directory("storage/emulated/0/");
    } else {
      rootPath = await getApplicationDocumentsDirectory();
    }

    if (!mounted) return;

    String? backupPath = await FilesystemPicker.openDialog(
        contextActions: [
          FilesystemPickerNewFolderContextAction(),
        ],
        title: Globalization.backupFolder.tr,
        context: context,
        rootDirectory: rootPath,
        fsType: FilesystemType.folder,
        pickText: Globalization.saveToFolder.tr,
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
            foregroundColor: ColorHelper.myWhite,
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        folderIconColor: ColorHelper.myAccentColor);

    if (backupPath != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("DefaultBackupFolder", backupPath);

      setState(() {
        defaultBackupPath = backupPath;
      });
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

          if (!tmpSystemItem) {
            await Get.dialog(
                const InformationDialog(
                    content: Globalization.downloadComplete),
                barrierDismissible: false);
          }
        }

        url = "https://$serverUrl/api/$companyKey/get-promotion-list";

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          var data = response.data;
          List<dynamic> promo = data["promotion"];
          List<PromotionModel> promotionModel =
          promo.map((e) => PromotionModel.fromCloud(e)).toList();

          await DatabaseHelper.instance.insertPromotion(promotionModel);
        }

        url = "https://$serverUrl/api/$companyKey/get-reason-list";

        queryData = {"batch_code": 0};

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          await DatabaseHelper.instance.dropCashInOutReasonTable();

          var data = response.data;
          List<dynamic> tempItemList = data['reason_list'];
          int batchCount = data["total_batch"];

          List<CashIoReasonModel> items =
          tempItemList.map((e) => CashIoReasonModel.fromCloud(e)).toList();

          if (items.isNotEmpty) {
            await DatabaseHelper.instance.insertCashIReason(items);

            if (batchCount > 1) {
              for (var x = 1; x < batchCount; x++) {
                url = "https://$serverUrl/api/$companyKey/get-reason-list";

                queryData = {"batch_code": x};

                response = await dio.post(url,
                    data: queryData,
                    options: Options(headers: {
                      "Content-Type": "application/json",
                      "Authorization": "Bearer $bearerToken",
                    }));

                if (response.statusCode == 200) {
                  var data = response.data;
                  tempItemList = data['reason_list'];

                  items = tempItemList
                      .map((e) => CashIoReasonModel.fromCloud(e))
                      .toList();

                  if (items.isNotEmpty) {
                    await DatabaseHelper.instance.insertCashIReason(items);
                  }
                }
              }
            }
          }
        }
      }
    } on DioException catch (e) {
      // print(e.response?.statusCode);
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
        isBusy = false;
      });
    }
  }

  Future<void> fastDownloadItemFromCloud() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingItemMaster.tr;
    });

    final prefs = await SharedPreferences.getInstance();

    try {
      String bearerToken = "$publicKey$privateKey";
      String url = "https://$serverUrl/api/$companyKey/fast-download-item";

      Map<String, dynamic> queryData = {
        "date_time": cloudDateTime.format(lastSyncItemDate),
        "batch_code": 0
      };

      var response = await dio.post(url,
          data: queryData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $bearerToken",
          }));

      if (response.statusCode == 200) {
        var data = response.data;
        List<dynamic> tempItemList = data['item_list'];
        int batchCount = data["total_batch"];

        List<ItemMasterModel> items =
        tempItemList.map((e) => ItemMasterModel.fromCloud(e)).toList();

        if (items.isNotEmpty) {
          if (!await DatabaseHelper.instance.fastInsertItem(items)) {
            throw Exception(Globalization.errorInsertItemMaster.tr);
          }
        }

        if (batchCount > 1) {
          for (var x = 1; x < batchCount; x++) {
            url = "https://$serverUrl/api/$companyKey/fast-download-item";

            Map<String, dynamic> queryData = {
              "date_time": cloudDateTime.format(lastSyncItemDate),
              "batch_code": x
            };

            response = await dio.post(url,
                data: queryData,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $bearerToken",
                }));

            if (response.statusCode == 200) {
              data = response.data;

              tempItemList = data['item_list'];

              items = tempItemList
                  .map((e) => ItemMasterModel.fromCloud(e))
                  .toList();

              if (items.isNotEmpty) {
                if (!await DatabaseHelper.instance.fastInsertItem(items)) {
                  throw Exception(Globalization.errorInsertItemMaster.tr);
                }
              }
            }
          }
        }

        url = "https://$serverUrl/api/$companyKey/fast-download-barcode";

        Map<String, dynamic> queryData = {
          "date_time": cloudDateTime.format(lastSyncItemDate),
          "batch_code": 0
        };

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          data = response.data;

          List<dynamic> tempBarcodeList = data['barcode_list'];
          int batchCount = data["total_batch"];

          List<ItemBarcodeModel> barcodes = tempBarcodeList
              .map((e) => ItemBarcodeModel.fromCloud(e))
              .toList();

          if (barcodes.isNotEmpty) {
            if (!await DatabaseHelper.instance.insertItemBarcode(barcodes)) {
              throw Exception(Globalization.insertItemMasterBarcode.tr);
            }
          }

          if (batchCount > 1) {
            for (var x = 1; x < batchCount; x++) {
              url = "https://$serverUrl/api/$companyKey/fast-download-barcode";

              Map<String, dynamic> queryData = {
                "date_time": cloudDateTime.format(lastSyncItemDate),
                "batch_code": x
              };

              response = await dio.post(url,
                  data: queryData,
                  options: Options(headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer $bearerToken",
                  }));

              if (response.statusCode == 200) {
                data = response.data;

                tempBarcodeList = data['barcode_list'];

                barcodes = tempBarcodeList
                    .map((e) => ItemBarcodeModel.fromCloud(e))
                    .toList();

                if (barcodes.isNotEmpty) {
                  if (!await DatabaseHelper.instance
                      .insertItemBarcode(barcodes)) {
                    throw Exception(Globalization.insertItemMasterBarcode.tr);
                  }
                }
              }
            }
          }

          lastSyncItemDate = DateTime.now();

          String dateString = lastSyncItemDate.toIso8601String();
          await prefs.setString("LastSyncItemDate", dateString);
        }

        //Item Menu
        setState(() {
          busyText = Globalization.downloadingItemMenu.tr;
        });

        await Future.delayed(const Duration(milliseconds: 100));

        url = "https://$serverUrl/api/$companyKey/get-all-info";

        queryData = {"app_id": appId};

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          await DatabaseHelper.instance.dropMenuHeaderTable();
          await DatabaseHelper.instance.dropMenuDetailTable();

          data = response.data;
          List<dynamic> tempHeaderList = data['menu_header_list'];
          List<dynamic> tempDetailsList = data['menu_detail_list'];

          List<ItemMenuModel> itemHdr =
          tempHeaderList.map((e) => ItemMenuModel.fromCloud(e)).toList();
          List<ItemMenuModel> itemDtl =
          tempDetailsList.map((e) => ItemMenuModel.fromCloud(e)).toList();

          if (!await DatabaseHelper.instance.insertItemMenuHeader(itemHdr)) {
            throw Exception(Globalization.insertItemMenuHdr.tr);
          }

          if (!await DatabaseHelper.instance.insertItemMenuDetail(itemDtl)) {
            throw Exception(Globalization.insertItemMenuDtl.tr);
          }
        }

        if (tmpSystemItemImage) {
          setState(() {
            busyText = Globalization.downloadingItemImage.tr;
          });

          await downloadFastImageFromCloud();
        }

        await Get.dialog(
            InformationDialog(content: Globalization.downloadComplete.tr),
            barrierDismissible: false);
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
        isBusy = false;
      });
    }
  }

  Future<void> downloadFullItemFromCloud() async {
    setState(() {
      isBusy = true;
      busyText = Globalization.downloadingItemMaster.tr;
    });

    final prefs = await SharedPreferences.getInstance();

    try {
      String bearerToken = "$publicKey$privateKey";
      String url =
          "https://$serverUrl/api/$companyKey/get-full-item-list?batch_code=0";

      Map<String, dynamic> queryData = {"app_id": appId};

      var response = await dio.post(url,
          data: queryData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $bearerToken",
          }));

      if (response.statusCode == 200) {
        await DatabaseHelper.instance.dropItemTbl();
        await DatabaseHelper.instance.dropBarcodeTbl();
        await DatabaseHelper.instance.dropMenuHeaderTable();
        await DatabaseHelper.instance.dropMenuDetailTable();

        var data = response.data;
        List<dynamic> tempItemList = data['item_list'];
        int batchCount = data["total_batch"];

        List<ItemMasterModel> items =
        tempItemList.map((e) => ItemMasterModel.fromCloud(e)).toList();

        if (items.isNotEmpty) {
          if (!await DatabaseHelper.instance.insertItem(items)) {
            throw Exception(Globalization.errorInsertItemMaster.tr);
          }
        }

        if (batchCount > 1) {
          for (var x = 1; x < batchCount; x++) {
            url =
            "https://$serverUrl/api/$companyKey/get-full-item-list?batch_code=$x";

            response = await dio.post(url,
                data: queryData,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $bearerToken",
                }));

            if (response.statusCode == 200) {
              data = response.data;

              tempItemList = data['item_list'];

              items = tempItemList
                  .map((e) => ItemMasterModel.fromCloud(e))
                  .toList();

              if (items.isNotEmpty) {
                if (!await DatabaseHelper.instance.insertItem(items)) {
                  throw Exception(Globalization.errorInsertItemMaster.tr);
                }
              }
            }
          }
        }

        url =
        "https://$serverUrl/api/$companyKey/get-item-barcode?batch_code=0";

        response = await dio.post(url,
            data: queryData,
            options: Options(headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $bearerToken",
            }));

        if (response.statusCode == 200) {
          data = response.data;

          List<dynamic> tempBarcodeList = data['barcode_list'];
          int batchCount = data["total_batch"];

          List<ItemBarcodeModel> barcodes = tempBarcodeList
              .map((e) => ItemBarcodeModel.fromCloud(e))
              .toList();

          if (barcodes.isNotEmpty) {
            if (!await DatabaseHelper.instance.insertItemBarcode(barcodes)) {
              throw Exception(Globalization.insertItemMasterBarcode.tr);
            }
          }

          if (batchCount > 1) {
            for (var x = 1; x < batchCount; x++) {
              url =
              "https://$serverUrl/api/$companyKey/get-item-barcode?batch_code=$x";

              response = await dio.post(url,
                  data: queryData,
                  options: Options(headers: {
                    "Content-Type": "application/json",
                    "Authorization": "Bearer $bearerToken",
                  }));

              if (response.statusCode == 200) {
                data = response.data;

                tempBarcodeList = data['barcode_list'];

                barcodes = tempBarcodeList
                    .map((e) => ItemBarcodeModel.fromCloud(e))
                    .toList();

                if (barcodes.isNotEmpty) {
                  if (!await DatabaseHelper.instance
                      .insertItemBarcode(barcodes)) {
                    throw Exception(Globalization.insertItemMasterBarcode.tr);
                  }
                }
              }
            }
          }

          lastSyncItemDate = DateTime.now();

          String dateString = lastSyncItemDate.toIso8601String();
          await prefs.setString("LastSyncItemDate", dateString);

          //Item Menu
          setState(() {
            busyText = Globalization.downloadingItemMenu.tr;
          });

          await Future.delayed(const Duration(milliseconds: 100));

          url = "https://$serverUrl/api/$companyKey/get-all-info";

          response = await dio.post(url,
              data: queryData,
              options: Options(headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $bearerToken",
              }));

          if (response.statusCode == 200) {
            data = response.data;
            List<dynamic> tempHeaderList = data['menu_header_list'];
            List<dynamic> tempDetailsList = data['menu_detail_list'];

            List<ItemMenuModel> itemHdr =
            tempHeaderList.map((e) => ItemMenuModel.fromCloud(e)).toList();
            List<ItemMenuModel> itemDtl =
            tempDetailsList.map((e) => ItemMenuModel.fromCloud(e)).toList();

            if (!await DatabaseHelper.instance.insertItemMenuHeader(itemHdr)) {
              throw Exception(Globalization.insertItemMenuHdr.tr);
            }

            if (!await DatabaseHelper.instance.insertItemMenuDetail(itemDtl)) {
              throw Exception(Globalization.insertItemMenuDtl.tr);
            }
          }

          if (tmpSystemItemImage) {
            setState(() {
              busyText = Globalization.downloadingItemImage.tr;
            });

            await downloadFullImageFromCloud();
          }

          await Get.dialog(
              const InformationDialog(content: Globalization.downloadComplete),
              barrierDismissible: false);
        }
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
        isBusy = false;
      });
    }
  }

  Future<void> postSalesToCloud() async {
    setState(() {
      isBusy = true;
    });

    int chunkSize = 50;

    //Upload by date range
    if (selectedUploadOption == 2) {
      DateTime firstDate = uploadFromDate;
      DateTime lastHourOfDay = DateTime(
          uploadToDate.year, uploadToDate.month, uploadToDate.day, 23, 59, 59);

      int totalRecords = await DatabaseHelper.instance
          .getTotalUploadRecordsSalesByDate(firstDate, lastHourOfDay);

      if (totalRecords > 0) {
        int numChunks = (totalRecords / chunkSize).ceil();

        for (int i = 0; i < numChunks; i++) {
          List<String> docNumList = [];
          List<FullSalesDoc> salesDocList = await DatabaseHelper.instance
              .getAllSalesDocListByDate(i, chunkSize, firstDate, lastHourOfDay);

          for (FullSalesDoc tmp in salesDocList) {
            docNumList.add(tmp.invoiceDoc);
          }

          if (salesDocList.isNotEmpty) {
            String url = 'https://$serverUrl/api/$companyKey/post-sales-list';

            String bearerToken = "$publicKey$privateKey";

            CloudWrap salesDocs = CloudWrap(
                salesDocsList: salesDocList,
                token: systemCompanyProfile!.token,
                location: systemCompanyProfile!.locationCode,
                appID: appId);

            String returnResult =
            await uploadSalesDocToCloud(url, bearerToken, salesDocs);

            await DatabaseHelper.instance
                .updateSyncLogRecordsStatus(docNumList, returnResult);
          }
        }
      }

      totalRecords = await DatabaseHelper.instance
          .getTotalUploadReturnRecordsByDate(firstDate, lastHourOfDay);

      if (totalRecords > 0) {
        int numChunks = (totalRecords / chunkSize).ceil();

        for (int i = 0; i < numChunks; i++) {
          List<String> docNumList = [];
          List<FullSalesDoc> returnDocList = await DatabaseHelper.instance
              .getAllReturnDocListByDate(
              i, chunkSize, firstDate, lastHourOfDay);

          for (FullSalesDoc tmp in returnDocList) {
            docNumList.add(tmp.invoiceDoc);
          }

          if (returnDocList.isNotEmpty) {
            String url =
                'https://$serverUrl/api/$companyKey/post-sales-return-list';

            String bearerToken = "$publicKey$privateKey";

            CloudWrap returnDocs = CloudWrap(
                salesDocsList: returnDocList,
                token: systemCompanyProfile!.token,
                location: systemCompanyProfile!.locationCode,
                appID: appId);

            String returnResult =
            await uploadSalesDocToCloud(url, bearerToken, returnDocs);

            await DatabaseHelper.instance
                .updateSyncLogRecordsStatus(docNumList, returnResult);
          }
        }
      }

      totalRecords = await DatabaseHelper.instance
          .getTotalUploadCashIoRecordsByDate(firstDate, lastHourOfDay);

      if (totalRecords > 0) {
        List<String> docNumList = [];
        List<CashIoUploadModel> cashIoDocList = await DatabaseHelper.instance
            .getUploadCashIoDocListByDate(firstDate, lastHourOfDay);

        for (CashIoUploadModel tmp in cashIoDocList) {
          docNumList.add(tmp.docNo);
        }

        if (cashIoDocList.isNotEmpty) {
          String url =
              'https://$serverUrl/api/$companyKey/post-cash-in-out-history';
          String imgUrl =
              'https://$serverUrl/api/$companyKey/upload-cash-io-image';

          String bearerToken = "$publicKey$privateKey";

          Directory tempDir = await getTemporaryDirectory();

          String returnResult = await uploadCashIoRecToCloud(
              url, imgUrl, bearerToken, cashIoDocList, tempDir);

          await DatabaseHelper.instance
              .updateSyncLogRecordsStatus(docNumList, returnResult);
        }
      }
    } else {
      int totalRecords =
      await DatabaseHelper.instance.getTotalPendingSalesRecords();

      if (totalRecords > 0) {
        int numChunks = (totalRecords / chunkSize).ceil();

        for (int i = 0; i < numChunks; i++) {
          int offset = i * chunkSize;
          List<SyncObject> records = await DatabaseHelper.instance
              .getCSSyncLogLimitRec(chunkSize, offset, "CS");

          if (records.isNotEmpty) {
            List<String> docNumList = [];

            for (SyncObject tmp in records) {
              docNumList.add(tmp.docNo);
            }

            List<FullSalesDoc> salesDocList =
            await DatabaseHelper.instance.getAllSalesDocByList(docNumList);

            if (salesDocList.isNotEmpty) {
              String url = 'https://$serverUrl/api/$companyKey/post-sales-list';

              String bearerToken = "$publicKey$privateKey";

              CloudWrap salesDocs = CloudWrap(
                  salesDocsList: salesDocList,
                  token: systemCompanyProfile!.token,
                  location: systemCompanyProfile!.locationCode,
                  appID: appId);

              String returnResult =
              await uploadSalesDocToCloud(url, bearerToken, salesDocs);

              await DatabaseHelper.instance
                  .updateSyncLogRecordsStatus(docNumList, returnResult);
            }
          }
        }
      }

      totalRecords =
      await DatabaseHelper.instance.getTotalPendingReturnRecords();

      if (totalRecords > 0) {
        int numChunks = (totalRecords / chunkSize).ceil();

        for (int i = 0; i < numChunks; i++) {
          int offset = i * chunkSize;
          List<SyncObject> records = await DatabaseHelper.instance
              .getCSSyncLogLimitRec(chunkSize, offset, "CN");

          if (records.isNotEmpty) {
            List<String> docNumList = [];

            for (SyncObject tmp in records) {
              docNumList.add(tmp.docNo);
            }

            List<FullSalesDoc> returnDocList =
            await DatabaseHelper.instance.getAllReturnDocByList(docNumList);

            if (returnDocList.isNotEmpty) {
              String url =
                  'https://$serverUrl/api/$companyKey/post-sales-return-list';

              String bearerToken = "$publicKey$privateKey";

              CloudWrap salesDocs = CloudWrap(
                  salesDocsList: returnDocList,
                  token: systemCompanyProfile!.token,
                  location: systemCompanyProfile!.locationCode,
                  appID: appId);

              String returnResult =
              await uploadSalesDocToCloud(url, bearerToken, salesDocs);

              await DatabaseHelper.instance
                  .updateSyncLogRecordsStatus(docNumList, returnResult);
            }
          }
        }
      }

      totalRecords =
      await DatabaseHelper.instance.getTotalPendingCashIoRecords();

      if (totalRecords > 0) {
        int numChunks = (totalRecords / chunkSize).ceil();

        for (int i = 0; i < numChunks; i++) {
          int offset = i * chunkSize;
          List<SyncObject> records = await DatabaseHelper.instance
              .getCSSyncLogLimitRec(chunkSize, offset, "IO");

          if (records.isNotEmpty) {
            List<String> docNumList = [];

            for (SyncObject tmp in records) {
              docNumList.add(tmp.docNo);
            }

            List<CashIoUploadModel> cashIoDocList = await DatabaseHelper
                .instance
                .getPendingUploadCashIoRecords(docNumList);

            if (cashIoDocList.isNotEmpty) {
              String url =
                  'https://$serverUrl/api/$companyKey/post-cash-in-out-history';
              String imgUrl =
                  'https://$serverUrl/api/$companyKey/upload-cash-io-image';

              String bearerToken = "$publicKey$privateKey";

              Directory tempDir = await getTemporaryDirectory();

              String returnResult = await uploadCashIoRecToCloud(
                  url, imgUrl, bearerToken, cashIoDocList, tempDir);

              await DatabaseHelper.instance
                  .updateSyncLogRecordsStatus(docNumList, returnResult);
            }
          }
        }
      }
    }

    await Get.dialog(
        InformationDialog(content: Globalization.uploadCompleted.tr),
        barrierDismissible: false);

    setState(() {
      isBusy = false;
    });
  }

  Future<void> downloadFullImageFromCloud() async {
    String bearerToken = "$publicKey$privateKey";
    String url = "https://$serverUrl/api/$companyKey/get-item-image";

    Map<String, dynamic> queryData = {"batch_code": 0};

    try {
      var response = await dio.post(url,
          data: queryData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $bearerToken",
          }));

      if (response.statusCode == 200) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();

        String imgFolder = ImageHelper.itemImageFolder;
        await ImageHelper.clearItemFolder(imgFolder);
        await DatabaseHelper.instance.dropImageTbl();

        var data = response.data;
        List<dynamic> tempItemList = data['image_list'];
        int batchCount = data["total_batch"];

        if (tempItemList.isNotEmpty) {
          String documentsDirectoryPath =
              "${appDocDir.path}/${ImageHelper.itemImageFolder}";

          await Directory(documentsDirectoryPath).create(recursive: true);

          for (var item in tempItemList) {
            Uint8List bytes = base64Decode(item["item_image"]);

            String encodeItemCode = Uri.encodeComponent(item["item_code"]);

            String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

            File file = File(imagePath);
            await file.writeAsBytes(bytes);

            await DatabaseHelper.instance
                .insertItemImage(encodeItemCode, imagePath);

            await Future.delayed(const Duration(milliseconds: 100));
          }
        }

        if (batchCount > 1) {
          for (var x = 1; x < batchCount; x++) {
            queryData = {"batch_code": x};

            response = await dio.post(url,
                data: queryData,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $bearerToken",
                }));

            if (response.statusCode == 200) {
              data = response.data;
              tempItemList = data['image_list'];

              if (tempItemList.isNotEmpty) {
                String documentsDirectoryPath =
                    "${appDocDir.path}/${ImageHelper.itemImageFolder}";

                for (var item in tempItemList) {
                  Uint8List bytes = base64Decode(item["item_image"]);

                  String encodeItemCode =
                  Uri.encodeComponent(item["item_code"]);

                  String imagePath =
                      "$documentsDirectoryPath/$encodeItemCode.png";

                  File file = File(imagePath);
                  await file.writeAsBytes(bytes);

                  await DatabaseHelper.instance
                      .insertItemImage(encodeItemCode, imagePath);

                  await Future.delayed(const Duration(milliseconds: 100));
                }
              }
            }
          }
        }

        lastSyncImgDate = DateTime.now();

        String dateString = lastSyncImgDate.toIso8601String();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("LastSyncImgDate", dateString);
      }
    } on DioException catch (e) {
      await Get.dialog(WarningDialog(content: e.response?.data['message']));
    } catch (e) {
      await Get.dialog(WarningDialog(content: e.toString()));
    }
  }

  Future<void> downloadFastImageFromCloud() async {
    String bearerToken = "$publicKey$privateKey";
    String url = "https://$serverUrl/api/$companyKey/fast-download-image";

    Map<String, dynamic> queryData = {
      "date_time": cloudDateTime.format(lastSyncImgDate),
      "batch_code": 0
    };

    try {
      var response = await dio.post(url,
          data: queryData,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $bearerToken",
          }));

      if (response.statusCode == 200) {
        final Directory appDocDir = await getApplicationDocumentsDirectory();

        String imgFolder = ImageHelper.itemImageFolder;
        await ImageHelper.clearItemFolder(imgFolder);
        await DatabaseHelper.instance.dropImageTbl();

        var data = response.data;
        List<dynamic> tempItemList = data['image_list'];
        int batchCount = data["total_batch"];

        if (tempItemList.isNotEmpty) {
          String documentsDirectoryPath =
              "${appDocDir.path}/${ImageHelper.itemImageFolder}";

          await Directory(documentsDirectoryPath).create(recursive: true);

          for (var item in tempItemList) {
            if (item["item_image"].toString().isNotEmpty) {
              Uint8List bytes = base64Decode(item["item_image"]);

              String encodeItemCode = Uri.encodeComponent(item["item_code"]);

              String imagePath = "$documentsDirectoryPath/$encodeItemCode.png";

              File file = File(imagePath);
              await file.writeAsBytes(bytes);

              await DatabaseHelper.instance
                  .insertItemImage(encodeItemCode, imagePath);

              await Future.delayed(const Duration(milliseconds: 100));
            }
          }
        }

        if (batchCount > 1) {
          for (var x = 1; x < batchCount; x++) {
            queryData = {
              "date_time": cloudDateTime.format(lastSyncImgDate),
              "batch_code": x
            };

            response = await dio.post(url,
                data: queryData,
                options: Options(headers: {
                  "Content-Type": "application/json",
                  "Authorization": "Bearer $bearerToken",
                }));

            if (response.statusCode == 200) {
              data = response.data;
              tempItemList = data['image_list'];

              if (tempItemList.isNotEmpty) {
                String documentsDirectoryPath =
                    "${appDocDir.path}/${ImageHelper.itemImageFolder}";

                for (var item in tempItemList) {
                  Uint8List bytes = base64Decode(item["item_image"]);

                  String encodeItemCode =
                  Uri.encodeComponent(item["item_code"]);

                  String imagePath =
                      "$documentsDirectoryPath/$encodeItemCode.png";

                  File file = File(imagePath);
                  await file.writeAsBytes(bytes);

                  await DatabaseHelper.instance
                      .insertItemImage(encodeItemCode, imagePath);

                  await Future.delayed(const Duration(milliseconds: 100));
                }
              }
            }
          }
        }

        lastSyncImgDate = DateTime.now();

        String dateString = lastSyncImgDate.toIso8601String();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("LastSyncImgDate", dateString);
      }
    } on DioException catch (e) {
      await Get.dialog(WarningDialog(content: e.response?.data['message']));
    } catch (e) {
      await Get.dialog(WarningDialog(content: e.toString()));
    }
  }

  Future<bool> checkApiConnection(String hostUrl) async {
    bool result = false;
    final localDio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5), // Connection timeout
        sendTimeout: const Duration(seconds: 5), // Send timeout
        receiveTimeout: const Duration(seconds: 5), // Receive timeout
      ),
    );

    try {
      String url = '$hostUrl/api/TestConnection';
      final response = await localDio.get(
        url,
      );

      if (response.statusCode == 200) {
        result = true;
      }
    } catch (e) {
      result = false;
    }

    return result;
  }
}
