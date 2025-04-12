import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/helpers/general_helper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../globals.dart';
import '../../../language/globalization.dart';
import '../../../models/dealer_model.dart';
import '../../../themes/color_helper.dart';
import '../../tools/custom_text_button.dart';

class DealerLoginDialog extends StatefulWidget {
  const DealerLoginDialog({super.key});

  @override
  State<DealerLoginDialog> createState() => _DealerLoginDialogState();
}

class _DealerLoginDialogState extends State<DealerLoginDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
        "Dealer Login",
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
              "Email:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            TextField(
              controller: emailController,
              maxLength: 35,
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
            const Text(
              "Password:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorHelper.myBlack,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            TextField(
              controller: passwordController,
              maxLength: 25,
              obscureText: true,
              obscuringCharacter: '*',
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
              text: Globalization.confirm.tr,
              baseColor: ColorHelper.myDominantColor,
              onTap: () {
                _dealerLogin();
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _dealerLogin() async {
    if (!validateEmail(emailController.text.trim())) {
      await Get.dialog(const WarningDialog(content: "Invalid email address"),
          barrierDismissible: false);
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String tmpMachineId = prefs.getString("MachineId") ?? "";
    String tmpLicenseKey = prefs.getString("LicenseKey") ?? "";

    DealerModel dealer = DealerModel(
        dealerId: emailController.text.trim(),
        dealerPassword: passwordController.text.trim(),
        appId: tmpMachineId,
        licenceKey: tmpLicenseKey);

    Get.back(result: dealer);
  }
}
