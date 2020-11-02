import 'package:flutter/material.dart';
import 'package:pingna/resources/assets.dart';

class PingnaSubmitButton extends StatelessWidget {
  const PingnaSubmitButton({
    Key key,
    this.label,
    this.style,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final PingnaButtonStyle style;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).buttonColor;
    Color textColor = Theme.of(context).scaffoldBackgroundColor;
    if (style == PingnaButtonStyle.secondary) {
      color = Theme.of(context).scaffoldBackgroundColor;
      textColor = Theme.of(context).buttonColor;
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: FlatButton(
        padding: const EdgeInsets.all(20.0),
        shape: pingnaButtonShape,
        child: Text(label),
        textColor: textColor,
        color: color,
        onPressed: onPressed,
      ),
    );
  }

}

enum PingnaButtonStyle { primary, secondary }
