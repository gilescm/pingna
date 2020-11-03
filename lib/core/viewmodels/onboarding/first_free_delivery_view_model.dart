import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/auth_service.dart';

class SignUpBonusModel extends ChangeNotifier {
  final User user;
  final Auth auth;

  SignUpBonusModel(this.user, this.auth);

  String _email;
  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  String _firstName;
  String get firstName => _firstName;
  set firstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void save() => auth.save(user.copyWith(email: email, firstName: firstName));

  String validateEmail(String value) {
    // Generic email regex
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'onboarding.validation.email'.tr();
    } else if (!regExp.hasMatch(value)) {
      return 'onboarding.validation.email_format'.tr();
    }

    return null;
  }
}
