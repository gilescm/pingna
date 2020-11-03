import 'package:flutter/material.dart';
import 'package:pingna/core/models/shop/shop.dart';

class ShopTitleAppBar extends StatelessWidget {
  ShopTitleAppBar({
    this.leadingIconSize,
    this.minimumExtent,
    this.shop,
    this.title,
    this.bottom,
  });

  final double leadingIconSize;
  final double minimumExtent;

  final Shop shop;
  final Widget title;
  final Widget bottom;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _ShopTitleAppBarDelegate(
        shop: shop,
        title: title,
        bottom: bottom,
        leadingIconSize: leadingIconSize,
        minimumExtent: minimumExtent,
        topPadding: MediaQuery.of(context).padding.top,
      ),
    );
  }
}

class _ShopTitleAppBarDelegate extends SliverPersistentHeaderDelegate {
  _ShopTitleAppBarDelegate({
    this.shop,
    this.title,
    this.bottom,
    this.leadingIconSize,
    this.minimumExtent,
    this.topPadding,
  });

  final Shop shop;
  final Widget title;
  final Widget bottom;
  final double leadingIconSize;
  final double minimumExtent;
  final double topPadding;

  static const _kDuration = Duration(milliseconds: 150);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final fontFamily = Theme.of(context).textTheme.headline6.fontFamily;

    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    final isLeavingView = progress > 0;
    return Stack(
      children: [
        // onChange: (size) => print(size),
        Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SafeArea(
                child: AnimatedContainer(
                  duration: _kDuration,
                  padding: EdgeInsets.only(
                    left: isLeavingView ? leadingIconSize : 0.0,
                  ),
                  child: title,
                ),
              ),
              bottom ?? Container(),
            ],
          ),
        ),
        Positioned(
          top: 0.0 - (isLeavingView ? 10.0 * (progress * 10.0) : 0.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListTile(
              title: Text(
                shop.name,
                style: TextStyle(fontFamily: fontFamily),
              ),
              subtitle: Text(
                shop.description,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => (minimumExtent + topPadding) * 1.5;

  @override
  double get minExtent => minimumExtent + topPadding;

  @override
  bool shouldRebuild(_ShopTitleAppBarDelegate oldDelegate) {
    return bottom != oldDelegate.bottom;
  }
}
