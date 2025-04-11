import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../language/globalization.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';

class YesNoDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const YesNoDialog(
      {super.key,
        this.title = "Are You Sure?",
        required this.content,
        required this.onConfirm,
        required this.onCancel});

  @override
  State<YesNoDialog> createState() => _YesNoDialogState();
}

class _YesNoDialogState extends State<YesNoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Column(
        children: [
          Image.asset("assets/icons/question_icon.png", height: 30),
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
              text: Globalization.no.tr,
              baseColor: ColorHelper.myRed,
              onTap: widget.onCancel,
            ),
            const Gap(10),
            CustomTextButtonWidget(
              text: Globalization.yes.tr,
              baseColor: ColorHelper.myDominantColor,
              onTap: widget.onConfirm,
            ),
          ],
        ),
      ],
    );
  }
}
