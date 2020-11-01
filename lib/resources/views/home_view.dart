import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:pingna/core/models/user.dart';

import 'package:pingna/resources/assets.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Icon(Icons.menu),
        actionsIconTheme: Theme.of(context).iconTheme,
        actions: [
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.pin_drop_outlined),
                if (user.postCode != null)
                  Text(
                    user.postCode,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
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
                child: ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: lightcharcoalColor),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Theme.of(context).textTheme.bodyText2.color,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'home.search'.tr(),
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // bottom: PreferredSize(
          //   preferredSize: Size.fromHeight(60),
          //   child: ListTile(
          //     title: Text(
          //       'home.greeting'.tr(args: [user.name]),
          //       style: Theme.of(context).textTheme.headline5,
          //     ),
          //     subtitle: Text('home.subtitle'.tr()),
          //   ),
          // ),
          // flexibleSpace: FlexibleSpaceBar(
          //   stretchModes: [],
          //   title: ListTile(
          //     title: Text(
          //       'home.greeting'.tr(args: [user.name]),
          //       style: Theme.of(context).textTheme.headline5,
          //     ),
          //     subtitle: Text('home.subtitle'.tr()),
          //   ),
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     ListTile(
          //       title: Text(
          //         'home.greeting'.tr(args: [user.name]),
          //         style: Theme.of(context).textTheme.headline5,
          //       ),
          //       subtitle: Text('home.subtitle'.tr()),
          //     ),
          //     TextFormField(),
          //   ],
          // ),
          // Display a placeholder widget to visualize the shrinking size.
          // flexibleSpace: Placeholder(),/
          // Make the initial height of the SliverAppBar larger than normal.
          // collapsedHeight: 60,
          // expandedHeight: 200,

          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Placeholder();
            }, childCount: 3),
          )
        ],
      ),
      // TODO: Use FAB as basket icon if one is active
    );
  }
}

// body: Center(
//   child: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: <Widget>[
//       Text(
//         context.watch<User>().firstName,
//         style: Theme.of(context).textTheme.headline4,
//       ),
//       Text(context.watch<User>().email),
//     ],
//   ),
// ),
