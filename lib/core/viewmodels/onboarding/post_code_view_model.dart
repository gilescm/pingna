import 'package:flutter/material.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/auth_service.dart';

class PostCodeViewModel extends ChangeNotifier {
  final User user;
  final Auth auth;

  PostCodeViewModel(this.user, this.auth);

  String _postCode;
  String get postCode => _postCode;
  set postCode(String value) {
    _postCode = value;
    notifyListeners();
  }

  void save() => auth.save(user.copyWith(postCode: _postCode));
}
