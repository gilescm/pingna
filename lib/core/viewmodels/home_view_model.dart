import 'package:flutter/material.dart';

import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/shop/shop_item_model.dart';
import 'package:pingna/core/models/shop/shop_label.dart';
import 'package:pingna/core/models/shop/shop_type.dart';
import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/api_service.dart';

class HomeViewModel extends ChangeNotifier {
  final User user;
  final PingnaApi api;

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
  List<ShopLabel> _shopLabels;

  List<ShopItemModel> shopsBy(int shopTypeId) {
    final results = _shops.where((shop) => shop.shopTypeId == shopTypeId);
    return results.map<ShopItemModel>((shop) {
      return ShopItemModel(
        shop: shop,
        labels: shopLabelsFor(shop),
      );
    }).toList();
  }

  List<ShopLabel> shopLabelsFor(Shop shop) {
    return _shopLabels.where((label) {
      return shop.labelIds.contains(label.id);
    }).toList();
  }

  void init() async {
    _shopTypes = await api.shopTypes();

    // TODO: Think about refactoring [api.shops()] out this view model
    // The idea being that we can then update the api to only return shops of a given type
    // Trade off is more api calls though.
    _shops = await api.shops();
    _shopLabels = await api.shopLabels();
    isInitialised = true;
  }
}