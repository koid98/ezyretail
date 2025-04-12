import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../language/globalization.dart';
import '../../themes/color_helper.dart';
import '../tools/custom_text_button.dart';

class CheckPermissionDialog extends StatefulWidget {
  const CheckPermissionDialog({super.key});

  @override
  State<CheckPermissionDialog> createState() => _CheckPermissionDialogState();
}

class _CheckPermissionDialogState extends State<CheckPermissionDialog> {
  Map<Permission, PermissionStatus>? _permissionsStatus;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await checkAllPermissions();
    setState(() {
      _permissionsStatus = statuses;
    });
  }

  Future<Map<Permission, PermissionStatus>> checkAllPermissions() async {
    final List<Permission> permissions = [
      Permission.camera,
      Permission.location,
      Permission.locationWhenInUse,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.nearbyWifiDevices,
      // Add other permissions as needed
    ];

    Map<Permission, PermissionStatus> statuses = {};

    for (Permission permission in permissions) {
      PermissionStatus status = await permission.status;
      statuses[permission] = status;
    }

    return statuses;
  }

  String _getPermissionName(Permission permission) {
    switch (permission) {
      case Permission.camera:
        return 'Camera';
      case Permission.location:
        return 'Location';
      case Permission.locationWhenInUse:
        return 'Location When In Use';
      case Permission.bluetoothScan:
        return 'Bluetooth Scan';
      case Permission.bluetoothConnect:
        return 'Bluetooth Connect';
      case Permission.bluetoothAdvertise:
        return 'Bluetooth Advertise';
      case Permission.nearbyWifiDevices:
        return 'Nearby Device';
    // Add other cases as needed
      default:
        return permission.toString();
    }
  }

  Icon _getPermissionIcon(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return const Icon(Icons.check_circle, color: Colors.green);
      case PermissionStatus.denied:
        return const Icon(Icons.cancel, color: Colors.red);
      case PermissionStatus.permanentlyDenied:
        return const Icon(Icons.block, color: Colors.red);
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      default:
        return const Icon(Icons.help, color: Colors.grey);
    }
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
          Image.asset("assets/icons/permission.png", height: 30),
          const Gap(10),
          Text(
            Globalization.checkPermission.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorHelper.myBlack,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      content: Container(
        constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
        width: 500,
        color: ColorHelper.myDefaultBackColor,
        child: _permissionsStatus == null
            ? const SizedBox()
            : ListView(
          shrinkWrap: true,
          children: _permissionsStatus!.entries.map((entry) {
            Permission permission = entry.key;
            PermissionStatus status = entry.value;

            return ListTile(
              leading: _getPermissionIcon(status),
              title: Text(_getPermissionName(permission)),
              subtitle: Text(status.toString().split('.').last),
              trailing: ElevatedButton(
                onPressed: () async {
                  if (status.isDenied || status.isRestricted) {
                    await permission.request();
                    _checkPermissions(); // Refresh statuses
                  } else if (status.isPermanentlyDenied) {
                    // Open app settings
                    openAppSettings();
                  }
                },
                child: const Text('Request'),
              ),
            );
          }).toList(),
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
