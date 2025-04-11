import "dart:io";

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../language/globalization.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';
import 'package:simple_animations/simple_animations.dart';

class BarcodeDialog extends StatefulWidget {
  const BarcodeDialog({super.key});

  @override
  State<BarcodeDialog> createState() => _BarcodeDialogState();
}

class _BarcodeDialogState extends State<BarcodeDialog> {
  Barcode? result;
  bool state = false;
  bool recording = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final tween = MovieTween()
    ..tween('x', Tween(begin: 0.0, end: 0.0),
        duration: const Duration(seconds: 0))
        .thenTween('y', Tween(begin: -100.0, end: 90.0),
        duration: const Duration(seconds: 1))
        .thenTween('x', Tween(begin: 0.0, end: 0.0),
        duration: const Duration(seconds: 0))
        .thenTween('y', Tween(begin: 90.0, end: -100.0),
        duration: const Duration(seconds: 1));

  @override
  Future<void> didChangeDependencies() async {
    await checkPermission();

    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    super.reassemble();
    controller!.pauseCamera();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> checkPermission() async {
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
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
          Image.asset("assets/icons/camera.png", height: 30),
          const Text(
            "Barcode Scanner",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorHelper.myBlack,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Stack(
        children: [
          SizedBox(
            width: 300,
            height: 300,
            child: Center(
              child: _buildQrView(context),
            ),
          ),
          SizedBox(
            width: 300,
            height: 300,
            child: Center(
              child: LoopAnimationBuilder<Movie>(
                tween: tween, // Pass in tween
                duration: tween.duration, // Obtain duration
                builder: (context, value, child) {
                  return Transform.translate(
                    // Get animated offset
                    offset: Offset(value.get('x'), value.get('y')),
                    child: Container(
                      width: 200,
                      height: 5,
                      color: recording
                          ? Colors.red.withOpacity(0.8)
                          : Colors.transparent,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        Column(
          children: [
            ZoomTapAnimation(
              onTap: () {
                if (recording) {
                  setState(() {
                    recording = false;
                  });
                } else {
                  setState(() {
                    recording = true;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        recording
                            ? Image.asset("assets/icons/camera_scan_off.png",
                            height: 30, width: 30)
                            : Image.asset("assets/icons/camera_scan.png",
                            height: 30, width: 30),
                        const Gap(10),
                        Text(
                          recording ? 'Pause' : 'Scan',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ColorHelper.myBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextButtonWidget(
                  text: Globalization.close.tr,
                  baseColor: ColorHelper.myRed,
                  onTap: () {
                    Get.back();
                  },
                ),
                Row(
                  children: [
                    ZoomTapAnimation(
                      onTap: () async {
                        await controller?.toggleFlash();
                        setState(() {});
                        state ? state = false : state = true;
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
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
                        child: state
                            ? Image.asset("assets/icons/flash_off.png",
                            height: 30)
                            : Image.asset("assets/icons/flash_on.png",
                            height: 30),
                      ),
                    ),
                    const Gap(10),
                    ZoomTapAnimation(
                      onTap: () async {
                        await controller?.flipCamera();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
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
                        child: Image.asset("assets/icons/camera_switch.png",
                            height: 30),
                      ),
                    ),
                  ],
                ),

                /* ZoomTapAnimation(
                  onTap: () {
                    if (recording) {
                      setState(() {
                        recording = false;
                      });
                    } else {
                      setState(() {
                        recording = true;
                      });
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 80,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorHelper.myComplementaryColor,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          recording
                              ? Image.asset("assets/icons/camera_scan.png",
                                  height: 30, width: 30)
                              : Image.asset("assets/icons/camera_scan_off.png",
                                  height: 30, width: 30),
                          const Gap(10),
                          Text(
                            recording ? 'Scan' : 'Scan Pause',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ColorHelper.myBlack,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )*/
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 900 ||
        MediaQuery.of(context).size.height < 900)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: ColorHelper.myDominantColor,
        borderRadius: 15,
        borderLength: 35,
        borderWidth: 10,
        cutOutSize: scanArea,
        cutOutBottomOffset: 10,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (recording) {
        setState(() {
          recording = false;
          result = scanData;
        });
        // print(result?.code);
        Get.back(result: result?.code);
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
