import 'package:flutter/material.dart';

import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/core/models/product/product_type.dart';
import 'package:pingna/resources/widgets/product/product_image.dart';
import 'package:pingna/resources/widgets/product/product_price.dart';
import 'package:pingna/resources/widgets/product/product_quantity.dart';

class ProductListView extends StatelessWidget {
  ProductListView({
    @required this.productType,
    @required this.products,
    @required this.context,
  });

  final ProductType productType;
  final List<Product> products;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: PageStorageKey<String>(productType.name),
      slivers: <Widget>[
        SliverOverlapInjector(
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, index) => ProductListItem(product: products[index]),
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: ProductImage(product: product),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(title: Text(product.name)),
                ListTile(
                  leading: ProductPrice(product: product),
                  trailing: ProductQuantity(product: product),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Row(
                //     children: [
                //       ProductPrice(product: product),
                //       ProductQuantity(product: product),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
