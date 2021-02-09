import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:connectivity/connectivity.dart';

class RCUtils{

  static bool isOnRelease() {
    return kReleaseMode;
  }

  /// Verifies if there is network connectivity
  static Future<bool> checkNetwork() async {
    return (await Connectivity().checkConnectivity()) !=
        ConnectivityResult.none;
  }

  /// Verifies if the app is running in a test environment
  static bool isOnTest() {
    if(kIsWeb) return false;
    return Platform.environment.containsKey('FLUTTER_TEST');
  }

}