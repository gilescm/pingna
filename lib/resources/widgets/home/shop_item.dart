import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pingna/core/constants.dart';
import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/home/shop_labels.dart';

class HomeShopItem extends StatelessWidget {
  const HomeShopItem({
    @required this.item,
    @required this.labels,
  });

  final Shop item;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.headline6.fontFamily;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(shopRoute, arguments: {
        "shop": item,
        "labels": labels,
      }),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Hero(
          tag: 'shop-${item.id}',
          child: Card(
            elevation: 5,
            shape: pingnaShopCardShape,
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: pingnaShopCardShape.borderRadius,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.imageUrl),
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
        ),
      ),
    );
  }
}
