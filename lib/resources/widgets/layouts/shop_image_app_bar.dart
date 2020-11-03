import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/home/shop_labels.dart';

class ShopImageAppBar extends StatelessWidget {
  const ShopImageAppBar({
    Key key,
    @required this.shop,
    @required this.labels,
  }) : super(key: key);

  final Shop shop;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.headline6.fontFamily;
    return SliverAppBar(
      expandedHeight: 300,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Hero(
          tag: 'shop-${shop.id}',
          child: Material(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(shop.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: pingnaShopAppBarShape.borderRadius,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: labels.map<Widget>((label) {
                              return ShopLabelItem(
                                label: label,
                                fontFamily: fontFamily,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // bottom: bottom,
    );
  }
}
