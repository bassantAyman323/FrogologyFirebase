import 'package:flutter/material.dart';
import 'package:graduationproj1/modules/fingerprint_page.dart';
import 'package:graduationproj1/modules/home_page.dart';

import 'package:graduationproj1/modules/settings.dart';
import 'package:graduationproj1/routes/route_names.dart';

class CustomRoute {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => FingerprintPage());
      case settingRoute:
        return MaterialPageRoute(builder: (_) => SettingsPage());
    }
    return MaterialPageRoute(builder: (_) => HomePage());
  }
}
