import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pingna/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/api_service.dart';
import 'package:pingna/core/services/database_service.dart';

class Auth {
  PingnaApi api;
  PingnaDB db;
  final user = ValueNotifier<User>(User.none);
  FlutterLocalNotificationsPlugin notifications;
  FlutterSecureStorage storage;

  final iv = encrypt.IV.fromLength(16);
  encrypt.Encrypter encrypter;

  Auth({
    this.api,
    this.db,
    @required this.storage,
    this.notifications,
  });

  Future init() async {
    final key = encrypt.Key.fromUtf8(await generatePassword());
    encrypter = encrypt.Encrypter(encrypt.AES(key));

    // Remove any data stored in secure storage from previous installs
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      storage.deleteAll();
      prefs.setBool('first_run', false);
    }

    final User newUser = await fromStorage;
    user.value = newUser;
    sendDeviceInfo(newUser);
  }

  Future<User> get fromStorage async {
    final userData = await storage.read(key: "user") ?? '';
    if (userData.isEmpty) return User.none;

    try {
      final encryptedUser = encrypt.Encrypted.fromBase64(userData);
      final decryptedUseer = encrypter.decrypt(encryptedUser, iv: iv);
      return User.fromMap(jsonDecode(decryptedUseer));
    } catch (e) {
      return User.none;
    }
  }

  Future<String> generatePassword() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    String _deviceUuid;
    if (Platform.isAndroid) {
      final AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
      _deviceUuid = build.androidId; // UUID for Android
    } else if (Platform.isIOS) {
      final IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
      _deviceUuid = data.identifierForVendor; // UUID for iOS
    }

    // Check length of uuid
    final length = _deviceUuid.length;
    if (length < 32) {
      _deviceUuid = _deviceUuid.padRight(32, 'X');
    } else if (length > 32) {
      _deviceUuid = _deviceUuid.substring(0, 32);
    }

    return _deviceUuid;
  }

  Future<bool> attempt(
    String email,
    String password, {
    bool sendPushInfo = false,
  }) async {
    // Get the user profile for id
    return await api.login(email, password).then((User result) async {
      await save(result);
      return true;
    }, onError: (error) {
      throw error;
    });
  }

  Future logOut() async {
    await Future.wait([
      storage.delete(key: 'user'),
      notifications.cancelAll(),
    ]);

    user.value = User.none;
  }

  Future sendDeviceInfo(User newUser) async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String deviceType;
    String deviceVersion;
    String deviceUuid;
    String appVersion = packageInfo.version;

    try {
      deviceType = Platform.operatingSystem;

      if (Platform.isAndroid) {
        final AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;
        deviceVersion = build.version.release;
        deviceUuid = build.androidId; // UUID for Android
      } else if (Platform.isIOS) {
        final IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        deviceVersion = data.systemVersion;
        deviceUuid = data.identifierForVendor; // UUID for iOS
      }

      newUser.deviceInfo = [
        'UUID: $deviceUuid',
        'Device: ${deviceType.replaceFirst(RegExp(r'os'), 'OS')}',
        'OS Version: $deviceVersion',
        'App Version: $appVersion',
      ];

      user.value = newUser;
    } catch (e) {}
  }

    
  /// Write user data to secure storage, this will be used to get the valid 
  /// login details if they are offline
  Future<void> save(User newUser) async {
    // Save the user id so we can compare it against the next attempted login
    storage.write(key: firstLoggedInUser, value: newUser.id.toString());

    final encodedUser = jsonEncode(newUser.toMap());

    final encryptedUser = encrypter.encrypt(encodedUser, iv: iv);

    await storage.write(
      key: 'user',
      value: encryptedUser.base64,
    );

    // Add the fetched user to the User "stream" provider so we can access it throughout the app
    user.value = newUser;

    return Future.value();
  }
}
