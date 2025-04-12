import 'package:ezyretail/globals.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuspendScreen extends StatefulWidget {
  const SuspendScreen({super.key});

  @override
  State<SuspendScreen> createState() => _SuspendScreenState();
}

class _SuspendScreenState extends State<SuspendScreen> {
  bool isBusy = false;
  String busyMessage = "";
  String tmpAppId = "";
  String tmpLicenceKey = "";

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  Future<void> getAppInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    tmpAppId = prefs.getString("MachineId") ?? appId;
    tmpLicenceKey = prefs.getString("LicenseKey") ?? "";

    setState(() {});
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
                  child: Image.asset("assets/images/system_locked.png"),
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
                      child: Image.asset("assets/images/system_locked.png")),
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
          "Licence Suspended",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "Dear Valued Customer,",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "We regret to inform you that your device licence has been suspended. To resolve this issue, please contact your system consultant.",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        Text(
          "Application ID : $tmpAppId",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        Text(
          "Licence Key : $tmpLicenceKey",
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
        const Text(
          "If you believe this suspension is an error or you need further assistance, please feel free to drop us an email. We are here to help you and resolve any issues as quickly as possible.",
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
          "support@ezysolutions.com.my",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorHelper.myDominantColor),
        ),
        const Gap(10),
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
}
