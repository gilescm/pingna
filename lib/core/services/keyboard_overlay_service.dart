import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:pingna/resources/widgets/forms/keyboard_action_bar.dart';

class KeyboardOverlayService {
  StreamSubscription _keyboardListener;
  bool showOverlay = true;

  KeyboardOverlayService();

  void start(BuildContext context) {
    _keyboardListener = KeyboardVisibility.onChange.listen((bool visible) {
      if (visible && showOverlay) {
        KeyboardOverlay.showOverlay(context);
      } else {
        KeyboardOverlay.removeOverlay();
      }
    });
  }

  void cancel() => _keyboardListener?.cancel();
}
