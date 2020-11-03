import 'package:flutter/material.dart';
import 'package:pingna/core/constants.dart';
import 'package:pingna/resources/views/auth/onboarding/sign_up_bonus_view.dart';
import 'package:pingna/resources/views/auth/onboarding/post_code_view.dart';
import 'package:pingna/resources/views/auth/onboarding/welcome_view.dart';
import 'package:pingna/resources/views/home_view.dart';
import 'package:pingna/resources/views/shop_view.dart';

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
        return HomeView();
      case shopRoute:
        return ShopView(shop: data["shop"], labels: data["labels"]);
      case welcomeRoute:
        return WelcomeView();
      case postcodeRoute:
        return PostCodeView(signUpBonus: data.containsKey("from_home"));
      case signUpBonusRoute:
        return SignUpBonusView();
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
