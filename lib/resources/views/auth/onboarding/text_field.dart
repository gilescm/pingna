import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PingnaTextField extends StatelessWidget {
  const PingnaTextField({
    @required this.focusNode,
    @required this.label,
    this.enableSuffix,
    this.textCapitalization,
    this.inputFormatters,
  });

  final FocusNode focusNode;
  final String label;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;

  /// If enabled then suffix will appear whilst field is in focus
  final bool enableSuffix;

  @override
  Widget build(BuildContext context) {
    final showSuffix = enableSuffix && focusNode.hasFocus;
    return TextFormField(
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: showSuffix ? PingnaFieldSuffix() : null,
        ),
      ),
      textCapitalization: textCapitalization,
      inputFormatters: inputFormatters,
    );
  }
}

class PingnaFieldSuffix extends StatelessWidget {
  const PingnaFieldSuffix({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
      ),
      child: Icon(
        Icons.arrow_forward_rounded,
        size: 15,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
