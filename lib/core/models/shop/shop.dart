import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pingna/core/constants.dart';

class Shop {
  final int id;
  final int shopTypeId;

  final String name;
  final String description;
  final String imageUrl;
  final List<int> labelIds;

  final TimeOfDay opensAt;
  final TimeOfDay closesAt;

  Shop(
    this.id, {
    this.shopTypeId,
    this.name,
    this.description,
    this.imageUrl,
    this.labelIds,
    this.opensAt,
    this.closesAt,
  });

  static Shop fromMap(Map<String, dynamic> map) {
    List<int> labelIdList = map[colLabelIds] is String
        ? jsonDecode(map[colLabelIds])
        : List.from(map[colLabelIds]);

    TimeOfDay opensAt;
    final opensAtMap = map[colOpensAt];
    if (opensAtMap != null) {
      final parts = opensAtMap.split(':');
      opensAt = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    TimeOfDay closesAt;
    final closesAtMap = map[colClosesAt];
    if (closesAtMap != null) {
      final parts = closesAtMap.split(':');
      closesAt = TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      );
    }

    return Shop(
      map[colId],
      shopTypeId: map[colShopTypeId],
      name: map[colName],
      description: map[colDescription],
      imageUrl: map[colImageUrl],
      labelIds: labelIdList,
      opensAt: opensAt,
      closesAt: closesAt,
    );
  }

  Map<String, dynamic> toMap() {
    String labelsEncoded;
    if (labelIds != null && labelIds.length > 0) {
      labelsEncoded = jsonEncode(labelIds);
    }

    String opens;
    if (opensAt != null) opens = ('${opensAt.hour}:${opensAt.minute}');

    String closes;
    if (closesAt != null) closes = ('${closesAt.hour}:${closesAt.minute}');

    return {
      colId: id,
      colShopTypeId: shopTypeId,
      colName: name,
      colDescription: description,
      colImageUrl: imageUrl,
      colLabelIds: labelsEncoded,
      colOpensAt: opens,
      colClosesAt: closes,
    };
  }
}
