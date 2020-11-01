import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/models/user.dart';
import 'package:pingna/resources/widgets/forms/search_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key key, @required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      // TODO: Make expandedHeight dynamic based on device text size
      expandedHeight: 120,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: ListTile(
          dense: true,
          title: Text(
            'home.greeting'.tr(args: [user.name]),
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text('home.subtitle'.tr()),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(4.0),
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.only(bottom: 4.0),
          child: SearchButton(),
        ),
      ),
    );
  }
}
