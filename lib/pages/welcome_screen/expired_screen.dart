import 'package:ezyretail/dialogs/app_activation_dialog.dart';
import 'package:ezyretail/dialogs/information_dialog.dart';
import 'package:ezyretail/dialogs/request_license_dialog.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:ezyretail/helpers/license_file_handle.dart';
import 'package:ezyretail/helpers/network_helper.dart';
import 'package:ezyretail/pages/login_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/custom_small_text_button.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../globals.dart';

class ExpiredScreen extends StatefulWidget {
  const ExpiredScreen({super.key});

  @override
  State<ExpiredScreen> createState() => _ExpiredScreenState();
}

class _ExpiredScreenState extends State<ExpiredScreen> {
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
                  child: Image.asset("assets/images/trial_expired.png"),
                ),
              ),
            ),
            Container(
              color: ColorHelper.myWhite,
              constraints: const BoxConstraints(minWidth: 300, maxWidth: 400),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: actionSection(),
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
                      child: Image.asset("assets/images/trial_expired.png")),
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
                    child: actionSection(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actionSection() {
    return ListView(
      shrinkWrap: true,
      physics: MediaQuery.of(context).orientation == Orientation.landscape
          ? const BouncingScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      children: [
        const Text(
          "Trial Period Expired",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "Dear Sir/Madam,",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "Thank you for trying EzyRetail Pro. We hope you enjoyed exploring its features.",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "We wanted to let you know that your trial period has now ended. To proceed with your license activation, please click the Request License button below. Once you have submitted your request, we will promptly arrange for a system consultant to assist you with the activation process.",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(15),
        Row(
          children: [
            CustomSmallTextButtonWidget(
              text: "Request License",
              baseColor: ColorHelper.myDominantColor,
              onTap: () {
                requestLicence();
              },
            ),
          ],
        ),
        const Gap(15),
        const Text(
          "Thank you once again for trying EzyRetail Pro. We look forward to having you as a valued customer.",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "Best regards,",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "EzySolutions Team",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Text(
          "We're here to make things Ezy",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
      ],
    );
  }

  Future<void> requestLicence() async {
    var result = await Get.dialog(const RequestLicenceDialog(),
        barrierDismissible: false);

    if (result != null) {
      if (result == "register") {
        activateDevice();
      }
    }
  }

  Future<void> activateDevice() async {
    var result = await Get.dialog(const AppActivationDialog(),
        barrierDismissible: false);

    if (result != null) {
      String licenceKey = result.toString();

      if (licenceKey != "" && appId != "") {
        setState(() {
          isBusy = true;
          busyMessage = "Connecting To Host";
        });

        final conn = NetWorkHelper();
        result = await conn.activateLicenceOnly(appId.trim(), licenceKey);

        if (result.toString() == "SUCCESS") {
          await deleteLicenseFile();
          await writeLicenseKey(licenceKey.trim());

          setState(() {
            isBusy = false;
            busyMessage = "";
          });

          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool("SystemIsActivated", true);
          activateStatus = true;
          prefs.remove("trialExpDate");

          await Get.dialog(const InformationDialog(content: "System Activated"),
              barrierDismissible: false);

          Get.offAll(() => const LoginScreen());
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
}
