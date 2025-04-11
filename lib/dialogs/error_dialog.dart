import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/globalization.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';

class ErrorDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback? onConfirm;
  const ErrorDialog(
      {super.key, this.title = "Error", required this.content, this.onConfirm});

  @override
  State<ErrorDialog> createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Image.asset("assets/icons/error_icon.png", height: 30),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorHelper.myBlack,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Text(
        widget.content,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
}
