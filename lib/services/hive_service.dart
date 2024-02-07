import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todos/config/app_constants.dart';

class HiveService {
  final Ref ref;
  HiveService(this.ref);

  // save the first open status
  Future setFirstOpenValue({required bool value}) async {
    final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    appSettingsBox.put(AppConstants.firstOpen, value);
  }

  // Get user first open status
  Future<bool?> getUserFirstOpenStatus() async {
    final appSettingsBox = await Hive.openBox(AppConstants.appSettingsBox);
    final status = appSettingsBox.get(AppConstants.firstOpen);
    if (status != null) {
      return status;
    }
    return false;
  }
}

final hiveServiceProvider = Provider((ref) => HiveService(ref));
