import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/api_service.dart';
import 'package:pingna/core/services/auth_service.dart';
import 'package:pingna/core/services/theme_service.dart';
import 'package:pingna/core/services/database_service.dart';
import 'package:pingna/core/services/keyboard_overlay_service.dart';
import 'package:pingna/core/viewmodels/home_view_model.dart';

List<SingleChildWidget> providers(Auth auth) {
  // "..." Flattens the array (called the spread function in dart)
  return [
    ...independentServices,
    ...dependentServices(auth),
    ...userDependentProviders,
  ];
}

List<SingleChildWidget> independentServices = [
  Provider(create: (_) => PingnaDB()),
  Provider(create: (_) => PingnaApi()),
  Provider(create: (_) => FlutterSecureStorage()),
  Provider(create: (_) => FlutterLocalNotificationsPlugin()),
  Provider(create: (_) => KeyboardOverlayService()),
];

List<SingleChildWidget> dependentServices(Auth auth) {
  return [
    /// The Theme service depends on:
    /// - Storage to collect the last set theme by the user
    ChangeNotifierProvider<PingnaTheme>(
      create: (context) => PingnaTheme(
        context.read<FlutterSecureStorage>(),
      )..init(),
    ),

    /// The Authentication service depends on:
    /// - DB to save the result of the authentication api into an SQLite DB
    /// - Storage to save the token into secure storage
    ProxyProvider3<PingnaDB, FlutterSecureStorage,
        FlutterLocalNotificationsPlugin, Auth>(
      create: (_) => auth,
      update: (_, db, storage, notifications, auth) {
        return auth
          ..db = db
          ..notifications = notifications;
      },
    ),
  ];
}

List<SingleChildWidget> userDependentProviders = [
  // Setup a value listenable provider for the user since information on the
  // current user will be required throughout the app and we don't want to carry
  // the auth provider through each time.
  ValueListenableProvider<User>(create: (context) => context.read<Auth>().user),

  ChangeNotifierProvider(
    create: (context) => HomeViewModel(
      context.read<User>(),
      context.read<PingnaApi>(),
    )..init(),
  ),
];
