import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/api_service.dart';
import 'package:pingna/core/viewmodels/shop_view_model.dart';
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/core/models/product/product_type.dart';
import 'package:pingna/core/models/shop/shop_item_model.dart';

import 'package:pingna/resources/views/product_list_view.dart';
import 'package:pingna/resources/widgets/forms/search_button.dart';
import 'package:pingna/resources/widgets/shapes/product_indicator.dart';
import 'package:pingna/resources/widgets/layouts/shop_image_app_bar.dart';
import 'package:pingna/resources/widgets/layouts/shop_title_app_bar.dart';
import 'package:pingna/resources/widgets/utilities/measured_size_widget.dart';

const double _kLeadingIconSize = 40;

class ShopView extends StatelessWidget {
  const ShopView({
    @required this.itemModel,
  });

  final ShopItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShopViewModel(
        itemModel.shop,
        context.read<User>(),
        context.read<PingnaApi>(),
      )..init(),
      builder: (context, child) => Scaffold(
        body: Stack(
          alignment: Alignment.topLeft,
          children: [
            ShopViewBody(
              model: context.watch<ShopViewModel>(),
              itemModel: itemModel,
            ),
            SafeArea(
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.chevron_left,
                  size: _kLeadingIconSize,
                  color: Theme.of(context).accentIconTheme.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopViewBody extends StatefulWidget {
  const ShopViewBody({
    Key key,
    @required this.model,
    @required this.itemModel,
  }) : super(key: key);

  final ShopViewModel model;
  final ShopItemModel itemModel;

  @override
  _ShopViewBodyState createState() => _ShopViewBodyState();
}

class _ShopViewBodyState extends State<ShopViewBody>
    with SingleTickerProviderStateMixin {
  ShopViewModel get model => widget.model;

  double _searchBarHeight = 50;
  double _tabBarHeight = 50;

  double get _minHeaderHeight => _searchBarHeight + _tabBarHeight;

  @override
  Widget build(BuildContext context) {
    final productTypes = model.productTypes;
    return DefaultTabController(
      length: productTypes.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            ShopImageAppBar(
              shop: widget.itemModel.shop,
              labels: widget.itemModel.labelNames,
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                context,
              ),
              sliver: ShopTitleAppBar(
                minimumExtent: _minHeaderHeight,
                leadingIconSize: _kLeadingIconSize,
                shop: widget.itemModel.shop,
                title: MeasureSize(
                  onChange: (size) => setState(() {
                    return _searchBarHeight = size.height;
                  }),
                  child: SearchButton(),
                ),
                bottom: model.isInitialised
                    ? MeasureSize(
                        onChange: (size) => setState(() {
                          _tabBarHeight = size.height;
                        }),
                        child: TabBar(
                          isScrollable: true,
                          indicator: ProductTabIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                          tabs: productTypes.map<Tab>((type) {
                            return Tab(text: type.name);
                          }).toList(),
                        ),
                      )
                    : null,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: productTypes.map((ProductType type) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                builder: (BuildContext context) => FutureBuilder(
                  future: model.productsForType(type),
                  builder: (_, AsyncSnapshot<List<Product>> _snapshot) {
                    if (!_snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return ProductListView(
                      productType: type,
                      products: _snapshot.data,
                      context: context,
                    );
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
