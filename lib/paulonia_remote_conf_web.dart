import 'package:firebase/firebase.dart' as fb;
import 'package:paulonia_remote_conf/constants.dart';
import 'package:paulonia_remote_conf/remote_conf_value.dart';
import 'package:paulonia_utils/paulonia_utils.dart';

class PauloniaRemoteConfService {
  /// Remote configuration instance
  static final _remoteConfig = fb.remoteConfig();

  /// Map of default values
  static Map<String, dynamic> _defaultValues;

  /// Get the map of default values
  static Map<String, dynamic> get defaultValues => _defaultValues;

  /// Initialize the service
  ///
  /// This functions initialize the remote configuration service and set the
  /// [defaultValues]. The function fetch the values from the server if the
  /// app is running on release.
  /// In web, [expirationTimeInHours] is useless.
  static Future<void> initRemoteConf(
    Map<String, dynamic> defaultValues, {
    int expirationTimeInHours = PauloniaRemoteConfConstants.REMOTE_CONF_DEFAULT_EXPIRATION_TIME_IN_HOURS,
    int fetchTimeout = PauloniaRemoteConfConstants.REMOTE_CONF_DEFAULT_FETCH_TIMEOUT_IN_SECONDS,
  }) async {
    _defaultValues = defaultValues;
    await _remoteConfig.ensureInitialized();
    _remoteConfig.defaultConfig = _defaultValues;
    if (PUtils.isOnRelease() && (await PUtils.checkNetwork())) {
      await _remoteConfig.fetch();
    }
    await _remoteConfig.activate();
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
        return _remoteConfig.getNumber(keyName)?.toInt();
      case PRCType.DOUBLE:
        return _remoteConfig.getNumber(keyName)?.toDouble();
      case PRCType.BOOL:
        return _remoteConfig.getBoolean(keyName);
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
}
