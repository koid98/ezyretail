import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../themes/color_helper.dart';

class CustomTextButtonWidget extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color? baseColor;
  final Color? textColor;
  final Color? shadowColor;
  const CustomTextButtonWidget(
      {super.key,
        required this.text,
        required this.onTap,
        this.baseColor,
        this.textColor,
        this.shadowColor});

  @override
  State<CustomTextButtonWidget> createState() => _CustomTextButtonWidgetState();
}

class _CustomTextButtonWidgetState extends State<CustomTextButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: widget.baseColor ?? ColorHelper.myMainBlue,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                  color: widget.shadowColor ?? ColorHelper.myGrey,
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                  spreadRadius: -1,
                ),
              ]),
          child: Text(
            widget.text,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: widget.textColor ?? ColorHelper.myWhite,
              fontWeight: FontWeight.bold,
              fontFamily: "Tahoma",
              fontSize: 14,
            ),
          )),
    );
  }
}
