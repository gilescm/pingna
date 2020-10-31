import 'package:pingna/core/constants.dart';

class Basket {
  final int id;
  final int userId;
  final int shopId;

  final BasketStatus status;

  final DateTime createdAt;
  final DateTime updatedAt;

  Basket(
    this.id, {
    this.userId,
    this.shopId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  static Basket fromMap(Map<String, dynamic> map) {
    BasketStatus status;
    final statusMap = map[colStatus];
    if (statusMap != null) {
      switch (statusMap) {
        case 'BasketStatus.checked_out':
          status = BasketStatus.checked_out;
          break;
        case 'BasketStatus.pending':
          status = BasketStatus.pending;
          break;
      }
    }

    DateTime createdAt;
    final createdAtMap = map[colCreatedAt];
    if (createdAtMap != null) createdAt = DateTime.tryParse(createdAtMap);

    DateTime updatedAt;
    final updatedAtMap = map[colUpdatedAt];
    if (updatedAtMap != null) createdAt = DateTime.tryParse(updatedAtMap);

    return Basket(
      map[colId],
      userId: map[colUserId],
      shopId: map[colShopId],
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      colId: id,
      colUserId: userId,
      colShopId: shopId,
      colStatus: status?.toString(),
      colCreatedAt: createdAt?.toIso8601String(),
      colUpdatedAt: updatedAt?.toIso8601String(),
    };
  }
}
