import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pingna/core/constants.dart';
import 'package:pingna/resources/assets.dart';

class PingnaTheme extends ChangeNotifier {
  ThemeMode mode;
  FlutterSecureStorage storage;

  PingnaTheme(this.storage);

  void init() async {
    final lastMode = await storage.read(key: appearanceSetting);
    switch (lastMode) {
      case 'ThemeMode.dark':
        this.mode = ThemeMode.dark;
        break;
      case 'ThemeMode.system':
        this.mode = ThemeMode.system;
        break;
      case 'ThemeMode.light':
      default:
        this.mode = ThemeMode.light;
    }

    notifyListeners();
  }

  void setLight() {
    this.mode = ThemeMode.light;
    notifyListeners();
  }

  void setDark() {
    this.mode = ThemeMode.dark;
    notifyListeners();
  }

  void setSystem() {
    this.mode = ThemeMode.system;
    notifyListeners();
  }

  void toggle() {
    this.mode = this.mode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  @override
  notifyListeners() {
    storage.write(key: appearanceSetting, value: this.mode.toString());
    super.notifyListeners();
  }

  bool get isLight => (this.mode ?? ThemeMode.light) == ThemeMode.light;
  bool get isSystemDefault => this.mode == ThemeMode.system;
  bool get isDark => isUserDark || isSystemDark;
  bool get isUserDark => mode == ThemeMode.dark;
  bool get isSystemDark =>
      mode == ThemeMode.system &&
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark;

  Color get progressColor => isDark ? Colors.white : primaryColor;

  ThemeData get active => mode == ThemeMode.dark ? dark : light;

  ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: backgroundColor,
      primarySwatch: buildMaterialColor(primaryColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(primaryColor: primaryColor),
      canvasColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      buttonColor: primaryColor,
      accentColor: backgroundColor,
      textTheme: TextTheme(
        headline4: GoogleFonts.sourceSerifPro(
          color: charcoalColor,
          fontWeight: FontWeight.bold,
          fontSize: 34,
        ),
        headline5: GoogleFonts.sourceSerifPro(
          color: charcoalColor,
          fontWeight: FontWeight.bold,
        ),
        headline6: GoogleFonts.sourceSerifPro(
          color: charcoalColor,
          fontWeight: FontWeight.bold,
        ),
        button: TextStyle(
          color: backgroundColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.accent,
        buttonColor: primaryColor,
      ),
      iconTheme: IconThemeData(color: primaryColor),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: primaryColor.withOpacity(0.75),
            width: 0.5,
          ),
        ),
        labelStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  ThemeData get dark {
    return ThemeData.dark();
  }
}
