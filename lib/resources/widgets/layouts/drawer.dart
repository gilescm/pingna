import 'package:flutter/material.dart';
import 'package:mailto/mailto.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/constants.dart';
import 'package:pingna/core/models/user.dart';

import 'package:pingna/resources/assets.dart';
import 'package:pingna/resources/widgets/layouts/alert_dialog.dart';

class PingnaDrawer extends StatelessWidget {
  const PingnaDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            DrawerItems(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                height: 40,
                width: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: darkPrimaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<User>(
          builder: (context, user, _) => ListTile(
            dense: true,
            title: Text(
              'home.drawer.greeting'.tr(args: [user.name]),
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: color,
                  ),
            ),
          ),
        ),
        Divider(
          color: color,
          thickness: 1.25,
          indent: 16.0,
          endIndent: 24.0,
        ),
        ListTile(
          onTap: () => _launchURL(context, faqLink),
          title: Text(
            'home.drawer.faqs'.tr(),
            style: TextStyle(color: color),
          ),
        ),
        ListTile(
          onTap: () => _launchURL(context, contactEmailLink, isEmail: true),
          title: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'home.drawer.contact_prefix'.tr()),
                TextSpan(
                  text: contactEmailLink,
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ],
            ),
            style: TextStyle(color: color),
          ),
        ),
        ListTile(
          onTap: () => _launchURL(context, fakeLink),
          title: Text(
            'home.drawer.report'.tr(),
            style: TextStyle(color: color),
          ),
        ),
        ListTile(
          onTap: () => _launchURL(context, fakeLink),
          title: Text(
            'home.drawer.win'.tr(),
            style: TextStyle(color: color),
          ),
        ),
      ],
    );
  }

  Future<bool> _launchURL(
    BuildContext context,
    String url, {
    bool isEmail = false,
  }) async {
    if (isEmail) url = Mailto(to: [url]).toString();
    if (await canLaunch(url)) {
      return await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return PingnaAlertDialog(
            title: 'dev.not_built_yet'.tr(),
            showCancel: false,
            confirmText: 'app.btn.sure'.tr(),
          );
        },
      );
      throw 'Could not launch $url';
    }
  }
}
