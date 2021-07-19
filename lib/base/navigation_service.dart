import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void onTokenExpire() {}

  void navigateRoute(CupertinoPageRoute route) {}

  void navigateNamed(String routeNamed,
      {Map<String, dynamic>? argument = const <String, dynamic>{}}) {}

  void removeFocus() {
    FocusScopeNode currentFocus = FocusScope.of(navigatorKey.currentContext!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.focusedChild?.unfocus();
    }
  }
}
