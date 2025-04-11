import "package:calendar_date_picker2/calendar_date_picker2.dart";
import "package:flutter/material.dart";
import "package:gap/gap.dart";
import "package:get/get.dart";

import "../../language/globalization.dart";
import "../../themes/color_helper.dart";
import "../tools/custom_text_button.dart";

class DateRangeDialog extends StatefulWidget {
  final String title;
  final DateTime startDate;
  final DateTime nextDate;
  const DateRangeDialog(
      {super.key,
        required this.title,
        required this.startDate,
        required this.nextDate});

  @override
  State<DateRangeDialog> createState() => _DateRangeDialogState();
}

class _DateRangeDialogState extends State<DateRangeDialog> {
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(2024, 8, 10),
    DateTime(2024, 8, 13),
  ];

  final config = CalendarDatePicker2WithActionButtonsConfig(
    calendarType: CalendarDatePicker2Type.range,
    disableModePicker: true,
  );

  @override
  void initState() {
    super.initState();
    _rangeDatePickerValueWithDefaultValue = [widget.startDate, widget.nextDate];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorHelper.myDefaultBackColor,
      surfaceTintColor: ColorHelper.myDefaultBackColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Center(
        child: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: "Tahoma",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          height: 300,
          width: 300,
          child: CalendarDatePicker2(
            config: config,
            value: _rangeDatePickerValueWithDefaultValue,
            onValueChanged: (dates) =>
                setState(() => _rangeDatePickerValueWithDefaultValue = dates),
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          children: [
            Expanded(
              child: CustomTextButtonWidget(
                text: Globalization.close.tr,
                baseColor: ColorHelper.myRed,
                textColor: ColorHelper.myWhite,
                onTap: () {
                  Get.back();
                },
              ),
            ),
            const Gap(10),
            Expanded(
              child: CustomTextButtonWidget(
                text: Globalization.confirm.tr,
                baseColor: ColorHelper.myMainBlue,
                onTap: () {
                  if (_rangeDatePickerValueWithDefaultValue[0] == null) {
                    return;
                  }

                  if (_rangeDatePickerValueWithDefaultValue[1] == null) {
                    return;
                  }

                  Get.back(result: _rangeDatePickerValueWithDefaultValue);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  bool checkValidDate(DateTime value) {
    DateTime? parsedDate = DateTime.tryParse(value.toString());
    if (parsedDate != null) {
      return true;
    } else {
      return false;
    }
  }
}
