import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class GlobalFunction {
  static Future<String?> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return iosInfo.identifierForVendor; // iOS device ID
      } else if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        return androidInfo.id; // Android device ID
      }
    } catch (e) {
      debugPrint('Error getting device ID: $e');
      return null;
    }
    return null;
  }

  static String errorText(
      {required String fieldName, required BuildContext context}) {
    return '$fieldName is required!';
  }

  static String? commonValidator({
    required String value,
    required String name,
    required BuildContext context,
  }) {
    if (value.isEmpty) {
      return errorText(fieldName: name, context: context);
    }
    return null;
  }
}
