
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/resources/assets.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final fontFamily = Theme.of(context).textTheme.headline6.fontFamily;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: pingnaProductShape.borderRadius,
          child: CachedNetworkImage(
            imageUrl: "https://picsum.photos/id/${product.id}/200",
            errorWidget: (context, _, __) => Placeholder(
              fallbackWidth: MediaQuery.of(context).size.width * 0.25,
              fallbackHeight: MediaQuery.of(context).size.width * 0.25,
            ),
          ),
        ),
        if (product.isReduced)
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
              borderRadius: pingnaReducedShape.borderRadius,
              color: reducedColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'shop.reduced'.tr(),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      fontFamily: fontFamily,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          )
      ],
    );
  }
}