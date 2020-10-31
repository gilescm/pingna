import 'package:flutter/material.dart';
import 'package:pingna/core/constants.dart';
import 'package:pingna/resources/views/auth/login_view.dart';
import 'package:pingna/resources/views/auth/onboarding/post_code_view.dart';
import 'package:pingna/resources/views/auth/onboarding/welcome_view.dart';
import 'package:pingna/resources/views/auth/reg_view.dart';
import 'package:pingna/resources/views/dash_view.dart';

class PingnaRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map data = settings.arguments ?? {};

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => findRouteByName(context, settings.name, data),
      fullscreenDialog: data['fullscreenDialog'] ?? false,
    );
  }

  static Widget findRouteByName(BuildContext context, String name, Map data) {
    switch (name) {
      case homeRoute:
        return DashboardView();
      case welcomeRoute:
        return WelcomeView();
      case postcodeRoute:
        return PostCodeView();
    }

    return Scaffold(
      body: Center(
        child: Text(
          'Oops something went wrong! Please restart this app.',
        ),
      ),
    );
  }
}