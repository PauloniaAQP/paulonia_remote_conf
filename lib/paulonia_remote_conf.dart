library paulonia_remote_conf;

import 'package:paulonia_remote_conf/constants.dart';
import 'package:paulonia_remote_conf/remote_conf_value.dart';
import 'package:paulonia_remote_conf/paulonia_remote_conf_mobile.dart'
    if (dart.library.html) 'package:paulonia_remote_conf/paulonia_remote_conf_web.dart';

class PauloniaRemoteConf {
  /// Get the map of default values
  static Map<String, dynamic> get defaultValues =>
      PauloniaRemoteConfService.defaultValues;

  /// Initialize the service
  ///
  /// This functions initialize the remote configuration service and set the
  /// [defaultValues]. The function fetch the values from the server if the
  /// app is running on release.
  /// Set [expirationTimeInHours] with the time that the functions stores the values
  /// in cache (only for mobile).
  /// Set [fetchTimeoutInSeconds] with the time that the functions will wait if
  /// there is a network problem during fetch.
  static Future<void> init(
    Map<String, dynamic> defaultValues, {
    int expirationTimeInHours = PauloniaRemoteConfConstants
        .REMOTE_CONF_DEFAULT_EXPIRATION_TIME_IN_HOURS,
    int fetchTimeoutInSeconds = PauloniaRemoteConfConstants
        .REMOTE_CONF_DEFAULT_FETCH_TIMEOUT_IN_SECONDS,
  }) {
    return PauloniaRemoteConfService.initRemoteConf(
      defaultValues,
      expirationTimeInHours: expirationTimeInHours,
      fetchTimeout: fetchTimeoutInSeconds,
    );
  }

  /// Get the value of [keyName] with [rcType]
  ///
  /// This function converts the value in the desire type.
  static dynamic get(String keyName, PRCType rcType) {
    return PauloniaRemoteConfService.get(keyName, rcType);
  }

  /// Get the value in [keyName]
  ///
  /// This function returns the value without any conversion.
  static PRemoteConfigValue getValue(String keyName) {
    return PauloniaRemoteConfService.getValue(keyName);
  }
}
