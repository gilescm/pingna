
import 'package:flutter/material.dart';

class ShopLabelItem extends StatelessWidget {
  const ShopLabelItem({
    Key key,
    @required this.label,
    @required this.fontFamily,
  }) : super(key: key);

  final String label;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: pingnaShopLabelShape.borderRadius,
          color: Theme.of(context).primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).scaffoldBackgroundColor,
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }

  static const pingnaShopLabelShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12.0),
      bottomRight: Radius.circular(12.0),
    ),
  );
}