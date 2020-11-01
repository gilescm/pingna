import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pingna/core/constants.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/auth_service.dart';
import 'package:pingna/core/viewmodels/onboarding/post_code_view_model.dart';
import 'package:pingna/resources/widgets/forms/text_field.dart';
import 'package:pingna/resources/widgets/forms/submit_button.dart';
import 'package:pingna/resources/widgets/layouts/alert_dialog.dart';
import 'package:pingna/resources/widgets/shapes/post_box_shape.dart';
import 'package:provider/provider.dart';

class PostCodeView extends StatefulWidget {
  @override
  _PostCodeViewState createState() => _PostCodeViewState();
}

class _PostCodeViewState extends State<PostCodeView> {
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
          body: PostCodeForm(),
        ),
      ],
    );
  }
}

class PostCodeForm extends StatefulWidget {
  const PostCodeForm({Key key}) : super(key: key);

  @override
  _PostCodeFormState createState() => _PostCodeFormState();
}

class _PostCodeFormState extends State<PostCodeForm> {
  StreamSubscription _keyboardListener;
  FocusNode _focusNode;
  bool _showConfirm = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return ChangeNotifierProvider(
      create: (context) => PostCodeViewModel(
        context.read<User>(),
        context.read<Auth>(),
      ),
      child: Consumer<PostCodeViewModel>(
        builder: (context, model, _) => Form(
          key: _formKey,
          child: Column(
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
                        value: model.postCode,
                        label: 'onboarding.postcode'.tr(),
                        enableSuffix: true,
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z\ 0-9]'),
                          )
                        ],
                        onChanged: (value) => model.postCode = value,
                        onFieldSubmitted: (value) => save(model),
                        validator: (value) {
                          if ((value ?? '').isNotEmpty) return null;
                          return 'onboarding.postcode_required'.tr();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              if (_showConfirm)
                PingnaSubmitButton(
                  label: 'onboarding.check_now'.tr(),
                  onPressed: () => save(model),
                  style: PingnaButtonStyle.secondary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void save(PostCodeViewModel model) async {
    if (_formKey.currentState.validate()) {
      model.save();
      await showDialog(
        context: context,
        builder: (context) {
          return PingnaAlertDialog(
            title: 'onboarding.success'.tr(),
            confirmText: 'app.btn.ok'.tr(),
            showCancel: false,
          );
        },
      );

      Navigator.of(context).pushNamed(firstFreeDeliveryRoute);
    }
  }
}
