import 'package:firebase/firebase.dart' as fb;

class PRemoteConfigValueService {
  static bool asBool(fb.RemoteConfigValue value) => value.asBoolean();

  static double asDouble(fb.RemoteConfigValue value) =>
      value.asNumber().toDouble();

  static int asInt(fb.RemoteConfigValue value) => value.asNumber().toInt();

  static String asString(fb.RemoteConfigValue value) => value.asString();
}
