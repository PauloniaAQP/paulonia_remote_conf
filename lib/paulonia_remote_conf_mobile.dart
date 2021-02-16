import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:paulonia_remote_conf/constants.dart';
import 'package:paulonia_remote_conf/remote_conf_value.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

class PauloniaRemoteConfService {
  /// Remote configuration instance
  static RemoteConfig _remoteConfig;

  /// Map of default values
  static Map<String, dynamic> _defaultValues;

  /// Get the map of default values
  static Map<String, dynamic> get defaultValues => _defaultValues;

  /// Initialize the service
  ///
  /// This functions initialize the remote configuration service and set the
  /// [defaultValues]. The function fetch the values from the server if the
  /// app is running on release.
  /// Set [expirationTimeInHours] with the time that the functions stores the values
  /// in cache.
  static Future<void> initRemoteConf(Map<String, dynamic> defaultValues,
      {int expirationTimeInHours = PauloniaRemoteConfConstants
          .REMOTE_CONF_DEFAULT_EXPIRATION_TIME_IN_HOURS}) async {
    _remoteConfig = await RemoteConfig.instance;
    _defaultValues = defaultValues;
    await _remoteConfig.setDefaults(_defaultValues);
    if (PUtils.isOnRelease() && (await PUtils.checkNetwork())) {
      await _remoteConfig.fetch(
          expiration: Duration(hours: expirationTimeInHours));
    }
    await _remoteConfig.activateFetched();
  }

  /// Get the value of [keyName] with [rcType]
  ///
  /// This function converts the value in the desire type.
  static dynamic get(String keyName, PRCType rcType) {
    if (PUtils.isOnTest()) return _defaultValues[keyName];
    switch (rcType) {
      case PRCType.STRING:
        return _remoteConfig.getString(keyName);
      case PRCType.INT:
        return _remoteConfig.getInt(keyName);
      case PRCType.DOUBLE:
        return _remoteConfig.getDouble(keyName);
      case PRCType.BOOL:
        return _remoteConfig.getBool(keyName);
      default:
        return PRemoteConfigValue(_remoteConfig.getValue(keyName));
    }
  }

  /// Get the value in [keyName]
  ///
  /// This function returns the value without any conversion.
  static PRemoteConfigValue getValue(String keyName) {
    return PRemoteConfigValue(_remoteConfig.getValue(keyName));
  }

  @visibleForTesting
  static void initRemoteConfForTest(Map<String, dynamic> defaultValues){
    _defaultValues = defaultValues;
  }
}
