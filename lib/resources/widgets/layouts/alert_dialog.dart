import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:pingna/resources/widgets/animations/delayed_entrance.dart';

class PingnaAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final Function confirmOnTap;
  final Function cancelOnTap;
  final Function onShow;
  final String confirmText;
  final String cancelText;
  final bool doAnimation;
  final bool showConfirm;
  final bool showCancel;
  final double buttonSize;
  final EdgeInsets insetPadding;

  PingnaAlertDialog({
    this.title,
    this.content,
    this.confirmOnTap,
    this.cancelOnTap,
    this.onShow,
    this.confirmText,
    this.cancelText,
    this.doAnimation = true,
    this.showConfirm = true,
    this.showCancel = true,
    this.buttonSize = 20,
    this.insetPadding = const EdgeInsets.symmetric(
      horizontal: 40.0,
      vertical: 24.0,
    ),
  });

  void afterBuild() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (onShow != null) onShow();
    });
  }

  @override
  Widget build(BuildContext context) {
    afterBuild();
    var alertDialog = AlertDialog(
      insetPadding: insetPadding,
      scrollable: true,
      title: (title ?? '').isEmpty
          ? null
          : Text(
              title,
              textAlign: TextAlign.left,
              style:
                  Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 18),
            ),
      content: content != null ? content : null,
      actions: <Widget>[
        if (showCancel)
          FlatButton(
            onPressed: cancelOnTap != null
                ? cancelOnTap
                : () => Future.delayed(Duration(milliseconds: 100)).then(
                      (res) => Navigator.of(context).pop(true),
                    ),
            child: Text(
              cancelText ?? 'app.btn.no'.tr(),
              style: TextStyle(
                fontSize: buttonSize,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),
        if (showConfirm)
          FlatButton(
            onPressed: confirmOnTap != null
                ? confirmOnTap
                : () => Future.delayed(Duration(milliseconds: 100)).then(
                      (res) => Navigator.of(context).pop(),
                    ),
            child: Text(
              confirmText ?? 'app.btn.yes'.tr(),
              style: TextStyle(
                fontSize: buttonSize,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),
      ],
    );

    if (doAnimation)
      return DelayedEntrance(child: alertDialog);
    else
      return alertDialog;
  }
}
