import 'package:firebase_remote_config/firebase_remote_config.dart';

class PRemoteConfigValueService {
  static bool asBool(RemoteConfigValue value) => value.asBool();

  static double asDouble(RemoteConfigValue value) => value.asDouble();

  static int asInt(RemoteConfigValue value) => value.asInt();

  static String asString(RemoteConfigValue value) => value.asString();
}
