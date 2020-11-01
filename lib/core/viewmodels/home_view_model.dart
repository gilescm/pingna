import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/shop/shop_label.dart';
import 'package:pingna/core/models/shop/shop_type.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  final User user;
  final PingnaApi api;
  final rng = new Random();

  HomeViewModel(this.user, this.api);

  bool _isInitialised = false;
  bool get isInitialised => _isInitialised;
  set isInitialised(bool value) {
    _isInitialised = value;
    notifyListeners();
  }

  List<ShopType> _shopTypes;
  List<ShopType> get shopTypes => _shopTypes;

  List<Shop> _shops;
  List<Shop> get shops => _shops;

  List<ShopLabel> _shopLabels;
  List<ShopLabel> get shopLabels => _shopLabels;

  List<Shop> shopsBy(int shopTypeId) {
    return shops.where((shop) => shop.shopTypeId == shopTypeId).toList();
  }

  List<String> shopLabelsFor(Shop shop) {
    return _shopLabels
        .where((label) => shop.labelIds.contains(label.id))
        .map((label) => label.name)
        .toList();
  }

  void init() async {
    _shopTypes = await api.shopTypes();
    _shops = await api.shops();
    _shopLabels = await api.shopLabels();
    isInitialised = true;
  }

  int get randomId => rng.nextInt(100);
}
