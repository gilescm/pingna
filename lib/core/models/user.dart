import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/constants.dart';

class User {
  static const VISITOR = 1;
  static const CUSTOMER = 2;

  final int id;
  final String email;
  final String firstName;
  final String postCode;
  final int userTypeId;

  List _deviceInfo;
  List get deviceInfo => _deviceInfo;
  set deviceInfo(value) => _deviceInfo = value;

  User(
    this.id, {
    this.email,
    this.firstName,
    this.postCode,
    this.userTypeId,
  });

  static User none = User(null);

  // Create a user object from another object i.e. dynamic object returned from API call
  static User fromMap(Map<String, dynamic> map) {
    return User(
      map[colId],
      email: map[colEmail],
      firstName: map[colFirstName],
      postCode: map[colPostCode],
      userTypeId: map[colUserTypeId],
    );
  }

  // Convert this model to a map so it can be stored in the DB
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      colId: id,
      colEmail: email,
      colFirstName: firstName,
      colPostCode: postCode,
      colUserTypeId: userTypeId,
    };

    return map;
  }

  User copyWith({
    String email,
    int id,
    String firstName,
    String postCode,
    int userTypeId,
  }) {
    return User(
      id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      postCode: postCode ?? this.postCode,
      userTypeId: userTypeId ?? this.userTypeId,
    );
  }

  bool get isVisitor => userTypeId == VISITOR;
  bool get isCustomer => userTypeId == CUSTOMER;

  String get name => this.firstName ?? 'app.you'.tr();
}
