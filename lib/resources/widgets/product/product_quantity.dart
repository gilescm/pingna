import 'package:flutter/material.dart';
import 'package:pingna/core/models/product/product.dart';
import 'package:pingna/resources/assets.dart';

class ProductQuantity extends StatefulWidget {
  const ProductQuantity({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductQuantityState createState() => _ProductQuantityState();

  static const padding = const EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 8.0,
  );
}

class _ProductQuantityState extends State<ProductQuantity> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: pingnaButtonShape.borderRadius,
          onTap: () {
            if (quantity > 0) setState(() => quantity--);
          },
          child: Container(
            decoration: BoxDecoration(
              border: border(context),
              borderRadius: pingnaButtonShape.borderRadius,
            ),
            padding: ProductQuantity.padding,
            child: Text(
              '-',
              style: textStyle(context),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(
            quantity.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        InkWell(
          borderRadius: pingnaShopCardShape.borderRadius,
          onTap: () {
            if (quantity < 25) setState(() => quantity++);
          },
          child: Container(
            decoration: BoxDecoration(
              border: border(context),
              borderRadius: pingnaShopCardShape.borderRadius,
            ),
            padding: ProductQuantity.padding,
            child: Text(
              '+',
              style: textStyle(context),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle textStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.bold,
    );
  }

  Border border(BuildContext context) {
    return Border.all(color: Theme.of(context).primaryColor, width: 2.0);
  }
}
