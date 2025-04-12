import 'package:email_validator/email_validator.dart';
import 'package:ezyretail/dialogs/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../language/globalization.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';

class EmailInputDialog extends StatefulWidget {
  final String title;
  final String initMailAddress;
  final int maxLength;
  final bool canEmpty;

  const EmailInputDialog(
      {super.key,
        this.title = "Email",
        this.initMailAddress = "",
        this.maxLength = 200,
        this.canEmpty = false});

  @override
  State<EmailInputDialog> createState() => _EmailInputDialogState();
}

class _EmailInputDialogState extends State<EmailInputDialog> {
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();

    emailController.text = widget.initMailAddress;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Row(
        children: [
          Image.asset("assets/icons/edit_note.png", height: 25),
          const Gap(10),
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorHelper.myBlack,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
      content: TextField(
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 2, color: ColorHelper.myDominantColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(width: 3, color: ColorHelper.myDominantColor),
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
            const Gap(10),
            CustomTextButtonWidget(
              text: Globalization.confirm.tr,
              baseColor: ColorHelper.myDominantColor,
              onTap: () async {
                if (widget.canEmpty) {
                  Get.back(result: emailController.text.trim());
                } else {
                  if (emailController.text.trim().isEmpty) {
                    await Get.dialog(
                        WarningDialog(
                            content: Globalization.fieldCannotBeEmpty.tr),
                        barrierDismissible: false);
                  } else {
                    bool isValid =
                    EmailValidator.validate(emailController.text.trim());
                    if (isValid) {
                      Get.back(result: emailController.text.trim());
                    } else {
                      await Get.dialog(
                          WarningDialog(content: Globalization.invalidEmail.tr),
                          barrierDismissible: false);
                    }
                  }
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
