import 'package:paulonia_remote_conf/remote_conf_value_mobile.dart'
    if (dart.library.html) 'package:paulonia_remote_conf/remote_conf_value_web.dart';

class PRemoteConfigValue {
  final _value;

  PRemoteConfigValue(
    this._value,
  );

  bool asBool() => PRemoteConfigValueService.asBool(_value);

  double asDouble() => PRemoteConfigValueService.asDouble(_value);

  int asInt() => PRemoteConfigValueService.asInt(_value);

  String asString() => PRemoteConfigValueService.asString(_value);
}
