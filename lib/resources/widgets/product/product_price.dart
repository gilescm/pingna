import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/resources/assets.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (product.isReduced)
          Text(
            'shop.origianl_price'.tr(args: [product.price.toStringAsFixed(2)]),
            style: TextStyle(decoration: TextDecoration.lineThrough),
          ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'shop.sterling'.tr()),
              TextSpan(
                text: product.actualPrice.toStringAsFixed(2),
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: product.isReduced ? reducedColor : null,
                    ),
              ),
            ],
            style: product.isReduced ? TextStyle(color: reducedColor) : null,
          ),
        ),
      ],
    );
  }
}
