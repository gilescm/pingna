import 'package:flutter/material.dart';
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/core/models/product/product_type.dart';
import 'package:pingna/resources/views/product_list_view.dart';
import 'package:pingna/resources/widgets/shapes/product_indicator.dart';
import 'package:provider/provider.dart';

import 'package:pingna/core/models/shop/shop.dart';
import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/api_service.dart';
import 'package:pingna/core/viewmodels/shop_view_model.dart';

import 'package:pingna/resources/widgets/layouts/shop_app_bar.dart';

class ShopView extends StatelessWidget {
  const ShopView({
    @required this.shop,
    @required this.labels,
  });

  final Shop shop;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ShopViewModel(
        shop,
        context.read<User>(),
        context.read<PingnaApi>(),
      )..init(),
      child: Consumer<ShopViewModel>(
        builder: (context, model, _) {
          if (!model.isInitialised) return CircularProgressIndicator();

          return ShopViewBody(
            model: model,
            labels: labels,
          );
        },
      ),
    );
  }
}

class ShopViewBody extends StatefulWidget {
  const ShopViewBody({
    Key key,
    @required this.model,
    @required this.labels,
  }) : super(key: key);

  final ShopViewModel model;
  final List<String> labels;

  @override
  _ShopViewBodyState createState() => _ShopViewBodyState();
}

class _ShopViewBodyState extends State<ShopViewBody>
    with SingleTickerProviderStateMixin {
  ShopViewModel get model => widget.model;

  ScrollController _scrollController;
  List<ProductType> productTypes;

  @override
  void initState() {
    super.initState();
    productTypes = model.productTypes;
    _scrollController = ScrollController()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: productTypes.length,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
                sliver: ShopAppBar(
                  shop: widget.model.shop,
                  labels: widget.labels,
                  controller: _scrollController,
                  bottom: TabBar(
                    isScrollable: true,
                    indicator: ProductTabIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                    tabs: productTypes.map<Tab>((type) {
                      return Tab(text: type.name);
                    }).toList(),
                  ),
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
      ),
    );
  }
}
