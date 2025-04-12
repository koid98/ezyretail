import 'dart:convert';

import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../globals.dart';
import '../../../language/globalization.dart';
import '../../../themes/color_helper.dart';
import '../../tools/custom_text_button.dart';

class RequestLicenceDialog extends StatefulWidget {
  const RequestLicenceDialog({super.key});

  @override
  State<RequestLicenceDialog> createState() => _RequestLicenceDialogState();
}

class _RequestLicenceDialogState extends State<RequestLicenceDialog> {
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: const Text(
        "Request Licence",
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
                    fontSize: 12,
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
              "Contact Person:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            TextField(
              controller: contactPersonController,
              maxLength: 100,
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
            const Gap(10),
            Text(
              Globalization.contactNumber.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            TextField(
              controller: contactNumberController,
              maxLength: 100,
              keyboardType: TextInputType.number,
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
            const Gap(10),
            Text(
              Globalization.emailAddress.tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            TextField(
              controller: emailController,
              maxLength: 100,
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
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextButtonWidget(
                  text: Globalization.cancel.tr,
                  baseColor: ColorHelper.myRed,
                  onTap: () {
                    Get.back();
                  },
                ),
                CustomTextButtonWidget(
                  text: "Send Request",
                  baseColor: ColorHelper.myGreen,
                  onTap: () {
                    Map<String, dynamic> tmpContact = {
                      'name': contactPersonController.text.trim(),
                      'contact': contactNumberController.text.trim(),
                      'email': emailController.text.trim(),
                    };

                    String jsonString = jsonEncode(tmpContact);

                    Get.back(result: jsonString);
                  },
                ),
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextButtonWidget(
                    text: "I have my licence key",
                    baseColor: ColorHelper.myDominantColor,
                    onTap: () {
                      Get.back(result: "register");
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _copyToClipboard() async {
    if (appId.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: appId));

      await Get.dialog(const InformationDialog(content: 'Copied to clipboard!'),
          barrierDismissible: false);
    }
  }
}
