import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/home/shop_labels.dart';

class ShopAppBar extends StatelessWidget {
  const ShopAppBar({
    Key key,
    @required this.shop,
    @required this.labels,
    @required this.controller,
  }) : super(key: key);

  final Shop shop;
  final List<String> labels;
  final ScrollController controller;

  final double kExpandedHeight = 300;

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.headline6.fontFamily;
    return SliverAppBar(
      pinned: true,
      expandedHeight: kExpandedHeight,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        // TODO: Improve on this by calculating the top padding to stop resizing.
        // May also need to use a layout builder on the title so we can counteract
        // the auto resizing of the icon and text
        titlePadding: EdgeInsets.only(
          left: _leftTitlePadding,
          right: 16.0,
          bottom: 12.0,
        ),
        centerTitle: false,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: lightcharcoalColor),
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 4.0,
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'shop.search'.tr(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ],
          ),
        ),
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
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: pingnaShopAppBarShape.borderRadius,
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
                            shop.name,
                            style: TextStyle(fontFamily: fontFamily),
                          ),
                          subtitle: Text(
                            shop.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        ListTile(),
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

  static const pingnaShopAppBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(25.0),
      topRight: Radius.circular(25.0),
    ),
  );

  double get _leftTitlePadding {
    const kBasePadding = 16.0;
    const kMultiplier = 0.5;

    if (controller.hasClients) {
      if (controller.offset < (kExpandedHeight / 2)) {
        // In case 50%-100% of the expanded height is viewed
        return kBasePadding;
      }

      if (controller.offset > (kExpandedHeight - kToolbarHeight)) {
        // In case 0% of the expanded height is viewed
        return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
            kBasePadding;
      }

      // In case 0%-50% of the expanded height is viewed
      return (controller.offset - (kExpandedHeight / 2)) * kMultiplier +
          kBasePadding;
    }

    return kBasePadding;
  }
}
