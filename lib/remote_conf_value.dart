import 'package:firebase_remote_config/firebase_remote_config.dart';

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

class PRemoteConfigValueService {
  static bool asBool(RemoteConfigValue value) => value.asBool();

  static double asDouble(RemoteConfigValue value) => value.asDouble();

  static int asInt(RemoteConfigValue value) => value.asInt();

  static String asString(RemoteConfigValue value) => value.asString();
}
