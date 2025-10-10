import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:note_app/helpers/remote_config_keys.dart';
import 'package:package_info_plus/package_info_plus.dart';

class RemoteConfigService {
  RemoteConfigService._();

  static final RemoteConfigService instance = RemoteConfigService._();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize({Map<String, dynamic>? defaults}) async {
    try {
      if (defaults != null) {
        await _remoteConfig.setDefaults(defaults);
      }
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('RemoteConfig initialization failed: $e');
    }
  }

  String getString(String key) {
    return _remoteConfig.getString(key);
  }

  int getInt(String key) {
    return _remoteConfig.getInt(key);
  }

  bool getBool(String key) {
    return _remoteConfig.getBool(key);
  }

  double getDouble(String key) {
    return _remoteConfig.getDouble(key);
  }
  Future<bool> get isForceUpdateRequired async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final int deviceBuildNumber = int.tryParse(packageInfo.buildNumber) ?? 1;
    final int remoteBuildNumber = getInt(RemoteConfigKeys.buildNumber);
    final bool forceUpdate = getBool(RemoteConfigKeys.forceUpdate);

    return (deviceBuildNumber < remoteBuildNumber) && forceUpdate;
  }
}
