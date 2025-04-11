import 'package:ezyretail/globals.dart';
import 'package:ezyretail/language/globalization.dart';
import 'package:ezyretail/pages/menu_screen.dart';
import 'package:ezyretail/themes/color_helper.dart';
import 'package:ezyretail/tools/custom_text_button.dart';
import 'package:ezyretail/tools/loading_indictor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPINLogin = false;
  bool invalidName = false;
  bool invalidPassword = false;
  bool sec = true;
  bool isBusy = false;
  String busyMessage = "";

  final _focusNode = FocusNode();

  var nameController = TextEditingController();
  var passwordController = TextEditingController();

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorHelper.myWhite,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    PopupMenuButton<String>(
                      icon: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        child: Image.asset(
                          "assets/icons/gear.png",
                          height: 25,
                        ),
                      ),
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        if (licenceMode == 3)
                          PopupMenuItem<String>(
                            value: "cloudServer",
                            child: ListTile(
                              leading: Image.asset(
                                  "assets/icons/link_server.png",
                                  height: 30),
                              title: Text(
                                Globalization.cloudServer.tr,
                                style: const TextStyle(
                                  color: ColorHelper.myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        if (licenceMode == 1)
                          PopupMenuItem<String>(
                            value: "serverSettings",
                            child: ListTile(
                              leading: Image.asset(
                                  "assets/icons/edit_server.png",
                                  height: 30),
                              title: Text(
                                Globalization.serverSettings.tr,
                                style: const TextStyle(
                                  color: ColorHelper.myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        if (licenceMode == 1)
                          PopupMenuItem<String>(
                            value: "pairServer",
                            child: ListTile(
                              leading: Image.asset(
                                  "assets/icons/link_server.png",
                                  height: 30),
                              title: Text(
                                Globalization.pairServer.tr,
                                style: const TextStyle(
                                  color: ColorHelper.myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        if (licenceMode == 0)
                          PopupMenuItem<String>(
                            value: "resetPassword",
                            child: ListTile(
                              leading: Image.asset(
                                  "assets/icons/reset_password.png",
                                  height: 30),
                              title: Text(
                                Globalization.resetAdminPassword.tr,
                                style: const TextStyle(
                                  color: ColorHelper.myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        if (!activateStatus) const PopupMenuDivider(),
                        if (!activateStatus)
                          PopupMenuItem<String>(
                            value: "Register",
                            child: ListTile(
                              leading: Image.asset("assets/icons/register.png",
                                  height: 30),
                              title: const Text(
                                "Activate License",
                                style: TextStyle(
                                  color: ColorHelper.myBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                      ],
                      onSelected: (value) {
                        // switch (value) {
                        //   case "serverSettings":
                        //     changeServerSettings();
                        //     break;
                        //   case "pairServer":
                        //     pairServer();
                        //     break;
                        //   case "resetPassword":
                        //     resetAdminPassword();
                        //     break;
                        //   case "cloudServer":
                        //     connectCloudServer();
                        //     break;
                        //   case "Register":
                        //     activateDevice();
                        // }
                      },
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: ColorHelper.myWhite,
                    constraints:
                    const BoxConstraints(minWidth: 300, maxWidth: 400),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              color: ColorHelper.myDefaultBackColor,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        2 *
                                        0.6,
                                    width:
                                    MediaQuery.of(context).size.width * 0.8,
                                    child:
                                    Image.asset("assets/images/sales.png")),
                              ),
                            ),
                            GestureDetector(
                              onLongPress: () {
                                // verifyDealerForAccess();
                              },
                              child: Image.asset(
                                "assets/images/ezypos_logo.png",
                              ),
                            ),
                            const Gap(30),
                            Container(
                              decoration: BoxDecoration(
                                color: ColorHelper.myWhite,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
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
                              child: TextField(
                                enabled: true,
                                obscureText: isPINLogin ? true : false,
                                obscuringCharacter: '*',
                                controller: nameController,
                                cursorColor: ColorHelper.myDominantColor,
                                textInputAction: TextInputAction.none,
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: ColorHelper.myWhite,
                                  prefixIcon: isPINLogin
                                      ? const Icon(
                                    Icons.password,
                                    color: ColorHelper.myDominantColor,
                                  )
                                      : const Icon(
                                    Icons.person,
                                    color: ColorHelper.myDominantColor,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 2, bottom: 2, left: 5, right: 5),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide.none,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Image.asset(
                                        isPINLogin
                                            ? "assets/icons/password.png"
                                            : "assets/icons/pin.png",
                                        height: 25),
                                    onPressed: () async {
                                      final prefs =
                                      await SharedPreferences.getInstance();
                                      await prefs.setBool(
                                          "usePinLogin", !isPINLogin);

                                      nameController.clear();
                                      passwordController.clear();

                                      setState(() {
                                        isPINLogin = !isPINLogin;
                                      });
                                    },
                                  ),
                                  hintText: isPINLogin
                                      ? Globalization.fastLoginPIN.tr
                                      : Globalization.userID.tr,
                                  hintStyle: const TextStyle(
                                    color: ColorHelper.myDisable1,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                            const Gap(10),
                            if (isPINLogin)
                              SizedBox(height: 100, child: numberPad()),
                            Visibility(
                              visible: !isPINLogin,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorHelper.myWhite,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5)),
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
                                child: TextField(
                                  enabled: true,
                                  obscureText: sec,
                                  controller: passwordController,
                                  cursorColor: ColorHelper.myDominantColor,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: ColorHelper.myWhite,
                                    prefixIcon: const Icon(
                                      Icons.vpn_key,
                                      color: ColorHelper.myDominantColor,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          sec = !sec;
                                        });
                                      },
                                      icon: sec
                                          ? Image.asset(
                                        "assets/icons/no_eyes.png",
                                        height: 25,
                                      )
                                          : Image.asset(
                                        "assets/icons/eyes.png",
                                        height: 25,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 2, bottom: 2, left: 5, right: 5),
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: Globalization.password.tr,
                                    hintStyle: const TextStyle(
                                      color: ColorHelper.myDisable1,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(30),
                            ZoomTapAnimation(
                              onTap: () async {
                                Get.offAll(() => const MenuScreen());
                                // await loginProcess();
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: ColorHelper.myDominantColor,
                                ),
                                child: Center(
                                  child: Text(
                                    Globalization.login.tr,
                                    style: const TextStyle(
                                      color: ColorHelper.myWhite,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      appId,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorHelper.myDominantColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget landscapeLayout() {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        color: ColorHelper.myDefaultBackColor,
                        child: Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Image.asset("assets/images/sales.png")),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        color: ColorHelper.myWhite,
                        child: Text(
                          appId,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorHelper.myDominantColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        color: ColorHelper.myWhite,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(
                                minWidth: 300, maxWidth: 400),
                            width: MediaQuery.of(context).size.width / 2 * 0.7,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onLongPress: () {
                                    // verifyDealerForAccess();
                                  },
                                  child: Image.asset(
                                    "assets/images/ezypos_logo.png",
                                  ),
                                ),
                                const Gap(30),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorHelper.myWhite,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
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
                                  child: TextField(
                                    enabled: true,
                                    obscureText: isPINLogin ? true : false,
                                    obscuringCharacter: '*',
                                    controller: nameController,
                                    cursorColor: ColorHelper.myDominantColor,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: ColorHelper.myWhite,
                                      prefixIcon: isPINLogin
                                          ? const Icon(
                                        Icons.password,
                                        color:
                                        ColorHelper.myDominantColor,
                                      )
                                          : const Icon(
                                        Icons.person,
                                        color:
                                        ColorHelper.myDominantColor,
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          top: 2, bottom: 2, left: 5, right: 5),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        borderSide: BorderSide.none,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Image.asset(
                                            isPINLogin
                                                ? "assets/icons/password.png"
                                                : "assets/icons/pin.png",
                                            height: 25),
                                        onPressed: () async {
                                          final prefs = await SharedPreferences
                                              .getInstance();
                                          await prefs.setBool(
                                              "usePinLogin", !isPINLogin);

                                          nameController.clear();
                                          passwordController.clear();

                                          setState(() {
                                            isPINLogin = !isPINLogin;
                                          });
                                        },
                                      ),
                                      hintText: isPINLogin
                                          ? Globalization.fastLoginPIN.tr
                                          : Globalization.userID.tr,
                                      hintStyle: const TextStyle(
                                        color: ColorHelper.myDisable1,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(10),
                                if (isPINLogin)
                                  SizedBox(height: 100, child: numberPad()),
                                Visibility(
                                  visible: !isPINLogin,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorHelper.myWhite,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
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
                                    child: TextField(
                                      enabled: true,
                                      obscureText: sec,
                                      controller: passwordController,
                                      cursorColor: ColorHelper.myDominantColor,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: ColorHelper.myWhite,
                                        prefixIcon: const Icon(
                                          Icons.vpn_key,
                                          color: ColorHelper.myDominantColor,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              sec = !sec;
                                            });
                                          },
                                          icon: sec
                                              ? Image.asset(
                                            "assets/icons/no_eyes.png",
                                            height: 25,
                                          )
                                              : Image.asset(
                                            "assets/icons/eyes.png",
                                            height: 25,
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 2,
                                            bottom: 2,
                                            left: 5,
                                            right: 5),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintText: Globalization.password.tr,
                                        hintStyle: const TextStyle(
                                          color: ColorHelper.myDisable1,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(30),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextButtonWidget(
                                        text: Globalization.login.tr,
                                        baseColor: ColorHelper.myDominantColor,
                                        onTap: () {
                                          // loginProcess();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PopupMenuButton<String>(
                            icon: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Image.asset(
                                "assets/icons/gear.png",
                                height: 25,
                              ),
                            ),
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<String>>[
                              if (licenceMode == 3)
                                PopupMenuItem<String>(
                                  value: "cloudServer",
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/icons/link_server.png",
                                        height: 30),
                                    title: Text(
                                      Globalization.cloudServer.tr,
                                      style: const TextStyle(
                                        color: ColorHelper.myBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              if (licenceMode == 1)
                                PopupMenuItem<String>(
                                  value: "serverSettings",
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/icons/edit_server.png",
                                        height: 30),
                                    title: Text(
                                      Globalization.serverSettings.tr,
                                      style: const TextStyle(
                                        color: ColorHelper.myBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              if (licenceMode == 1)
                                PopupMenuItem<String>(
                                  value: "pairServer",
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/icons/link_server.png",
                                        height: 30),
                                    title: Text(
                                      Globalization.pairServer.tr,
                                      style: const TextStyle(
                                        color: ColorHelper.myBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              if (licenceMode == 0)
                                PopupMenuItem<String>(
                                  value: "resetPassword",
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/icons/reset_password.png",
                                        height: 30),
                                    title: Text(
                                      Globalization.resetAdminPassword.tr,
                                      style: const TextStyle(
                                        color: ColorHelper.myBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              if (!activateStatus) const PopupMenuDivider(),
                              if (!activateStatus)
                                PopupMenuItem<String>(
                                  value: "Register",
                                  child: ListTile(
                                    leading: Image.asset(
                                        "assets/icons/register.png",
                                        height: 30),
                                    title: Text(
                                      "Activate License",
                                      style: const TextStyle(
                                        color: ColorHelper.myBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                            onSelected: (value) {
                              // switch (value) {
                              //   case "serverSettings":
                              //     changeServerSettings();
                              //     break;
                              //   case "pairServer":
                              //     pairServer();
                              //     break;
                              //   case "resetPassword":
                              //     resetAdminPassword();
                              //     break;
                              //   case "cloudServer":
                              //     connectCloudServer();
                              //     break;
                              //   case "Register":
                              //     activateDevice();
                              // }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget numberPad() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Level 1
        Expanded(
          flex: 1,
          child: Row(
            children: [
              //Level 1
              Expanded(
                flex: 1,
                child: numberPadItemWidget(
                    title: "1",
                    onTap: () {
                      updatePin("1");
                    }),
              ),
              Expanded(
                flex: 1,
                child: numberPadItemWidget(
                    title: "2",
                    onTap: () {
                      updatePin("2");
                    }),
              ),
              Expanded(
                flex: 1,
                child: numberPadItemWidget(
                    title: "3",
                    onTap: () {
                      updatePin("3");
                    }),
              ),
              Expanded(
                child: numberPadItemWidget(
                    title: "4",
                    onTap: () {
                      updatePin("4");
                    }),
              ),
              Expanded(
                child: numberPadItemWidget(
                    title: "5",
                    onTap: () {
                      updatePin("5");
                    }),
              ),
              Expanded(
                flex: 1,
                child: numberPadItemWidget(
                    isDelete: true,
                    onTap: () {
                      backFunction();
                    }),
              ),
            ],
          ),
        ),
        //Level 2
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Expanded(
                child: numberPadItemWidget(
                    title: "6",
                    onTap: () {
                      updatePin("6");
                    }),
              ),
              Expanded(
                child: numberPadItemWidget(
                    title: "7",
                    onTap: () {
                      updatePin("7");
                    }),
              ),
              Expanded(
                child: numberPadItemWidget(
                    title: "8",
                    onTap: () {
                      updatePin("8");
                    }),
              ),
              Expanded(
                child: numberPadItemWidget(
                    title: "9",
                    onTap: () {
                      updatePin("9");
                    }),
              ),
              Expanded(
                flex: 1,
                child: numberPadItemWidget(
                    title: "0",
                    onTap: () {
                      updatePin("0");
                    }),
              ),
              Expanded(child: closeButtonWidget()),
            ],
          ),
        ),
      ],
    );
  }

  Widget numberPadItemWidget(
      {required VoidCallback onTap,
        String title = "",
        bool isDelete = false,
        bool isActive = true,
        bool isClear = false}) {
    return Container(
        color: ColorHelper.myDefaultBackColor,
        padding: const EdgeInsets.all(3),
        child: isActive
            ? ZoomTapAnimation(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: ColorHelper.myWhite,
              borderRadius: BorderRadius.circular(5),
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
            child: Center(
              child: isDelete
                  ? const Icon(
                Icons.backspace_outlined,
                size: 25,
                // color: ColorHelper.myDarkBlueColor,
                color: ColorHelper.myRed,
              )
                  : Text(
                title,
                style: TextStyle(
                  fontSize: 25,
                  color: isClear ? Colors.red : Colors.black,
                ),
              ),
            ),
          ),
        )
            : Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: ColorHelper.myDisable2,
            borderRadius: BorderRadius.circular(5),
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
          child: Center(
            child: isDelete
                ? const Icon(Icons.backspace_outlined,
                size: 25, color: ColorHelper.myDisable1)
                : Text(
              title,
              style: const TextStyle(
                  fontSize: 25, color: ColorHelper.myDisable1),
            ),
          ),
        ));
  }

  Widget closeButtonWidget() {
    return Container(
        padding: const EdgeInsets.all(3),
        color: ColorHelper.myDefaultBackColor,
        child: ZoomTapAnimation(
          onTap: () {
            nameController.clear();
          },
          child: Container(
            decoration: BoxDecoration(
              color: ColorHelper.myWhite,
              borderRadius: BorderRadius.circular(5),
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
            child: const Center(
              child: Icon(Icons.cancel_outlined,
                  size: 30, color: ColorHelper.myRed),
            ),
          ),
        ));
  }

  void updatePin(String key) {
    String? amtString = nameController.text;
    if (amtString.isNotEmpty) {
      String tmpStr = "$amtString$key";

      amtString = tmpStr;
    } else {
      amtString = key;
    }

    setState(() {
      nameController.text = amtString!;
    });
  }

  void backFunction() {
    String? amtString = nameController.text;
    if (amtString.isNotEmpty) {
      amtString = amtString.substring(0, amtString.length - 1);
    }

    setState(() {
      nameController.text = amtString!;
    });
  }
}
