import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:pingna/core/constants.dart';
import 'package:pingna/resources/views/auth/onboarding/text_field.dart';
import 'package:pingna/resources/widgets/forms/submit_button.dart';
import 'package:pingna/resources/widgets/shapes/post_box_shape.dart';

class PostCodeView extends StatefulWidget {
  @override
  _PostCodeViewState createState() => _PostCodeViewState();
}

class _PostCodeViewState extends State<PostCodeView> {
  StreamSubscription _keyboardListener;
  FocusNode _focusNode;
  bool _showConfirm = true;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _keyboardListener = KeyboardVisibility.onChange.listen((event) {
      if (event && _focusNode.hasFocus) {
        setState(() => _showConfirm = false);
      } else if (!event && !_showConfirm) {
        setState(() => _showConfirm = true);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _keyboardListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PostBoxShape(),
          ],
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  children: [
                    Text(
                      'onboarding.welcome'.tr(),
                      style: Theme.of(context).textTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: PingnaTextField(
                        focusNode: _focusNode,
                        label: 'onboarding.postcode'.tr(),
                        enableSuffix: true,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          // Postcode regex found: here: https://stackoverflow.com/a/51885364/11198609
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z\ 0-9]'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (_showConfirm)
                PingnaSubmitButton(
                  label: 'onboarding.check_now'.tr(),
                  onPressed: () {
                    return Navigator.of(context).pushNamed(welcomeRoute);
                  },
                  style: PingnaButtonStyle.secondary,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
