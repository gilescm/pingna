import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PingnaTextField extends StatelessWidget {
  const PingnaTextField({
    @required this.focusNode,
    @required this.label,
    @required this.value,
    this.enableSuffix = false,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
  });

  final FocusNode focusNode;
  final String label;
  final String value;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;

  final Function(String) onChanged;
  final Function(String) onFieldSubmitted;
  final Function(String) validator;

  /// If enabled then suffix will appear whilst field is in focus
  final bool enableSuffix;

  @override
  Widget build(BuildContext context) {
    final showSuffix = enableSuffix && focusNode.hasFocus;
    return TextFormField(
      initialValue: value,
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: showSuffix ? PingnaFieldSuffix() : null,
        ),
      ),
      textCapitalization: textCapitalization,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
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
