import 'package:pingna/core/constants.dart';

class ProductType {
  final int id;
  final int shopId;
  final String name;

  ProductType(this.id, {this.shopId, this.name});

  static ProductType fromMap(Map<String, dynamic> map) {
    return ProductType(
      map[colId],
      shopId: map[colShopId],
      name: map[colName],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId: id,
      colShopId: shopId,
      colName: name,
    };
  }
}
