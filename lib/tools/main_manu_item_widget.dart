import 'package:flutter/material.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../themes/color_helper.dart';

class MainMenuPageItemButtonWidget extends StatefulWidget {
  final String title;
  final String icon;
  final VoidCallback onTab;
  final bool enabled;
  final Color baseColor;
  final Color textColor;
  const MainMenuPageItemButtonWidget(
      {super.key,
        required this.title,
        required this.icon,
        required this.onTab,
        this.enabled = true,
        this.baseColor = ColorHelper.myWhite,
        this.textColor = ColorHelper.myBlack});

  @override
  State<MainMenuPageItemButtonWidget> createState() =>
      _MainMenuPageItemButtonWidgetState();
}

class _MainMenuPageItemButtonWidgetState
    extends State<MainMenuPageItemButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: !widget.enabled,
      child: ZoomTapAnimation(
        onTap: widget.onTab,
        child: Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: widget.baseColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          child: FittedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Visibility(
                  visible: widget.icon != "",
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Image.asset(
                      widget.icon,
                      width: 60,
                      height: 60,
                      color: widget.enabled ? null : ColorHelper.myDisable2,
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: SizedBox(
                    width: 90,
                    height: 40,
                    child: Text(
                      widget.title,
                      // minFontSize: 10,
                      // stepGranularity: 5,
                      maxLines: 2,
                      // group: menuBodyGroup,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: widget.enabled
                            ? widget.textColor
                            : ColorHelper.myDisable1,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
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
}
