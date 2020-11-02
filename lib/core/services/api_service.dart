import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/core/models/product/product_type.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/shop/shop_type.dart';
import 'package:pingna/core/models/shop/shop_label.dart';

class PingnaApi {
  Future<User> login(String email, String password) {
    return Future.value(User(1, email: email));
  }

  Future<List<ShopType>> shopTypes() async {
    final List shopTypesList = jsonDecode(await getJson('shop_types'));
    return shopTypesList.map<ShopType>((item) {
      return ShopType.fromMap(item);
    }).toList();
  }

  Future<List<Shop>> shops() async {
    final List shopsList = jsonDecode(await getJson('shops'));
    return shopsList.map<Shop>((item) => Shop.fromMap(item)).toList();
  }

  Future<List<ShopLabel>> shopLabels() async {
    final List labelList = jsonDecode(await getJson('shop_labels'));
    return labelList.map<ShopLabel>((item) => ShopLabel.fromMap(item)).toList();
  }

  Future<List<ProductType>> productTypes(int shopId) async {
    final List productTypesList = jsonDecode(await getJson('product_types'));
    final allProductTypes = productTypesList.map<ProductType>((item) {
      return ProductType.fromMap(item);
    });

    return allProductTypes.where((item) => item.shopId == shopId).toList();
  }

  Future<List<Product>> products(int productTypeId) async {
    final List productsList = jsonDecode(await getJson('products'));
    final allProducts = productsList.map<Product>((item) {
      return Product.fromMap(item);
    });

    return allProducts.where((item) {
      return item.productTypeId == productTypeId;
    }).toList();
  }

  Future<String> getJson(String filename) {
    return rootBundle.loadString('assets/content/' + filename + '.json');
  }
}
