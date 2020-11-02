import 'package:flutter/material.dart';
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/core/models/product/product_type.dart';

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
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
            context,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final product = products[index];
                print(product.name);
                return Material(
                  child: ListTile(
                    leading: SizedBox(
                      width: 75,
                      height: 150,
                      child: Image.network(
                        "https://picsum.photos/id/${product.id}/200",
                        fit: BoxFit.fill,
                      ),
                    ),
                    isThreeLine: true,
                    title: Text(product.name),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          children: [
                            Text(product.price.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: products.length,
            ),
          ),
        ),
      ],
    );
  }
}
