import 'package:flutter/material.dart';
import 'package:pingna/resources/widgets/preloader.dart';
import 'package:provider/provider.dart';
import 'package:pingna/core/services/theme_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:pingna/routes.dart';
import 'package:pingna/providers.dart';
import 'package:pingna/core/constants.dart';
import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final auth = Auth(storage: FlutterSecureStorage());
  await auth.init();
  final user = await auth.fromStorage;
  var initialRoute = welcomeRoute;

  // Check if a user exists on this device
  if (user != User.none) initialRoute = homeRoute;

  runApp(MultiProvider(providers: providers(auth), child: MyApp(initialRoute)));
}

class MyApp extends StatelessWidget {
  const MyApp(this.initialRoute);

  final String initialRoute;

  static const locales = [Locale('en', 'GB'), Locale('en', 'US')];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'lang',
      preloaderWidget: PreloaderWidget(),
      supportedLocales: locales,
      child: Consumer<PingnaTheme>(
        builder: (_, theme, __) => MaterialApp(
          title: 'Flutter Demo',
          theme: theme.light,
          darkTheme: theme.dark,
          themeMode: theme.mode ?? ThemeMode.light,
          initialRoute: initialRoute,
          onGenerateRoute: PingnaRouter.generateRoute,
          locale: Locale('en', 'GB'),
          supportedLocales: locales,
          localizationsDelegates: [
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate
          ],
        ),
      ),
    );
  }
}