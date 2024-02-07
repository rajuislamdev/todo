import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class GlobalFunction {
  static Future<bool> isOnline() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
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
