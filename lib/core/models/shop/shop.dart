import 'dart:convert';

import 'package:pingna/core/constants.dart';

class Shop {
  final int id;
  final int shopTypeId;

  final String name;
  final String description;
  final String imageUrl;
  final List<int> labelIds;

  Shop(
    this.id, {
    this.shopTypeId,
    this.name,
    this.description,
    this.imageUrl,
    this.labelIds,
  });

  static Shop fromMap(Map<String, dynamic> map) {
    List labelIdList = map[colLabelIds] is String
        ? jsonDecode(map[colLabelIds])
        : map[colLabelIds];

    return Shop(
      map[colId],
      shopTypeId: map[colShopTypeId],
      name: map[colName],
      description: map[colDescription],
      imageUrl: map[colImageUrl],
      labelIds: labelIdList,
    );
  }

  Map<String, dynamic> toMap() {
    String labelsEncoded;
    if (labelIds != null && labelIds.length > 0) {
      labelsEncoded = jsonEncode(labelIds);
    }

    return {
      colId: id,
      colShopTypeId: shopTypeId,
      colName: name,
      colDescription: description,
      colImageUrl: imageUrl,
      colLabelIds: labelsEncoded,
    };
  }
}
