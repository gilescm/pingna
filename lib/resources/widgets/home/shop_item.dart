import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pingna/core/models/shop/shop.dart';

class HomeShopItem extends StatelessWidget {
  const HomeShopItem({
    @required this.item,
    @required this.labels,
    this.picIndex,
  });

  final Shop item;
  final List<String> labels;
  final int picIndex;

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.headline6.fontFamily;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        elevation: 5,
        shape: pingnaShopCardShape,
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            borderRadius: pingnaShopCardShape.borderRadius,
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                "https://picsum.photos/id/$picIndex/300",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: pingnaShopTitleShape.borderRadius,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: labels.map<Widget>((label) {
                            return ShopLabelItem(
                              label: label,
                              fontFamily: fontFamily,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    ListTile(
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        item.name,
                        style: TextStyle(fontFamily: fontFamily),
                      ),
                      subtitle: Text(
                        item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const pingnaShopCardShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(12.0),
      bottomLeft: Radius.circular(12.0),
    ),
  );

  static const pingnaShopTitleShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12.0),
      bottomLeft: Radius.circular(12.0),
    ),
  );
}

class ShopLabelItem extends StatelessWidget {
  const ShopLabelItem({
    Key key,
    @required this.label,
    @required this.fontFamily,
  }) : super(key: key);

  final String label;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: pingnaShopLabelShape.borderRadius,
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }

  static const pingnaShopLabelShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12.0),
      bottomRight: Radius.circular(12.0),
    ),
  );
}
