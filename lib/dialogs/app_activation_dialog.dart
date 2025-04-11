import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/helpers/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../globals.dart';
import '../../../language/globalization.dart';
import '../../../themes/color_helper.dart';
import '../../tools/custom_text_button.dart';

class AppActivationDialog extends StatefulWidget {
  const AppActivationDialog({super.key});

  @override
  State<AppActivationDialog> createState() => _AppActivationDialogState();
}

class _AppActivationDialogState extends State<AppActivationDialog> {
  TextEditingController activateKeyController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSetting();
  }

  Future<void> loadSetting() async {
    final prefs = await SharedPreferences.getInstance();
    String tmpLicense = prefs.getString("LicenseKey") ?? "";

    activateKeyController.text = tmpLicense;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: const Text(
        "Product Activation",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorHelper.myBlack,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "App ID:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appId,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorHelper.myBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                ZoomTapAnimation(
                  onTap: () {
                    _copyToClipboard();
                  },
                  child: const Icon(
                    Icons.copy,
                    size: 20,
                    color: ColorHelper.myDominantColor,
                  ),
                ),
              ],
            ),
            const Gap(10),
            const Text(
              "Activation Code:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            TextField(
              controller: activateKeyController,
              maxLength: 25,
              textCapitalization: TextCapitalization.characters,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                counterText: "",
                contentPadding:
                EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 1, color: ColorHelper.myDominantColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(width: 1, color: ColorHelper.myDominantColor),
                ),
              ),
            ),
          ],
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
            const Gap(10),
            CustomTextButtonWidget(
              text: Globalization.activate.tr,
              baseColor: ColorHelper.myDominantColor,
              onTap: () {
                Get.back(result: activateKeyController.text.trim());
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> activateDevice() async {
    final conn = NetWorkHelper();
    String result = await conn.activateLicenceAndReset(
        appId.trim(), activateKeyController.text.trim());

    Get.back(result: result);
  }

  Future<void> _copyToClipboard() async {
    if (appId.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: appId));

      await Get.dialog(const InformationDialog(content: 'Copied to clipboard!'),
          barrierDismissible: false);
    }
  }
}
