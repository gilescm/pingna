import 'package:flutter/painting.dart';

class ProductTabIndicator extends Decoration {
  final BoxPainter _painter;

  ProductTabIndicator({Color color}) : _painter = _IndicatorPainter(color);

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _IndicatorPainter extends BoxPainter {
  final Paint _paint;

  _IndicatorPainter(Color color)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final end = offset + Offset(cfg.size.width * 0.95, cfg.size.height * 0.5);
    canvas.drawCircle(end, 4, _paint);
  }
}