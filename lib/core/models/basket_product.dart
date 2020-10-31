import 'package:pingna/core/constants.dart';

class BasketProduct {
  final int basketId;
  final int productId;
  final int quantity;

  BasketProduct(this.basketId, this.productId, {this.quantity});

  static BasketProduct fromMap(Map<String, dynamic> map) {
    return BasketProduct(
      map[colBasketId],
      map[colProductId],
      quantity: map[colQuantity],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colBasketId: basketId,
      colProductId: productId,
      colQuantity: quantity,
    };
  }

  BasketProduct copyWith({int basketId, int productId, int quantity}) {
    return BasketProduct(
      basketId ?? this.basketId,
      productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
