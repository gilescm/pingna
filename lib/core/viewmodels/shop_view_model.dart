import 'package:flutter/material.dart';
import 'package:pingna/core/models/product/product.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/product/product_type.dart';
import 'package:pingna/core/services/api_service.dart';

class ShopViewModel extends ChangeNotifier {
  final Shop shop;
  final User user; // User would be used for authentication in production app
  final PingnaApi api;

  ShopViewModel(this.shop, this.user, this.api);

  bool _isInitialised = false;
  bool get isInitialised => _isInitialised;
  set isInitialised(bool value) {
    _isInitialised = value;
    notifyListeners();
  }

  List<ProductType> _productTypes = [];
  List<ProductType> get productTypes => _productTypes;

  Map<ProductType, List<Product>> _products = {};
  Future<List<Product>> productsForType(ProductType type) async {
    final products = _products[type];
    if (products != null) return products;

    _products[type] = await api.products(type.id);
    return _products[type];
  } 

  void init() async {
    _productTypes = await api.productTypes(shop.id);
    isInitialised = true;
  }
}
