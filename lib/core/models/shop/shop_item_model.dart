
import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/shop/shop_label.dart';

class ShopItemModel {
  final Shop shop;
  final List<ShopLabel> labels;

  ShopItemModel({this.shop, this.labels});

  List<String> get labelNames => labels.map((label) => label.name).toList();
}
