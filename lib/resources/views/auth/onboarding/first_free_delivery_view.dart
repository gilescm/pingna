import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:pingna/core/constants.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/core/services/auth_service.dart';
import 'package:pingna/core/viewmodels/onboarding/first_free_delivery_view_model.dart';
import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/forms/text_field.dart';
import 'package:pingna/resources/widgets/forms/submit_button.dart';
import 'package:pingna/resources/widgets/layouts/alert_dialog.dart';
import 'package:pingna/resources/widgets/shapes/post_box_shape.dart';
import 'package:provider/provider.dart';

class FirstFreeDelivery extends StatefulWidget {
  @override
  _FirstFreeDeliveryState createState() => _FirstFreeDeliveryState();
}

class _FirstFreeDeliveryState extends State<FirstFreeDelivery> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(color: Theme.of(context).scaffoldBackgroundColor),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PostBoxShape(color: orangePastelColor),
          ],
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          backgroundColor: Colors.transparent,
          body: FirstFreeDeliveryForm(),
        ),
      ],
    );
  }
}

class FirstFreeDeliveryForm extends StatefulWidget {
  const FirstFreeDeliveryForm({Key key}) : super(key: key);

  @override
  _FirstFreeDeliveryFormState createState() => _FirstFreeDeliveryFormState();
}

class _FirstFreeDeliveryFormState extends State<FirstFreeDeliveryForm> {
  StreamSubscription _keyboardListener;
  FocusNode _emailNode, _firstNameNode;
  bool _showConfirm = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _emailNode = FocusNode();
    _firstNameNode = FocusNode();
    _keyboardListener = KeyboardVisibility.onChange.listen((event) {
      if (event && (_emailNode.hasFocus || _firstNameNode.hasFocus)) {
        setState(() => _showConfirm = false);
      } else if (!event && !_showConfirm) {
        setState(() => _showConfirm = true);
      }
    });
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _firstNameNode.dispose();
    _keyboardListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final langRef = 'onboarding.free_first';
    return ChangeNotifierProvider(
      create: (context) => FirstFreeDeliveryModel(
        context.read<User>(),
        context.read<Auth>(),
      ),
      child: Consumer<FirstFreeDeliveryModel>(
        builder: (context, model, _) => Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 12.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$langRef.title'.tr(),
                        style: Theme.of(context).textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$langRef.msg'.tr(),
                            ),
                            TextSpan(
                              text: '$langRef.privacy'.tr(),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return PingnaAlertDialog(
                                        title: '$langRef.privacy_msg'.tr(),
                                        confirmText: 'app.btn.ok'.tr(),
                                        showCancel: false,
                                      );
                                    },
                                  );
                                },
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: PingnaTextField(
                          focusNode: _emailNode,
                          value: model.email,
                          label: 'onboarding.email'.tr(),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) => model.email = value,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(_firstNameNode);
                          },
                          validator: (value) => model.validateEmail(value),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: PingnaTextField(
                          focusNode: _firstNameNode,
                          value: model.firstName,
                          label: 'onboarding.first_name'.tr(),
                          enableSuffix: true,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => model.firstName = value,
                          onFieldSubmitted: (value) => save(model),
                          validator: (value) {
                            if ((value ?? '').isNotEmpty) return null;
                            return 'onboarding.validation.first_name'.tr();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if (_showConfirm)
                  Column(
                    children: [
                      PingnaSubmitButton(
                        label: 'onboarding.get_code'.tr(),
                        onPressed: () => save(model),
                        style: PingnaButtonStyle.primary,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: InkWell(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            homeRoute,
                            (route) => false,
                          ),
                          child: Text(
                            'onboarding.no_thanks'.tr(),
                            style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          // textColor: charcoalColor,
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void save(FirstFreeDeliveryModel model) async {
    if (_formKey.currentState.validate()) {
      model.save();
      await showDialog(
        context: context,
        builder: (context) {
          return PingnaAlertDialog(
            title: 'onboarding.finished.title'.tr(),
            content: Text('onboarding.finished.msg'.tr()),
            confirmText: 'app.btn.ok'.tr(),
            showCancel: false,
          );
        },
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        homeRoute,
        (route) => false,
      );
    }
  }
}
