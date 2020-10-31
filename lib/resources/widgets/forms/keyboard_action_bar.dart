import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/resources/assets.dart';

class InputDoneView extends StatefulWidget {
  final bool unfocus;
  final String doneLabel;
  final Color doneColor;
  final Function onDone;
  final bool showCancel;

  InputDoneView({
    this.unfocus = true,
    this.doneLabel,
    this.doneColor,
    this.onDone,
    this.showCancel = false,
  });

  @override
  _InputDoneViewState createState() => _InputDoneViewState();
}

class _InputDoneViewState extends State<InputDoneView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: widget.showCancel
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          children: [
            if (widget.showCancel)
              GestureDetector(
                onTap: () {
                  if (widget.unfocus)
                    FocusScope.of(context).requestFocus(FocusNode());
                  else
                    Navigator.of(context).pop();
                },
                child: Text(
                  'app.btn.cancel'.tr(),
                  style: CupertinoTextThemeData()
                      .navActionTextStyle
                      .copyWith(color: lightcharcoalColor),
                ),
              ),
            GestureDetector(
              onTap: () {
                if (widget.onDone != null) {
                  widget.onDone();
                } else if (widget.unfocus) {
                  FocusScope.of(context).requestFocus(FocusNode());
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                widget.doneLabel ?? 'app.btn.close'.tr(),
                style: CupertinoTextThemeData().navActionTextStyle.copyWith(
                    fontWeight: FontWeight.w600, color: widget.doneColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class KeyboardOverlay {
  static OverlayEntry _overlayEntry;

  static showOverlay(BuildContext context) {
    if (_overlayEntry != null) return;

    OverlayState overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0.0,
        left: 0.0,
        child: InputDoneView(doneColor: Theme.of(context).accentColor),
      );
    });

    overlayState.insert(_overlayEntry);
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
      _overlayEntry = null;
    }
  }
}
