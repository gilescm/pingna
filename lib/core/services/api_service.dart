import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/shop/shop_type.dart';
import 'package:pingna/core/models/shop/shop_label.dart';

class PingnaApi {
  Future<User> login(String email, String password) {
    return Future.value(User(1, email: email));
  }

  Future<List<Shop>> shops() async {
    final List shopsList = jsonDecode(await getJson('shops'));
    return shopsList.map<Shop>((item) => Shop.fromMap(item)).toList();
  }

  Future<List<ShopLabel>> shopLabels() async {
    final List labelList = jsonDecode(await getJson('shop_labels'));
    return labelList.map<ShopLabel>((item) => ShopLabel.fromMap(item)).toList();
  }

  Future<List<ShopType>> shopTypes() async {
    final List shopTypesList = jsonDecode(await getJson('shop_types'));
    return shopTypesList.map<ShopType>((item) {
      return ShopType.fromMap(item);
    }).toList();
  }

  Future<String> getJson(String filename) {
    return rootBundle.loadString('assets/content/' + filename + '.json');
  }
}
