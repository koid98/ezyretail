import 'package:ezyretail/tools/custom_small_text_button.dart';
import 'package:flutter/material.dart';

import '../../themes/color_helper.dart';

class CustomCheckBoxListTile extends StatefulWidget {
  final String title;
  final String? subTitle;
  final bool value;
  final bool enabled;
  final ValueChanged<bool?> onChanged;
  final bool showTrailButton;
  final String trailButtonText;
  final VoidCallback? onTap;
  const CustomCheckBoxListTile(
      {super.key,
        required this.title,
        this.subTitle,
        required this.value,
        required this.onChanged,
        this.enabled = true,
        this.showTrailButton = false,
        this.onTap,
        this.trailButtonText = ""});

  @override
  State<CustomCheckBoxListTile> createState() => _CustomCheckBoxListTileState();
}

class _CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  bool? _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        checkColor: ColorHelper.myWhite,
        value: widget.value,
        onChanged: widget.enabled ? widget.onChanged : null,
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: widget.enabled
                    ? ColorHelper.myBlack
                    : ColorHelper.myDisable1,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      subtitle: widget.subTitle != null
          ? Text(
        widget.subTitle ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: widget.enabled
              ? ColorHelper.myDisable1
              : ColorHelper.myDisable2,
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
      )
          : null,
      trailing: widget.showTrailButton
          ? widget.enabled
          ? CustomSmallTextButtonWidget(
        text: widget.trailButtonText,
        onTap: widget.onTap == null ? () {} : widget.onTap!,
      )
          : AbsorbPointer(
        child: CustomSmallTextButtonWidget(
          text: widget.trailButtonText,
          baseColor: ColorHelper.myDisable2,
          onTap: () {},
        ),
      )
          : null,
    );
  }
}
