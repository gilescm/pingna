import 'package:pingna/core/constants.dart';

class Product {
  final int id;
  final int productTypeId;
  final String name;
  final String imageUrl;

  final int price;
  final int reducedBy;

  final ProductStatus status;
  
  final DateTime expiresAt;

  Product(
    this.id, {
    this.productTypeId,
    this.name,
    this.imageUrl,
    this.price,
    this.reducedBy,
    this.status,
    this.expiresAt,
  });

  static Product fromMap(Map<String, dynamic> map) {
    ProductStatus status;
    final statusMap = map[colStatus];
    if (statusMap != null) {
      switch (statusMap) {
        case 'ProductStatus.out_of_stock':
          status = ProductStatus.out_of_stock;
          break;
        case 'ProductStatus.running_low':
          status = ProductStatus.running_low;
          break;
        case 'ProductStatus.in_stock':
          status = ProductStatus.in_stock;
          break;
      }
    }

    DateTime expiresAt;
    final expiresAtMap = map[colExpiresAt];
    if (expiresAtMap != null) expiresAt = DateTime.tryParse(expiresAtMap);

    return Product(
      map[colId],
      productTypeId: map[colProductTypeId],
      name: map[colName],
      imageUrl: map[colImageUrl],
      price: map[colPrice],
      reducedBy: map[colReducedBy],
      status: status,
      expiresAt: expiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId: id,
      colProductTypeId: productTypeId,
      colName: name,
      colImageUrl: imageUrl,
      colPrice: price,
      colReducedBy: reducedBy,
      colStatus: status?.toString(),
      colExpiresAt: expiresAt?.toIso8601String(),
    };
  }
}
