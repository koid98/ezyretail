import 'package:ezyretail/models/backup_file_object.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../globals.dart';
import '../../language/globalization.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';

class BackupFilesDialog extends StatefulWidget {
  final String folderPath;
  final List<BackupFilesObject> backupFilesList;
  const BackupFilesDialog(
      {super.key, required this.folderPath, required this.backupFilesList});

  @override
  State<BackupFilesDialog> createState() => _BackupFilesDialogState();
}

class _BackupFilesDialogState extends State<BackupFilesDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        "Path : ${widget.folderPath}",
        style: const TextStyle(
          color: ColorHelper.myBlack,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      content: Container(
        constraints: const BoxConstraints(minWidth: 300, maxWidth: 600),
        width: 600,
        color: ColorHelper.myDefaultBackColor,
        child: widget.backupFilesList.isNotEmpty
            ? ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: widget.backupFilesList.length,
            itemBuilder: (BuildContext context, int index) {
              return fileObjectWidget(index, widget.backupFilesList[index]);
            })
            : Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Image.asset(
              "assets/images/no_document.png",
              height: 100,
              width: 100,
              fit: BoxFit.scaleDown,
              color: ColorHelper.myDisable2,
            ),
          ),
        ),
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
          ],
        ),
      ],
    );
  }

  Widget fileObjectWidget(int index, BackupFilesObject item) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ZoomTapAnimation(
        onTap: () {
          Get.back(result: item);
        },
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
          child: ListTile(
            tileColor: ColorHelper.myWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text(
              item.fileName,
              style: const TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.filePath,
                  style: const TextStyle(
                    color: ColorHelper.myGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                Text(
                  systemLongDate.format(item.createDate),
                  style: const TextStyle(
                    color: ColorHelper.myGrey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
